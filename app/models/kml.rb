class Kml < ActiveRecord::Base
	validates_presence_of :description
	validate :original_filename_or_source_url

	def original_filename_or_source_url()
	    errors.add_to_base("You must provide either a file or a source url") if self.original_filename.blank? && self.source_url.blank?  
	    errors.add_to_base("You cannot provide both a file and a source url") if !self.original_filename.blank? && !self.source_url.blank?
	end
end
