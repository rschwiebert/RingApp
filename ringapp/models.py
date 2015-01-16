from __future__ import unicode_literals
from django.db import models

# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Remove `managed = False` lines for those models you wish to give write DB access
# Feel free to rename the models, but don't rename db_table values or field names.


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


class Property(models.Model):
    property_id = models.AutoField(db_column='property_ID', unique=True, primary_key=True)  # Field name made lowercase.
    name = models.CharField(max_length=250)
    definition = models.CharField(max_length=500)
    poster = models.CharField(max_length=25, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'properties'

    def __unicode__(self):  # Python 3: def __str__(self):
        return self.name


class CommProperty(models.Model):
    property_id = models.AutoField(db_column='property_ID', unique=True, primary_key=True)  # Field name made lowercase.
    name = models.CharField(max_length=250)
    definition = models.CharField(max_length=500)
    poster = models.CharField(max_length=25, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'comm_properties'

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
    characterizes = models.ForeignKey(Property, null=True)
    comm_characterizes = models.ForeignKey(CommProperty, null=True)

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
    
    def __unicode__(self):  # Python 3: def __str__(self):
        if self.readable is not None and self.readable != '':
            return self.readable
        else:
            return "Set readable field for this entry!"
        
        
class Ring(models.Model):
    ring_id = models.AutoField(db_column='ring_ID', unique=True, primary_key=True)  # Field name made lowercase.
    name = models.CharField(max_length=250)
    description = models.CharField(max_length=1000)
    kwds = models.CharField(max_length=200)
    keywords = models.ManyToManyField(Keyword, verbose_name="ring keywords")
    reference = models.CharField(max_length=500)
    notes = models.CharField(max_length=500, blank=True, null=True)
    poster = models.CharField(max_length=25, blank=True, null=True)
    
    class Meta:
        # managed = False
        db_table = 'rings'
    
    def __unicode__(self):  # Python 3: def __str__(self):
        return self.name        

        
class RingProperty(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    ring = models.ForeignKey(Ring, db_column='ring_ID', blank=True, null=True)  # Field name made lowercase.
    property = models.ForeignKey(Property, db_column='property_ID', blank=True, null=True)  # Field name made lowercase.
    has_property = models.IntegerField(blank=True, null=True)
    reason = models.CharField(max_length=200)
    source = models.CharField(max_length=500)
    poster = models.CharField(max_length=25, blank=True, null=True)
    time = models.DateTimeField(auto_now_add=True, null=True)
    
    class Meta:
        # managed = False
        db_table = 'ring_property'
    
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
    reason = models.CharField(max_length=200)
    source = models.CharField(max_length=500)
    poster = models.CharField(max_length=25, blank=True, null=True)
    time = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        # managed = False
        db_table = 'comm_ring_property'
    
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


class InvariantType(models.Model):
    type_id = models.AutoField(null=False, unique=True, primary_key=True)
    description = models.CharField(max_length=100)

    class Meta:
        # managed = False
        db_table = 'invariant_types'

    def __unicode__(self):  # Python 3: def __str__(self):
        return self.description


class Invariance(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    property = models.ForeignKey(Property, db_column='property_ID')
    invarianttype = models.ForeignKey(InvariantType, db_column='type_id')
    is_invariant = models.BooleanField(default=None, null=False)
    example = models.ForeignKey(Ring, blank=True, null=True, db_column='ring_ID')
    theorem = models.ForeignKey(Theorem, blank=True, null=True, db_column='theorem_id')
    note = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'invariance'

    def __unicode__(self):  # Python 3: def __str__(self):
        if self.is_invariant:
            return "%s : %s" % (self.property.name, self.invarianttype.description)
        else:
            return "%s : not %s" % (self.property.name, self.invarianttype.description)


class CommInvariance(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    property = models.ForeignKey(CommProperty, db_column='property_ID')
    invarianttype = models.ForeignKey(InvariantType, db_column='type_id')
    is_invariant = models.BooleanField(default=None, null=False)
    example = models.ForeignKey(Ring, blank=True, null=True, db_column='ring_ID')
    theorem = models.ForeignKey(Theorem, blank=True, null=True, db_column='theorem_id')
    note = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'comm_invariance'

    def __unicode__(self):  # Python 3: def __str__(self):
        if self.is_invariant:
            return "%s : %s" % (self.property.name, self.invarianttype.description)
        else:
            return "%s : not %s" % (self.property.name, self.invarianttype.description)