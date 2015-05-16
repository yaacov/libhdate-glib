/* test_c.vala
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
 * 	Yaacov Zamir <kobi.zamir@gmail.com>
 */
 
/* compile:
	valac --pkg libhdate test_c.vala
 */

using LibHdate;

void main () {
	HdateC h = new HdateC();
	
	h.set_gdate(0, 0, 0);
	print ("%s\n", h.get_format_date(false, false));
}
