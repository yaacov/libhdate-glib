/* hdate-glib.vala
 *
 * Copyright (C) 2010  Yaacov Zamir
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *  
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *  
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Author:
 *   Yaacov Zamir <kobi.zamir@gmail.com>
 */

using GLib;
using LibHdate;

namespace LibHdateGlib {
  
  public class Hdate : Object {
  
    public HdateC hdate;
    
    public Hdate() {
      /* create a new hdate-c object */
      hdate = new HdateC();
      hdate.set_gdate(0, 0, 0);
      
      /* set string formating */
      _diaspora = false;
      _use_hebrew = false;
      _use_short_format = false;
      
      /* Set to location to Tel-Aviv */
      _tz = 2;
      _dst = 0;
      _longitude = 34.77;
      _latitude = 32.07;
    }
    
    public void set_diaspora (bool diaspora) {
      _diaspora = diaspora;
    }
    
    public void set_use_hebrew (bool use_hebrew) {
      _use_hebrew = use_hebrew;
    }
    
    public void set_use_short_format (bool use_short_format) {
      _use_short_format = use_short_format;
    }
    
    public void set_tz (int tz) {
      _tz = tz;
    }
    
    public void set_dst (int dst) {
      _dst = dst;
    }
    
    public void set_longitude (double longitude) {
      _longitude = longitude;
    }
    
    public void set_latitude (double latitude) {
      _latitude = latitude;
    }
    
    public void set_today () {
      hdate.set_gdate (0, 0, 0);
    }
    
    public void set_gdate (int d, int m, int y) {
      hdate.set_gdate (d, m, y);
    }

    public void set_hdate (int d, int m, int y) {
      hdate.set_hdate (d, m, y);
    }
    
    public void set_jd (int jd) {
      hdate.set_jd (jd);
    }
    
    public int get_parasha () {
      return hdate.get_parasha (_diaspora);
    }
    
    public int get_holyday () {
      return hdate.get_holyday (_diaspora);
    }
    
    public int get_omer_day() {
      return hdate.get_omer_day();
    }
    
    public int get_gday () {
      return hdate.get_gday ();
    }
    
    public int get_gmonth () {
      return hdate.get_gmonth ();
    }
    
    public int get_gyear () {
      return hdate.get_gyear ();
    }
    
    public int get_hday () {
      return hdate.get_hday ();
    }
    
    public int get_hmonth () {
      return hdate.get_hmonth ();
    }
    
    public int get_hyear () {
      return hdate.get_hyear ();
    }
    
    public int get_day_of_the_week () {
      return hdate.get_day_of_the_week ();
    }
    
    public int get_size_of_year () {
      return hdate.get_size_of_year ();
    }
    
    public int get_new_year_day_of_the_week () {
      return hdate.get_new_year_day_of_the_week ();
    }
    
    public int get_julian () {
      return hdate.get_julian ();
    }
    
    public int get_days () {
      return hdate.get_days ();
    }
    
    public int get_weeks () {
      return hdate.get_weeks ();
    }
    
    public string to_string () {
      string output;
      int holyday;
      
      if (_use_short_format) {
        output = "%s %s %s".printf (
          get_int_string (get_hday ()),
          get_hebrew_month_string (get_hmonth ()),
          get_int_string (get_hyear ())
        );
      } else {
        output = get_dow_string (get_day_of_the_week());
        
        output += " %s %d %d".printf (
          get_greg_month_string (get_gmonth ()),
          get_gday (),
          get_gyear ()
        );
        
        output += ", %s %s %s".printf(
          get_int_string (get_hday ()),
          get_hebrew_month_string (get_hmonth ()),
          get_int_string (get_hyear ())
        );
        
        holyday = get_holyday ();
        if (holyday != 0) {
          output += ", %s".printf(
            get_holyday_string (holyday)
          );
        }
      }
      
      return output;
    }
    
    public string get_format_date () {
      return hdate.get_format_date (_diaspora, _use_short_format);
    }
    
    public string get_string (HdateStringType type, int index) {
      return LibHdate.hdate_string (type, index, _use_short_format, _use_hebrew);
    }
    
    public string get_int_string (int n) {
      return this.get_string(HdateStringType.HDATE_STRING_INT, n);
    }
    
    public string get_dow_string (int day) {
      return this.get_string(HdateStringType.HDATE_STRING_DOW, day);
    }
    
    public string get_hebrew_month_string (int month) {
      return this.get_string(HdateStringType.HDATE_STRING_HMONTH, month);
    }
    
    public string get_greg_month_string (int month) {
      return this.get_string(HdateStringType.HDATE_STRING_GMONTH, month);
    }
    
    public string get_holyday_string (int holyday) {
      return this.get_string(HdateStringType.HDATE_STRING_HOLIDAY, holyday);
    }
  
    public string get_parasha_string (int parasha) {
      return this.get_string(HdateStringType.HDATE_STRING_PARASHA, parasha);
    }
    
    public int get_size_of_hebrew_year (int hebrew_year) {
      return LibHdate.get_size_of_hebrew_year (hebrew_year);
    }
  
    public int get_holyday_type (int holyday) {
      return LibHdate.get_holyday_type (holyday);
    }
    
    public int get_sun_hour () {
      int day = hdate.get_gday();
      int month = hdate.get_gmonth();
      int year = hdate.get_gyear();
      int sun_hour;
      int first_light;
      int talit;
      int sunrise;
      int midday;
      int sunset;
      int first_stars;
      int three_stars;
        
      LibHdate.get_utc_sun_time_full (day, month, year, _latitude, _longitude, 
        out sun_hour, out first_light, out talit, out sunrise,
        out midday, out sunset, out first_stars, out three_stars);
      
      return sun_hour;
    }
    
