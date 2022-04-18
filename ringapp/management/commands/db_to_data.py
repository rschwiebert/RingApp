#! /usr/bin/env python
import io
import tempfile

import yaml
import re
import json
import os
from copy import deepcopy
import sys

from abc import ABC, abstractmethod
from functools import partial
from typing import List, Sequence

from django.core.management import call_command
from django.core.management.base import BaseCommand, CommandError


sidetype_choices = [(0, ''),
                    (1, 'left and right'),
                    (2, 'left'),
                    (3, 'right'),
                    (4, 'left or right'), ]

ROOT_DIR = '/Users/ryanschwiebert/PycharmProjects/dart-data/'


def tag(prefix: str = "", pk: int = 0):
    return f'{prefix}_{pk:0>6d}'


def ids_to_tags(prefix: str, data: Sequence[int]) -> List[str]:
    return list(map(partial(tag, prefix), data))


def tag_to_id(tagstring):
    return int(tagstring.split('_')[1])


def tags_to_ids(data: Sequence[str]):
    return [int(_.split('_')[1]) for _ in data]


SIDETYPENUM_TO_DISPLAY = {k: v.replace(' ', '_').upper() for (k, v) in sidetype_choices}
SIDETYPEDISPLAY_TO_NUM = {v: k for (k, v) in SIDETYPENUM_TO_DISPLAY.items()}


class SerializerBase(ABC):
    prefix: str = ""
    modelkey: str = ""

    @abstractmethod
    def filename(self, *args):
        pass

    @abstractmethod
    def to_storage(self, *args):
        pass

    @abstractmethod
    def to_dbjson(self, *args):
        pass

    @abstractmethod
    def get_keys(self, *args):
        pass


class Serializer(SerializerBase):
    leaf = True

    def to_dbjson(self, data):
        return data

    def to_storage(self, fields):
        return fields

    def filename(self, pk):
        directory = os.path.join(ROOT_DIR, *self.modelkey.split('.'))
        path = os.path.join(directory, f'{self.prefix}_{pk:0>6d}.yaml')
        if self.leaf is False:
            return os.path.join(os.path.splitext(path)[0], 'data.yaml')
        else:
            return path

    @property
    def regex(self):
        sample_path = self.filename(1)
        regex_string = sample_path.replace(tag(self.prefix, 1),  '(' + self.prefix + '_[0-9]{6})')
        regex_string = regex_string.removeprefix(ROOT_DIR)
        return re.compile(regex_string)

    def data_to_file(self, pk, data):
        path = self.filename(pk)
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, 'w') as f:
            f.write(yaml.dump(data))
        return path

    def process_to_storage(self, obj):
        keys = self.get_keys(obj)
        data = self.to_storage(obj['fields'])
        return self.data_to_file(keys['pk'], data)

    def get_keys(self, obj):
        return dict(pk=int(obj['pk']))

    def process_from_storage(self, path):
        mat = self.regex.search(path)

        if mat is None:
            raise Exception
        pk = tag_to_id(mat.groups()[0])
        original_data = dict(model=self.modelkey,
                             pk=pk)
        with open(path) as f:
            stored = yaml.load(f, yaml.Loader)

        restored = self.to_dbjson(stored)
        original_data['fields'] = restored
        return original_data


