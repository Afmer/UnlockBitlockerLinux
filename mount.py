from pykeepass import PyKeePass
import os
import getpass
import argparse
import json

parser = argparse.ArgumentParser()
parser.add_argument('--enviroment', type=str)
parser.add_argument('--password', type=str)
args = parser.parse_args()
password_arg = args.password
if password_arg is not None:
    inputPassword = password_arg
else:
    inputPassword = getpass.getpass("Введите пароль хранилища: ")
current_directory = args.enviroment
pswd_path = current_directory + "/data/bitEntries.kdbx"
kp = None
try:
    kp = PyKeePass(pswd_path, password=inputPassword)
except:
    print("Неправильный пароль")
    exit()
entries = kp.entries
mounted_devices = []
for entry in entries:
    exitCode = os.system(f"bash {current_directory}/bashScripts/cryptsetup/mountBaseScript.sh {entry.password} {entry.title}")
    if exitCode!=0:
        print(f"error {exitCode}")
        continue
    mounted_devices.append(entry.title)
with open(f'{current_directory}/data/mounted_devices.json', 'w') as json_file:
    json.dump(mounted_devices, json_file)