    public int get_first_light () {
      int day = hdate.get_gday();
      int month = hdate.get_gmonth();
      int year = hdate.get_gyear();
      int sun_hour;
      int first_light;
      int talit;
      int sunrise;
      int midday;
      int sunset;
      int first_stars;
      int three_stars;
        
      LibHdate.get_utc_sun_time_full (day, month, year, _latitude, _longitude, 
        out sun_hour, out first_light, out talit, out sunrise,
        out midday, out sunset, out first_stars, out three_stars);
      
      return first_light;
    }
    
    public int get_talit () {
      int day = hdate.get_gday();
      int month = hdate.get_gmonth();
      int year = hdate.get_gyear();
      int sun_hour;
      int first_light;
      int talit;
      int sunrise;
      int midday;
      int sunset;
      int first_stars;
      int three_stars;
        
      LibHdate.get_utc_sun_time_full (day, month, year, _latitude, _longitude, 
        out sun_hour, out first_light, out talit, out sunrise,
        out midday, out sunset, out first_stars, out three_stars);
      
      return talit;
    }
    
    public int get_sunrise () {
      int day = hdate.get_gday();
      int month = hdate.get_gmonth();
      int year = hdate.get_gyear();
      int sun_hour;
      int first_light;
      int talit;
      int sunrise;
      int midday;
      int sunset;
      int first_stars;
      int three_stars;
        
      LibHdate.get_utc_sun_time_full (day, month, year, _latitude, _longitude, 
        out sun_hour, out first_light, out talit, out sunrise,
        out midday, out sunset, out first_stars, out three_stars);
      
      return sunrise;
    }
    
    public int get_midday () {
      int day = hdate.get_gday();
      int month = hdate.get_gmonth();
      int year = hdate.get_gyear();
      int sun_hour;
      int first_light;
      int talit;
      int sunrise;
      int midday;
      int sunset;
      int first_stars;
      int three_stars;
        
      LibHdate.get_utc_sun_time_full (day, month, year, _latitude, _longitude, 
        out sun_hour, out first_light, out talit, out sunrise,
        out midday, out sunset, out first_stars, out three_stars);
      
      return midday;
    }
    
    public int get_sunset () {
      int day = hdate.get_gday();
      int month = hdate.get_gmonth();
      int year = hdate.get_gyear();
      int sun_hour;
      int first_light;
      int talit;
      int sunrise;
      int midday;
      int sunset;
      int first_stars;
      int three_stars;
        
      LibHdate.get_utc_sun_time_full (day, month, year, _latitude, _longitude, 
        out sun_hour, out first_light, out talit, out sunrise,
        out midday, out sunset, out first_stars, out three_stars);
      
      return sunset;
    }
    
    public int get_first_stars () {
      int day = hdate.get_gday();
      int month = hdate.get_gmonth();
      int year = hdate.get_gyear();
      int sun_hour;
      int first_light;
      int talit;
      int sunrise;
      int midday;
      int sunset;
      int first_stars;
      int three_stars;
        
      LibHdate.get_utc_sun_time_full (day, month, year, _latitude, _longitude, 
        out sun_hour, out first_light, out talit, out sunrise,
        out midday, out sunset, out first_stars, out three_stars);
      
      return first_stars;
    }
    
    public int get_three_stars () {
      int day = hdate.get_gday();
      int month = hdate.get_gmonth();
      int year = hdate.get_gyear();
      int sun_hour;
      int first_light;
      int talit;
      int sunrise;
      int midday;
      int sunset;
      int first_stars;
      int three_stars;
        
      LibHdate.get_utc_sun_time_full (day, month, year, _latitude, _longitude, 
        out sun_hour, out first_light, out talit, out sunrise,
        out midday, out sunset, out first_stars, out three_stars);
      
      return three_stars;
    }
    
    public void get_utc_sun_time (int day, int month, int year, 
        out int sunrise, out int sunset) {
        
      LibHdate.get_utc_sun_time (day, month, year, 
        _latitude, _longitude, out sunrise, out sunset);
    }
    
    public void get_utc_sun_time_full (int day, int month, int year, 
        out int sun_hour, out int first_light, out int talit, out int sunrise,
        out int midday, out int sunset, out int first_stars, out int three_stars) {
        
      LibHdate.get_utc_sun_time_full (day, month, year, _latitude, _longitude, 
        out sun_hour, out first_light, out talit, out sunrise,
        out midday, out sunset, out first_stars, out three_stars);
    }
    
    public string min_to_string (int min) {
      int hour = (min + (_tz + _dst) * 60) / 60;
      int minute = (min + (_tz + _dst) * 60) % 60;
      string output;
      
      output = "%02d:%02d".printf(hour, minute);
      return output;
    }
    
    /* Private */
    public bool _diaspora = false;
    public bool _use_short_format = false;
    public bool _use_hebrew = false;
    public double _latitude; 
    public double _longitude;
    public int _tz;
    public int _dst;
  }
  
  public enum HdateStringType {
    HDATE_STRING_INT = 0,
    HDATE_STRING_DOW = 1,
    HDATE_STRING_PARASHA = 2,
    HDATE_STRING_HMONTH = 3,
    HDATE_STRING_GMONTH = 4,
    HDATE_STRING_HOLIDAY = 5,
    HDATE_STRING_OMER = 6
  }
}