class Subserializer(SerializerBase):
    parent_serializer = None
    foreign_serializer = None
    subfolder: str = ""
    parent_key_name = ""
    foreign_key_name = ""

    @property
    def prefix(self):
        return self.foreign_serializer.prefix

    def filename(self, keys):
        parent_dir = os.path.dirname(self.parent_serializer.filename(keys['parent_pk']))
        return os.path.join(parent_dir, self.subfolder,
                            f"{tag(self.foreign_serializer.prefix, keys['foreign_pk'])}.yaml")

    def data_to_file(self, keys, data):
        path = self.filename(keys)
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, 'w') as f:
            f.write(yaml.dump(data))
        return path

    def to_storage(self, fields, keys):
        return fields

    def to_dbjson(self, data, parent_pk, foreign_pk):
        return data

    def get_keys(self, obj):
        return dict(
            crosstable_pk=int(obj['pk']),
            parent_pk=int(obj['fields'][self.parent_key_name]),
            foreign_pk=int(obj['fields'][self.foreign_key_name])
        )

    def process_to_storage(self, obj):
        keys = self.get_keys(obj)
        data = self.to_storage(obj['fields'], keys)
        return self.data_to_file(keys, data)

    @property
    def regex(self):
        sample_path = self.filename(dict(parent_pk=1, foreign_pk=1))
        regex_string = sample_path.replace(tag(self.parent_serializer.prefix, 1),
                                           '(' + self.parent_serializer.prefix + '_[0-9]{6})')
        regex_string = regex_string.replace(tag(self.foreign_serializer.prefix, 1),
                                            '(' + self.foreign_serializer.prefix + '_[0-9]{6})')
        regex_string = regex_string.removeprefix(ROOT_DIR)
        return re.compile(regex_string)

    def process_from_storage(self, path):
        mat = self.regex.search(path)
        if mat is None:
            raise Exception
        pks = tags_to_ids(mat.groups())
        parent_pk, foreign_pk = pks
        original_data = dict(model=self.modelkey)
        with open(path) as f:
            stored = yaml.load(f, yaml.Loader)

        restored = self.to_dbjson(stored, parent_pk, foreign_pk)
        pk = restored.pop('crosstable_pk')
        original_data['fields'] = restored
        original_data['pk'] = pk
        return original_data


class RingSerializer(Serializer):
    modelkey = 'ringapp.ring'
    prefix = "RING"
    leaf = False

    def to_storage(self, fields):
        fields['citation'] = ids_to_tags(CitationSerializer.prefix, fields['citation'])
        fields['keywords'] = ids_to_tags(KeywordSerializer.prefix, fields['keywords'])
        return fields

    def to_dbjson(self, data):
        data['citation'] = tags_to_ids(data['citation'])
        data['keywords'] = tags_to_ids(data['keywords'])
        return data


class PropertySerializer(Serializer):
    prefix = 'PROP'
    modelkey = 'ringapp.property'
    leaf = False

    def to_storage(self, fields):
        fields['citation'] = ids_to_tags(CitationSerializer.prefix, fields['citation'])
        return fields

    def to_dbjson(self, data):
        data['citation'] = tags_to_ids(data['citation'])
        return data


class RingPropertySerializer(Subserializer):
    modelkey = 'ringapp.ringproperty'
    parent_serializer = RingSerializer()
    foreign_serializer = PropertySerializer()
    subfolder = "properties"
    parent_key_name = 'ring'
    foreign_key_name = 'property'

    def to_storage(self, fields, keys):
        fields['crosstable_pk'] = keys['crosstable_pk']
        fields['citation_left'] = ids_to_tags(CitationSerializer.prefix, fields['citation_left'])
        fields['citation_right'] = ids_to_tags(CitationSerializer.prefix, fields['citation_right'])
        fields['property'] = tag(PropertySerializer.prefix, fields['property'])
        fields['ring'] = tag(RingSerializer.prefix, fields['ring'])
        return fields

    def to_dbjson(self, data, parent_pk, foreign_pk):
        data['ring'] = parent_pk
        data['property'] = foreign_pk
        data['citation_left'] = tags_to_ids(data['citation_left'])
        data['citation_right'] = tags_to_ids(data['citation_right'])
        return data


class KeywordSerializer(Serializer):
    prefix = 'KWD'
    modelkey = 'ringapp.keyword'


class MetaPropertySerializer(Serializer):
    prefix = 'METAPROP'
    modelkey = 'ringapp.metaproperty'


class PropMetapropSubSerializer(Subserializer):
    modelkey = 'ringapp.propertymetaproperty'
    parent_serializer = PropertySerializer()
    foreign_serializer = MetaPropertySerializer()
    subfolder = "metaproperties"
    parent_key_name = 'property'
    foreign_key_name = 'metaproperty'

    def to_storage(self, fields, keys):
        fields['crosstable_pk'] = keys['crosstable_pk']

        fields['property'] = tag(PropertySerializer.prefix, fields['property'])
        fields['metaproperty'] = tag(MetaPropertySerializer.prefix, fields['metaproperty'])
        if fields['example']:
            fields['example'] = tag(RingSerializer.prefix, fields['example'])
        return fields

    def to_dbjson(self, data, parent_pk, foreign_pk):
        data['property'] = tag_to_id(data['property'])
        data['metaproperty'] = tag_to_id(data['metaproperty'])
        if data['example'] is not None:
            data['example'] = tag_to_id(data['example'])

        return data


