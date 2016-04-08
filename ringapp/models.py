from __future__ import unicode_literals
from django.db import models
from django.contrib.auth.models import User

# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Remove `managed = False` lines for those models you wish to give write DB access
# Feel free to rename the models, but don't rename db_table values or field names.

def rewriteName(st):
    """Makes database property names with (left)/(right) a little more readable."""
    if st[-7:] == ' (left)':
        return 'left %s' % st[:-7]
    elif st[-8:] == ' (right)':
        return 'right %s' % st[:-8]
    else:
        return st


class Keyword(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    name = models.CharField(max_length=50)

    class Meta:
        # managed = False
        db_table = 'keywords'

    def __unicode__(self):  # Python 3: def __str__(self):
        return self.name


class Publication(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    title = models.CharField(max_length=100)
    authors = models.CharField(max_length=50)
    details = models.CharField(max_length=100, null=True, blank=True)
    pub_date = models.DateField()
    poster = models.CharField(max_length=30)
    time = models.DateTimeField(auto_now_add=True)

    class Meta:
        # managed = False
        db_table = 'publications'

    def __unicode__(self):  # Python 3: def __str__(self):
        return "%s (%d)" % (self.title, self.pub_date.year)


class Citation(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    publication = models.ForeignKey(Publication)  # Field name made lowercase.
    location = models.CharField(max_length=50)
    poster = models.CharField(max_length=30)
    time = models.DateTimeField(auto_now_add=True)

    class Meta:
        # managed = False
        db_table = 'citations'

    def __unicode__(self):  # Python 3: def __str__(self):
        return str(self.publication.title)+","+str(self.location)


class CommProperty(models.Model):
    property_id = models.AutoField(db_column='property_ID', unique=True, primary_key=True)  # Field name made lowercase.
    name = models.CharField(max_length=250)
    definition = models.CharField(max_length=500)
    poster = models.CharField(max_length=25, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'comm_properties'
        verbose_name_plural = 'Commutative ring properties'

    def __unicode__(self):  # Python 3: def __str__(self):
        return self.name


class Property(models.Model):
    property_id = models.AutoField(db_column='property_ID', unique=True, primary_key=True)  # Field name made lowercase.
    name = models.CharField(max_length=250)
    definition = models.CharField(max_length=500)
    poster = models.CharField(max_length=25, blank=True, null=True)
    comm_version = models.ForeignKey(CommProperty, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'properties'
        verbose_name_plural = 'Ring properties'

    def __unicode__(self):  # Python 3: def __str__(self):
        return self.name


class Theorem(models.Model):
    theorem_id = models.AutoField(db_column='theorem_id', unique=True, primary_key=True)  # Field name made lowercase.
    alias = models.CharField(max_length=100, null=True, blank=True)
    statement = models.CharField(max_length=400)
    reference = models.ManyToManyField(Citation, verbose_name="theorem reference")
    link = models.URLField(blank=True, null=True)
    poster = models.CharField(max_length=25, blank=True, null=True)
    time = models.DateTimeField(auto_now_add=True)
    characterizes = models.ForeignKey(Property, null=True, blank=True)
    comm_characterizes = models.ForeignKey(CommProperty, null=True, blank=True)

    class Meta:
        # managed = False
        db_table = 'theorems'

    def __unicode__(self):  # Python 3: def __str__(self):
        if self.alias:
            return self.alias
        else:
            if len(self.statement) < 100:
                return self.statement
            else:
                return self.statement[:100] + '...'


class Logic(models.Model):
    logic_id = models.AutoField(db_column='logic_ID', unique=True, primary_key=True)  # Field name made lowercase.
    entry_type = models.IntegerField(blank=True, null=True)
    cond_1 = models.IntegerField(blank=True, null=True)
    cond_2 = models.IntegerField(blank=True, null=True)
    cond_3 = models.IntegerField(blank=True, null=True)
    cond_4 = models.IntegerField(blank=True, null=True)
    conc = models.IntegerField(blank=True, null=True)
    option = models.CharField(max_length=200, blank=True)
    citation = models.CharField(max_length=200, blank=True, null=True)
    theorem = models.ForeignKey(Theorem, db_column='theorem_id', blank=True, null=True)
    poster = models.CharField(max_length=25, blank=True, null=True)
    readable = models.CharField(max_length=120, blank=True, null=True)
    
    class Meta:
        # managed = False
        db_table = 'logic'

    def save(self, *args, **kwargs):
        self.option = 'on'
        conds = [self.cond_1, self.cond_2, self.cond_3, self.cond_4]
        conds = filter(lambda x: x is not None, conds)
        self.entry_type = len(conds)
        conc = self.conc
        readable_conds = [Property.objects.get(pk=i).name for i in conds]
        readable_conds = map(rewriteName, readable_conds)
        readable_conc = rewriteName(Property.objects.get(pk=conc).name)
        output = " and ".join(readable_conds) + " implies %s" % readable_conc
        self.readable = output
        super(Logic, self).save(*args, **kwargs)

    def __unicode__(self):  # Python 3: def __str__(self):
        if self.readable is not None and self.readable != '':
            return self.readable
        else:
            return "Set readable field for this entry!"


class CommLogic(models.Model):
    logic_id = models.AutoField(db_column='logic_ID', unique=True, primary_key=True)  # Field name made lowercase.
    entry_type = models.IntegerField(blank=True, null=True)
    cond_1 = models.IntegerField(blank=True, null=True)
    cond_2 = models.IntegerField(blank=True, null=True)
    cond_3 = models.IntegerField(blank=True, null=True)
    cond_4 = models.IntegerField(blank=True, null=True)
    conc = models.IntegerField(blank=True, null=True)
    option = models.CharField(max_length=200, blank=True)
    citation = models.CharField(max_length=200, blank=True)
    theorem = models.ForeignKey(Theorem, db_column='theorem_id', blank=True, null=True)
    poster = models.CharField(max_length=25, blank=True, null=True)
    readable = models.CharField(max_length=120, blank=True, null=True)
    
    class Meta:
        # managed = False
        db_table = 'comm_logic'

    def save(self, *args, **kwargs):
        self.option = 'on'
        conds = [self.cond_1, self.cond_2, self.cond_3, self.cond_4]
        conds = filter(lambda x: x is not None, conds)
        self.entry_type = len(conds)
        conc = self.conc
        readable_conds = [CommProperty.objects.get(pk=i).name for i in conds]
        readable_conc = CommProperty.objects.get(pk=conc).name
        output = " and ".join(readable_conds) + " implies %s" % readable_conc
        self.readable = output
        super(CommLogic, self).save(*args, **kwargs)

    def __unicode__(self):  # Python 3: def __str__(self):
        if self.readable is not None and self.readable != '':
            return self.readable
        else:
            return "Set readable field for this entry!"
        
        
class Ring(models.Model):
    ring_id = models.AutoField(db_column='ring_ID', unique=True, primary_key=True)  # Field name made lowercase.
    name = models.CharField(max_length=250)
    description = models.CharField(max_length=1000)
    kwds = models.CharField(max_length=200, blank=True, null=True)
    keywords = models.ManyToManyField(Keyword, verbose_name="ring keywords", blank=True)
    old_reference = models.CharField(max_length=500)
    notes = models.CharField(max_length=500, blank=True, null=True)
    poster = models.CharField(max_length=25, blank=True, null=True)
    reference = models.ManyToManyField(Citation, verbose_name="ring reference", blank=True)

    class Meta:
        # managed = False
        db_table = 'rings'
    
    def __unicode__(self):  # Python 3: def __str__(self):
        return self.name


class CommRing(Ring):
    class Meta:
        # managed = False
        db_table = 'rings'
        proxy = True
        verbose_name_plural = 'Commutative rings'


class RingProperty(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    ring = models.ForeignKey(Ring, db_column='ring_ID', blank=True, null=True)  # Field name made lowercase.
    property = models.ForeignKey(Property, db_column='property_ID', blank=True, null=True)  # Field name made lowercase.
    has_property = models.IntegerField(blank=True, null=True)
    reason = models.CharField(max_length=200, blank=True, null=True)
    source = models.CharField(max_length=500, blank=True, null=True)
    poster = models.CharField(max_length=25, blank=True, null=True)
    time = models.DateTimeField(auto_now_add=True, null=True)

    def save(self, *args, **kwargs):
        if self.property.comm_version is not None\
            and self.ring.ringproperty_set.filter(ring=self.ring,
                                                  property=Property.objects.get(name='commutative')).exists()\
            and self.ring.ringproperty_set.get(ring=self.ring,
                                               property=Property.objects.get(name='commutative')).has_property == 1\
            and not CommRingProperty.objects.filter(ring=self.ring,
                                                    property=self.property.comm_version).exists():
            CommRingProperty.objects.create(ring=self.ring,
                                            property=self.property.comm_version,
                                            has_property=self.has_property,
                                            reason=self.reason,
                                            source=self.source,
                                            poster=self.poster)
        super(RingProperty, self).save(*args, **kwargs)

    class Meta:
        # managed = False
        db_table = 'ring_property'
        verbose_name_plural = 'Ring-property relationships'
    
    def __unicode__(self):  # Python 3: def __str__(self):
        if self.has_property == 1:        
            return "%s is %s" % (self.ring.name, self.property.name)
        elif self.has_property == 0:
            return "%s is not %s" % (self.ring.name, self.property.name)
        else:
            return "A bug occurred in RingProperty unicode method."


class CommRingProperty(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)  # get this to autoincrement properly
    ring = models.ForeignKey(Ring, db_column='ring_ID', blank=True, null=True)  # Field name made lowercase.
    property = models.ForeignKey(CommProperty, db_column='property_ID',
                                 blank=True, null=True)  # Field name made lowercase.
    has_property = models.IntegerField(blank=True, null=True)
    reason = models.CharField(max_length=200, blank=True, null=True)
    source = models.CharField(max_length=500, blank=True, null=True)
    poster = models.CharField(max_length=25, blank=True, null=True)
    time = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        # managed = False
        db_table = 'comm_ring_property'
        verbose_name_plural = 'Commutative ring-property relationships'

    def __unicode__(self):  # Python 3: def __str__(self):
        if self.has_property == 1:        
            return "%s is %s" % (self.ring.name, self.property.name)
        elif self.has_property == 0:
            return "%s is not %s" % (self.ring.name, self.property.name)
        else:
            return "A bug occurred in CommRingProperty unicode method."
        
        
class Equivalents(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    property = models.ForeignKey(Property, db_column='property_ID', blank=True, null=True)  # Field name made lowercase.
    equivalent = models.CharField(max_length=500)
    kwds = models.CharField(max_length=200)
    source = models.CharField(max_length=100)
    poster = models.CharField(max_length=30, blank=True, null=True)
    
    class Meta:
        # managed = False
        db_table = 'equivalents'
    
    def __unicode__(self):  # Python 3: def __str__(self):
        return str(self.property.name)+"\t"+str(self.equivalent)


class CommEquivalents(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    property = models.ForeignKey(CommProperty, db_column='property_ID',
                                 blank=True, null=True)  # Field name made lowercase.
    equivalent = models.CharField(max_length=500)
    kwds = models.CharField(max_length=200)
    source = models.CharField(max_length=100)
    poster = models.CharField(max_length=30, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'comm_equivalents'

    def __unicode__(self):  # Python 3: def __str__(self):
        return str(self.property.name)+"\t"+str(self.equivalent)


class Metaproperty(models.Model):
    type_id = models.AutoField(null=False, unique=True, primary_key=True)
    description = models.CharField(max_length=100)

    class Meta:
        # managed = False
        db_table = 'metaproperty'
        verbose_name_plural = 'Metaproperties'

    def __unicode__(self):  # Python 3: def __str__(self):
        return self.description


class Invariance(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    property = models.ForeignKey(Property, db_column='property_ID')
    metaproperty = models.ForeignKey(Metaproperty, db_column='type_id')
    has_metaproperty = models.BooleanField(default=None, null=False)
    example = models.ForeignKey(Ring, blank=True, null=True, db_column='ring_ID')
    theorem = models.ForeignKey(Theorem, blank=True, null=True, db_column='theorem_id')
    note = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'property_metaproperty'
        verbose_name_plural = 'Property-metaproperty relationships'

    def __unicode__(self):  # Python 3: def __str__(self):
        if self.has_metaproperty:
            return "%s : %s" % (self.property.name, self.metaproperty.description)
        else:
            return "%s : not %s" % (self.property.name, self.metaproperty.description)


class CommInvariance(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    property = models.ForeignKey(CommProperty, db_column='property_ID')
    metaproperty = models.ForeignKey(Metaproperty, db_column='type_id')
    has_metaproperty = models.BooleanField(default=None, null=False)
    example = models.ForeignKey(Ring, blank=True, null=True, db_column='ring_ID')
    theorem = models.ForeignKey(Theorem, blank=True, null=True, db_column='theorem_id')
    note = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'comm_property_metaproperty'
        verbose_name_plural = 'Commutative property-metaproperty relationships'

    def __unicode__(self):  # Python 3: def __str__(self):
        if self.has_metaproperty:
            return "%s : %s" % (self.property.name, self.metaproperty.description)
        else:
            return "%s : not %s" % (self.property.name, self.metaproperty.description)


class Glossary(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    term = models.CharField(max_length=100, blank=True, null=True)
    definition = models.CharField(max_length=400, blank=True, null=True)
    reference = models.ManyToManyField(Citation, verbose_name="glossary reference", blank=True)

    class Meta:
        # managed = False
        db_table = 'glossary'
        verbose_name_plural = 'Glossary entries'

    def __unicode__(self):  # Python 3: def __str__(self):
        return self.term


class FAQ(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    question = models.CharField(max_length=200, blank=True, null=True)
    answer = models.CharField(max_length=400, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'faq'

    def __unicode__(self):  # Python 3: def __str__(self):
        return self.question


class Suggestion(models.Model):
    object_type = models.SmallIntegerField(choices=[(0, 'ring'),
                                                    (1, 'citation'),
                                                    (1, 'theorem'),
])
    status = models.SmallIntegerField(choices=[(-2, 'need info'),
                                               (-1, 'declined'),
                                               (0, 'pending'),
                                               (1, 'accepted'),
                                               (2, 'withdrawn'),],
                                      default=0)
    name = models.CharField(max_length=50, null=True, blank=True)
    description = models.CharField(max_length=400, null=True, blank=True)
    citation = models.CharField(max_length=100, null=True, blank=True)
    user = models.ForeignKey(User)

    def __unicode__(self):
        return '%s %s %s' % (self.get_object_type_display(), self.description, self.user.username)


class test_Ring(models.Model):
    ring_id = models.AutoField(db_column='ring_ID', unique=True, primary_key=True)  # Field name made lowercase.
    name = models.CharField(max_length=250)
    description = models.CharField(max_length=1000)

    class Meta:
        # managed = False
        db_table = 'test_rings'

    def __unicode__(self):  # Python 3: def __str__(self):
        return self.name


class test_RingProperty(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    ring = models.ForeignKey(test_Ring, db_column='ring_ID', blank=True, null=True)  # Field name made lowercase.
    property = models.ForeignKey(Property, db_column='property_ID', blank=True, null=True)  # Field name made lowercase.
    has_property = models.IntegerField(blank=True, null=True)
    reason = models.CharField(max_length=200)
    source = models.CharField(max_length=500)
    poster = models.CharField(max_length=25, blank=True, null=True)
    time = models.DateTimeField(auto_now_add=True, null=True)

    class Meta:
        # managed = False
        db_table = 'test_ring_property'

    def __unicode__(self):  # Python 3: def __str__(self):
        if self.has_property == 1:
            return "%s is %s" % (self.ring.name, self.property.name)
        elif self.has_property == 0:
            return "%s is not %s" % (self.ring.name, self.property.name)
        else:
            return "A bug occurred in RingProperty unicode method."
