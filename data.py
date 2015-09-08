#!/usr/bin/env python

import sys

import random
import time

from datetime import datetime, timedelta

LINE = "temperature,machine=%s,type=assembly internal=%di,external=%di %d"


def generate(machine):
    today = datetime.utcnow().date()
    start = datetime(today.year, today.month, today.day)
    delta = timedelta(0, 1)  # 1 second
    for i in xrange(0, 60 * 60 * 24 + 1):
        in_temp = random.randint(20, 100)
        print LINE % (
            machine, in_temp,
            random.randint(0, in_temp - 10),
            int(time.mktime((start + i * delta).timetuple())*1000000000))

if __name__ == '__main__':
    for arg in sys.argv[1:]:
        generate(arg)
