#!/bin/python3
import json

# {
#   "result": {
#     "covered_percent": 80.57
#   }
# }

def load_json(filename):
    with open(filename, 'r') as f:
        return json.loads(f.read())

last_coverage = load_json('coverage/.last_run.json')['result']['covered_percent']
reference_coverage = load_json('coverage/main.json')['result']['covered_percent']
print("Test coverage reference: %s" % reference_coverage)
print("Test coverage current: %s" % last_coverage)
if reference_coverage > last_coverage:
    print('You are reducing the test coverage. Please add tests to your changes.')
    exit(1)
elif reference_coverage < last_coverage:
    print("Coverage improved the new value will be commited automatically")
elif reference_coverage == last_coverage:
    print("Coverage stable")
