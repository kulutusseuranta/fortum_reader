fortum_reader
=============

FortumReader is a library used for reading usage readings from Fortum [link](http://www.fortum.fi) web site. It needs Fortum user account to work.

Library uses screen scraping techniques to gather usage reading information from site. It only works with valid account information.

This library is very beta and early stages, please collaborate!

Requirements
------------
Currently known to work in Ruby 1.9.3. Uses Mechanize gem for screen scraping.


Installation
------------
Simple:

	gem install fortum_reader


Usage
-----
Get yourself working account in Fortum web site [link](https://www.fortum.com/countries/fi/yksityisasiakkaat/pages/rekisteroidy.aspx)

Using Rails? Include gem in Gemfile:

	gem 'fortum_reader', '~>0.0.3'

and

	bundle install

**Plain ruby example**:

	require 'fortum_reader'
	
	fr=FortumReader.new(username, password)

	# Test if login works ok?
	fr.login_ok?
	
	# Fetch readings array
	readings=fr.read

Reading array example:

	[{:read_at=>"30.04.2013", :reading=>"101010", :usage_point_id=>"1234567", :comment=>"Siirto"},
	{:read_at=>"01.05.2013", :reading=>"102010", :usage_point_id=>"1234567", :comment=>"Siirto"}]

Sample project
--------------
There is a sample project which you can clone and use: [https://github.com/kulutusseuranta/fortum_reader_sample_app](https://github.com/kulutusseuranta/fortum_reader_sample_app).

How it works
------------
It emulates Firefox browser and logs in to Fortum web site. After login it can read reading information into array.

Contributing
------------

If you've found a bug, want to submit a patch, or have a feature request, please enter a ticket into our github tracker:

http://github.com/kulutusseuranta/fortum_reader/issues

We strongly encourage bug reports to come with failing tests or at least a reduced example that demonstrates the problem. Similarly, patches should include tests, API documentation, and an update to the manual where relevant. Feel free to send a pull request early though, if you just want some feedback or a code review before preparing your code to be merged.

If you are unsure about whether or not you've found a bug, or want to check to see whether we'd be interested in the feature you want to add before you start working on it, feel free to post to our mailing list.

How to collaborate
------------------

1. Fork the project.
1. Make your feature addition or bug fix.
1. Add tests for it, bonus points! :)
1. Commit
1. Send me a pull request. Bonus points for topic branches.


License
-------
MIT LICENSE

Copyright (c) 2013 Kulutusseuranta.fi <support@kulutusseuranta.fi>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.





