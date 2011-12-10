require 'test_helper'

class KmlTest < ActiveSupport::TestCase
	test "should save KML with valid source url" do
	    kml = Kml.new	
	    kml.source_url = 'http://bogus.com/'
	    kml.description = 'test data'

		assert kml.save
	end

	test "should NOT save KML with valid source url" do
	    kml = Kml.new	
	    kml.source_url = 'bogus'
	    kml.description = 'test data'

		assert !kml.save
	end
end
