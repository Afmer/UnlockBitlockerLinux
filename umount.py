import os
import json
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('enviroment', type=str)
args = parser.parse_args()
current_directory = args.enviroment

file_path = f'{current_directory}/data/mounted_devices.json'
if os.path.exists(file_path):
    with open(file_path , 'r') as file:
        data = json.load(file)
        for device in data.copy():
            exitCode = os.system(f"bash {current_directory}/bashScripts/cryptsetup/umountBaseScript.sh {device}")
            if exitCode == 0 or exitCode == 256:
                data.remove(device)
    if not data:
        os.remove(file_path)
    else:
        with open(file_path , 'w') as file:
            json.dump(data, file)
