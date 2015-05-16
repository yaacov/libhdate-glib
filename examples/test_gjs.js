#!/usr/bin/gjs

const Hdate = imports.gi.LibHdateGlib.Hdate;
const HdateStringType = imports.gi.LibHdateGlib.HdateStringType;

var h = Hdate.new();

// set the tade for today
h.set_today();

// force hebrew output
h.set_use_hebrew(true);

// print the date
print (h.to_string());

// get times for tel aviv (utc time)
h.set_longitude(34.77);
h.set_latitude(32.07);

var sunrise = h.get_sunrise()
var sunset = h.get_sunset()
var first_light = h.get_first_light()
var talit = h.get_talit()
var first_stars = h.get_first_stars()
var three_stars = h.get_three_stars()

// print times in israel tz=2 dst=0
h.set_tz(2);
h.set_dst(0);

print ("sunrise - " + h.min_to_string(sunrise))
print ("sunset - " + h.min_to_string(sunset))
print ("first_light - " + h.min_to_string(first_light))
print ("talit - " + h.min_to_string(talit))
print ("first_stars - " + h.min_to_string(first_stars))
print ("three_stars - " + h.min_to_string(three_stars))

