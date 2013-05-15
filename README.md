fortum_reader
=============

FortumReader is a library used for reading usage readings from Fortum [link](http://www.fortum.fi) web site. It needs Fortum user account to work.

Library uses screen scraping techniques to gather usage reading information from site. It only works with valid account information.


Requirements
------------
Currently known to work in Ruby 1.9.3.


Installation
------------
Simple:
`gem install fortum_reader`


Usage
-----
Get yourself working account in Fortum web site [link](https://www.fortum.com/countries/fi/yksityisasiakkaat/pages/rekisteroidy.aspx)

Using Rails? Include gem in Gemlock:
`gem 'fortum_reader'` and bundle install

Plain ruby example:

	require 'fortum_reader'
	
	fr = FortumReader.new(username, password)
	

How it works
------------
It emulates Firefox browser and logs in to Fortum web site. After login it can read reading information into array.

License
-------
MIT LICENSE

Copyright (c) 2013 Kulutusseuranta.fi <support@kulutusseuranta.fi>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.





