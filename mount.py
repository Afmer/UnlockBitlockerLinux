from pykeepass import PyKeePass
import os
import getpass
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('enviroment', type=str)
args = parser.parse_args()

inputPassword = getpass.getpass("Введите пароль хранилища: ")
current_directory = args.enviroment
pswd_path = current_directory + "/bitEntries.kdbx"
kp = None
try:
    kp = PyKeePass(pswd_path, password=inputPassword)
except:
    print("Неправильный пароль")
    exit()
nvme0n1p1 = kp.find_entries(title="nvme0n1p1", first=True)
sda1 = kp.find_entries(title="sda1", first=True)
os.system(f"bash {current_directory}/bashScripts/nvme0n1p1.sh {nvme0n1p1.password}")
os.system(f"bash {current_directory}/bashScripts/sda1.sh {sda1.password}")