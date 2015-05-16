#!/usr/bin/python

from gi.repository.LibHdateGlib import Hdate
h = Hdate.new()

h.set_use_hebrew(True)
print (h.to_string());
