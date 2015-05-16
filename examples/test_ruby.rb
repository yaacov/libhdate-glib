#!/usr/bin/ruby
require 'gir_ffi'

GirFFI.setup :LibHdateGlib

h = LibHdateGlib::Hdate.new
print h.to_string, "\n"

