#!/usr/bin/env python3

import time
import subprocess
import os

BATT_LIFE = "/sys/class/power_supply/battery/capacity"
PWR_LED = "/sys/class/gpio/gpio77/value"

def read_int(path):
    with open(path, "r") as f:
        return int(f.read().strip())

def write_int(path, value):
    with open(path, "w") as f:
        f.write(str(value))

def safe_shutdown():
    subprocess.run(["pkill", "-15", "retroarch"])

    for _ in range(10):
        if subprocess.run(
            ["pgrep", "-x", "retroarch"],
            stdout=subprocess.DEVNULL
        ).returncode != 0:
            break
        time.sleep(1)

    os.sync()
    time.sleep(2)
    subprocess.run(["poweroff"])


while True:
    batt = read_int(BATT_LIFE)
    led = read_int(PWR_LED)

    if batt <= 1:
        safe_shutdown()
        break

    elif batt <= 10:
        write_int(PWR_LED, 1 - led)
        time.sleep(1)

    elif batt <= 20:
        if led == 1:
            write_int(PWR_LED, 0)
        time.sleep(30)

    else:
        if led == 0:
            write_int(PWR_LED, 1)
        time.sleep(30)
