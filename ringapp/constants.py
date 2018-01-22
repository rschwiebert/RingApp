import json

# This contains a static translation of the property list existing in the
# first version of the site to the new enumeration of properties
with open('ringapp/legacy/v1_to_v2.json', 'r') as f:
    PROPSV1_TO_TERMSV2 = json.load(f)

with open('ringapp/legacy/v1comm_to_v2.json', 'r') as f:
    PROPSV1COMM_TO_TERMSV2 = json.load(f)