class CitationSerializer(Serializer):
    prefix = 'CITE'
    modelkey = 'ringapp.citation'

    def to_storage(self, fields):
        fields['publication'] = tag(prefix=PublicationSerializer.prefix, pk=fields['publication'])
        return fields

    def to_dbjson(self, data):
        data['publication'] = tag_to_id(data['publication'])
        return data


class PublicationSerializer(Serializer):
    prefix = 'PUB'
    modelkey = 'publications.publication'

    def to_storage(self, fields):
        fields['type'] = tag(PublicationTypeSerializer.prefix, fields['type'])
        return fields

    def to_dbjson(self, data):
        data['type'] = tag_to_id(data['type'])
        return data


class PublicationListSerializer(Serializer):
    prefix = 'PUBLIST'
    modelkey = 'publications.list'


class PublicationTypeSerializer(Serializer):
    prefix = 'PUBTYPE'
    modelkey = 'publications.type'


class PropertySideSerializer(Serializer):
    prefix = 'PSIDE'
    modelkey = 'ringapp.propertyside'

    def to_storage(self, fields):
        fields['property'] = tag(PropertySerializer.prefix, fields['property'])
        fields['side'] = SIDETYPENUM_TO_DISPLAY[fields['side']]
        return fields

    def to_dbjson(self, data):
        data['property'] = tag_to_id(data['property'])
        data['side'] = SIDETYPEDISPLAY_TO_NUM[data['side']]
        return data


class LogicSerializer(Serializer):
    prefix = 'LOG'
    modelkey = 'ringapp.logic'

    def to_storage(self, fields):
        fields['citation'] = ids_to_tags(CitationSerializer.prefix, fields['citation'])
        fields['hyps'] = ids_to_tags(PropertySideSerializer.prefix, fields['hyps'])
        fields['concs'] = ids_to_tags(PropertySideSerializer.prefix, fields['concs'])
        return fields

    def to_dbjson(self, data):
        data['citation'] = tags_to_ids(data['citation'])
        data['hyps'] = tags_to_ids(data['hyps'])
        data['concs'] = tags_to_ids(data['concs'])
        return data


class TheoremSerializer(Serializer):
    prefix = 'THM'
    modelkey = 'ringapp.theorem'

    def to_storage(self, fields):
        fields['categories'] = ids_to_tags(TheoremCategorySerializer.prefix, fields['categories'])
        fields['citation'] = ids_to_tags(CitationSerializer.prefix, fields['citation'])
        return fields

    def to_dbjson(self, data):
        data['categories'] = tags_to_ids(data['categories'])
        data['citation'] = tags_to_ids(data['citation'])
        return data


class TheoremCategorySerializer(Serializer):
    prefix = 'THMCAT'
    modelkey = 'ringapp.theoremcategory'


class DimensionSerializer(Serializer):
    prefix = 'DIM'
    modelkey = 'ringapp.dimension'


class RingDimensionSerializer(Subserializer):
    modelkey = 'ringapp.ringdimension'
    parent_serializer = RingSerializer()
    foreign_serializer = DimensionSerializer()
    subfolder = "dimensions"
    parent_key_name = 'ring'
    foreign_key_name = 'dimension_type'

    def to_storage(self, fields, keys):
        fields['crosstable_pk'] = keys['crosstable_pk']
        fields['citation'] = ids_to_tags(CitationSerializer.prefix, fields['citation'])
        fields['ring'] = tag(RingSerializer.prefix, fields['ring'])
        fields['dimension_type'] = tag(DimensionSerializer.prefix, fields['dimension_type'])

        return fields

    def to_dbjson(self, data, parent_key, foreign_key):
        data['citation'] = tags_to_ids(data['citation'])
        data['ring'] = tag_to_id(data['ring'])
        data['dimension_type'] = tag_to_id(data['dimension_type'])
        return data


class SubsetSerializer(Serializer):
    prefix = 'SUBSET'
    modelkey = 'ringapp.subset'


