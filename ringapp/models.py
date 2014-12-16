from __future__ import unicode_literals
from django.db import models

# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Remove `managed = False` lines for those models you wish to give write DB access
# Feel free to rename the models, but don't rename db_table values or field names.

class Logic(models.Model):
    logic_id = models.AutoField(db_column='logic_ID', unique=True, primary_key=True) # Field name made lowercase.
    entry_type = models.IntegerField(blank=True, null=True)
    cond_1 = models.IntegerField(blank=True, null=True)
    cond_2 = models.IntegerField(blank=True, null=True)
    cond_3 = models.IntegerField(blank=True, null=True)
    cond_4 = models.IntegerField(blank=True, null=True)
    conc = models.IntegerField(blank=True, null=True)
    option = models.CharField(max_length=200, blank=True)
    citation = models.CharField(max_length=200, blank=True, null=True)
    poster = models.CharField(max_length=25,blank=True,null=True)
    class Meta:
        #managed = False
        db_table = 'logic'
    def __unicode__(self):  # Python 3: def __str__(self):
        return str(self.logic_id)

class CommLogic(models.Model):
    logic_id = models.AutoField(db_column='logic_ID', unique=True, primary_key=True) # Field name made lowercase.
    entry_type = models.IntegerField(blank=True, null=True)
    cond_1 = models.IntegerField(blank=True, null=True)
    cond_2 = models.IntegerField(blank=True, null=True)
    cond_3 = models.IntegerField(blank=True, null=True)
    cond_4 = models.IntegerField(blank=True, null=True)
    conc = models.IntegerField(blank=True, null=True)
    option = models.CharField(max_length=200, blank=True)
    citation = models.CharField(max_length=200, blank=True)
    poster = models.CharField(max_length=25,blank=True,null=True)
    class Meta:
        #managed = False
        db_table = 'comm_logic'
    def __unicode__(self):  # Python 3: def __str__(self):
        return str(self.logic_id)
        
        
class Ring(models.Model):
    ring_id = models.AutoField(db_column='ring_ID', unique=True, primary_key=True) # Field name made lowercase.
    name = models.CharField(max_length=250)
    description = models.CharField(max_length=1000)
    keywords = models.CharField(max_length=200)
    reference = models.CharField(max_length=500)
    notes = models.CharField(max_length=500, blank=True,null=True)
    poster = models.CharField(max_length=25,blank=True,null=True)
    class Meta:
        #managed = False
        db_table = 'rings'
    def __unicode__(self):  # Python 3: def __str__(self):
        return self.name        
        
class Property(models.Model):
    property_id = models.AutoField(db_column='property_ID', unique=True, primary_key=True) # Field name made lowercase.
    name = models.CharField(max_length=250)
    definition = models.CharField(max_length=500)
    poster = models.CharField(max_length=25,blank=True,null=True)
    class Meta:
        #managed = False
        db_table = 'properties'
    def __unicode__(self):  # Python 3: def __str__(self):
        return self.name

class CommProperty(models.Model):
    property_id = models.AutoField(db_column='property_ID', unique=True, primary_key=True) # Field name made lowercase.
    name = models.CharField(max_length=250)
    definition = models.CharField(max_length=500)
    poster = models.CharField(max_length=25,blank=True,null=True)
    class Meta:
        #managed = False
        db_table = 'comm_properties'
    def __unicode__(self):  # Python 3: def __str__(self):
        return self.name
        
class RingProperty(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    ring = models.ForeignKey(Ring, db_column='ring_ID', blank=True, null=True) # Field name made lowercase.
    property = models.ForeignKey(Property, db_column='property_ID', blank=True, null=True) # Field name made lowercase.
    has_property = models.IntegerField(blank=True, null=True)
    reason = models.CharField(max_length=200)
    source = models.CharField(max_length=500)
    poster = models.CharField(max_length=25,blank=True,null=True)
    time = models.DateTimeField(auto_now_add=True,null=True)
    class Meta:
        #managed = False
        db_table = 'ring_property'
    def __unicode__(self):  # Python 3: def __str__(self):
        return str(self.ring.name)+"\t"+str(self.property.name)

class CommRingProperty(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True) #get this to autoincrement properly
    ring = models.ForeignKey(Ring, db_column='ring_ID', blank=True, null=True) # Field name made lowercase.
    property = models.ForeignKey(CommProperty, db_column='property_ID', blank=True, null=True) # Field name made lowercase.
    has_property = models.IntegerField(blank=True, null=True)
    reason = models.CharField(max_length=200)
    source = models.CharField(max_length=500)
    poster = models.CharField(max_length=25,blank=True,null=True)
    time = models.DateTimeField(auto_now_add=True)
    class Meta:
        #managed = False
        db_table = 'comm_ring_property'
    def __unicode__(self):  # Python 3: def __str__(self):
        return str(self.ring.name)+"\t"+str(self.property.name)
        
class Equivalents(models.Model):
    id = models.AutoField(null=False, unique = True, primary_key=True)
    property = models.ForeignKey(Property, db_column='property_ID', blank=True, null=True) # Field name made lowercase.
    equivalent = models.CharField(max_length=500)
    keywords = models.CharField(max_length=200)
    source = models.CharField(max_length=100)
    poster = models.CharField(max_length=30,blank=True,null=True)
    class Meta:
        #managed = False
        db_table = 'equivalents'
    def __unicode__(self):  # Python 3: def __str__(self):
        return str(self.property.name)+"\t"+str(self.equivalent)
    
class CommEquivalents(models.Model):
    id = models.AutoField(null=False, unique=True, primary_key=True)
    property = models.ForeignKey(CommProperty, db_column='property_ID', blank=True, null=True) # Field name made lowercase.
    equivalent = models.CharField(max_length=500)
    keywords = models.CharField(max_length=200)
    source = models.CharField(max_length=100)
    poster = models.CharField(max_length=30,blank=True,null=True)
    class Meta:
        #managed = False
        db_table = 'comm_equivalents'
    def __unicode__(self):  # Python 3: def __str__(self):
        return str(self.property.name)+"\t"+str(self.equivalent)
