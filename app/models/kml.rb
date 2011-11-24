require "rexml/document"
require "rexml/element"
require "rexml/xmldecl"
require "rexml/text"
include REXML

class Kml < ActiveRecord::Base
	validates_presence_of :description
	validate :original_filename_or_source_url

	def name_path
		return "/*[local-name()='kml']/*[local-name()='Document']/*[local-name()='name']"
	end

	def description_path
		return "/*[local-name()='kml']/*[local-name()='Document']/*[local-name()='description']"
	end

	def all_placemark_path
		return "//*[local-name()='Placemark']"
	end

	def all_linestring_path
		return "//*[local-name()='LineString']"
	end

	def all_polygon_path
		return "//*[local-name()='Polygon']"
	end

	def folder_name_path
		return "/*[local-name()='kml']/*[local-name()='Document']/*[local-name()='Folder']/*[local-name()='name']/text()"
	end

	def get_xml
		xml_file = File.new(Rails.root.join('public', 'uploads', original_filename), 'r')
		xml_document = Document.new(xml_file.read)

		return xml_document
	end

	def original_filename_or_source_url()
	    errors.add_to_base("You must provide either a file or a source url") if self.original_filename.blank? && self.source_url.blank?  
	    errors.add_to_base("You cannot provide both a file and a source url") if !self.original_filename.blank? && !self.source_url.blank?
	end
end
