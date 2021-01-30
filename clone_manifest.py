#!/usr/bin/python3
import sys
import subprocess

if len(sys.argv) != 3:
    print(f"Usage: %s <source manifest tag> <target manifest tag>"%(sys.argv[0]))
    sys.exit(-1)

source_manifest_tag = sys.argv[1]
source_manifest_tag = sys.argv[2]

result = subprocess.run(['docker', 'manifest', 'inspect',source_manifest_tag ], stdout=subprocess.PIPE)
print(result.stdout)