class RingSubsetSerializer(Subserializer):
    modelkey = 'ringapp.ringsubset'
    parent_serializer = RingSerializer()
    foreign_serializer = SubsetSerializer()
    subfolder = "subsets"
    parent_key_name = 'ring'
    foreign_key_name = 'subset_type'

    def to_storage(self, fields, keys):
        fields['crosstable_pk'] = keys['crosstable_pk']
        fields['citation'] = ids_to_tags(CitationSerializer.prefix, fields['citation'])
        fields['ring'] = tag(RingSerializer.prefix, fields['ring'])
        fields['subset_type'] = tag(SubsetSerializer.prefix, fields['subset_type'])
        return fields

    def to_dbjson(self, data, parent_pk, foreign_pk):
        data['citation'] = tags_to_ids(data['citation'])
        data['ring'] = tag_to_id(data['ring'])
        data['subset_type'] = tag_to_id(data['subset_type'])
        return data


class ErratumSerializer(Serializer):
    prefix = 'ERR'
    modelkey = 'ringapp.erratum'

    def to_storage(self, fields):
        fields['error_location'] = tag(CitationSerializer.prefix, fields['error_location'])
        fields['corrected_location'] = ids_to_tags(CitationSerializer.prefix, fields['corrected_location'])
        ring = fields.get('example')
        if ring is not None:
            fields['example'] = tag(RingSerializer.prefix, fields['example'])
        return fields

    def to_dbjson(self, data):
        data['error_location'] = tag_to_id(data['error_location'])
        data['corrected_location'] = tags_to_ids(data['corrected_location'])
        if data['example'] is not None:
            data['example'] = tag_to_id(data['example'])

        return data


serializers = [
    KeywordSerializer,
    DimensionSerializer,
    SubsetSerializer,
    RingSerializer,
    PropertySerializer,
    RingPropertySerializer,
    MetaPropertySerializer,
    PropMetapropSubSerializer,
    CitationSerializer,
    PublicationSerializer,
    PublicationListSerializer,
    PublicationTypeSerializer,
    LogicSerializer,
    PropertySideSerializer,
    TheoremSerializer,
    ErratumSerializer,
    RingSubsetSerializer,
    RingDimensionSerializer,
    TheoremCategorySerializer,
]

serializers = {cls.modelkey: cls() for cls in serializers}


class Command(BaseCommand):

    def add_arguments(self, parser):
        subparsers = parser.add_subparsers(dest='command')
        import_parser = subparsers.add_parser('import', help='file to database')
        export_parser = subparsers.add_parser('export', help='database to file')
        test_parser = subparsers.add_parser('test', help='database to file')

        import_parser.add_argument('path', nargs='+')

    def handle(self, *args, **options):
        if options.get('command') == 'export':
            output = io.StringIO()
            call_command('dumpdata', database='ringapp_data', format='jsonl',
                         stdout=output, settings=options.get('settings'))
            end = output.tell()
            output.seek(0)
            while output.tell() < end:
                item = json.loads(output.readline().strip())
                modelname = item.get('model')
                serializer = serializers.get(modelname, None)
                if serializer is None:
                    print(f'Need serializer for {modelname}')
                    continue
                serializer.process_to_storage(item)

        elif options.get('command') == 'import':
            lines = []
            for path in options.get('path'):
                print(path)
                for model, serializer in serializers.items():
                    print(f"matching against {serializer.regex.pattern}")
                    match = serializer.regex.search(path)
                    if match is not None:
                        data = serializer.process_from_storage(path)
                        lines.append(json.dumps(data, sort_keys=True) + '\n')
                        break

            with tempfile.NamedTemporaryFile(mode='r+', dir=os.getcwd(), suffix='.jsonl') as f:
                for line in lines:
                    f.write(line)
                f.flush()
                call_command('loaddata', f.name, database='ringapp_data', settings=options.get('settings'))

        elif options.get('command') == 'test':
            for mname in serializers.keys():
                print(f'checking {mname}')
                output = io.StringIO()
                call_command('dumpdata', mname, pks='1,3', database='ringapp_data',
                             format='jsonl', settings=options.get('settings'), stdout=output)
                end = output.tell()
                output.seek(0)
                while output.tell() < end:
                    item = json.loads(output.readline().strip())
                    original = deepcopy(item)
                    modelname = item.get('model')
                    serializer = serializers.get(modelname, None)
                    if serializer is None:
                        print(f'Need serializer for {modelname}')
                        continue
                    path = serializer.process_to_storage(item)
                    recovered = serializer.process_from_storage(path)
                    assert recovered == original
                    print('...checked out')
