#!/usr/bin/env python3
import json
import argparse
import subprocess

def get_leader_pods(node_name: str, namespace: str = '') -> list[dict[str, str]]:
    command = ["kubectl", "get", "pod",
               "-l", "spilo-role=master", "-lapplication=spilo",
               "--field-selector",
               f"spec.nodeName={node_name}", "-ojson"]
    if namespace:
         command += ["-n", namespace]
    else:
        command += ["-A"]
    print(command)

    process = subprocess.run(command,
                             stdout=subprocess.PIPE,
                             universal_newlines=True)

    pods = json.loads(process.stdout)["items"]
    return [{"namespace": x["metadata"]["namespace"], "name": x["metadata"]["name"]} for x in pods]


def switch(node_name: str, namespace: str = ''):
    pods = get_leader_pods(node_name, namespace)
    pre_command = ["kubectl", "exec", "-c", "postgres"]
    patronicmd = ["patronictl", "switchover", "--force"]
    for pod in pods:
        cluster_name = "-".join(pod["name"].split("-")[0:-1])
        cmd = pre_command + ["-n", pod["namespace"], pod["name"], "--"] + patronicmd + [cluster_name]
        print(cmd)
        print(f"Executing switch over for {pod['name']} in {pod['namespace']}")
        process = subprocess.run(cmd,
                                 stdout=subprocess.PIPE,
                                 universal_newlines=True)
        print(process.stdout)

def main():

    parser = argparse.ArgumentParser(
        prog='switchover',
        description='Switchover all postgres leaders from one specific node',
    )
    parser.add_argument('nodename', nargs=1)
    parser.add_argument('-n', '--namespace', default="")
    args = parser.parse_args()
    switch(node_name=args.nodename[0], namespace=args.namespace)

if __name__ == "__main__":
    main()
