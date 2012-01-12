require "rexml/document"
require "rexml/element"
require "rexml/xmldecl"
require "rexml/text"
include REXML

class Kml < ActiveRecord::Base
	@xml = nil
	validates_presence_of :description
	validate :original_filename_or_source_url
	# ./script/plugin install https://github.com/henrik/validates_url_format_of.git
	validates_url_format_of :source_url

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

	def all_coordinates_path
		return "//*[local-name()='coordinates']"
	end

	def all_polygon_path
		return "//*[local-name()='Polygon']"
	end

	def folder_name_path
		return "/*[local-name()='kml']/*[local-name()='Document']/*[local-name()='Folder']/*[local-name()='name']/text()"
	end

	def get_xml
		if @xml != nil 
			return @xml
		elsif original_filename != "" 
			# TODO: only works if the file was actually uploaded
			xml_file = File.new(Rails.root.join('public', 'uploads', original_filename), 'r')
			@xml = Document.new(xml_file.read)

			return @xml
		else
			raise "don't support remote KML's like '%s' yet" % source_url
		end
	end

	def get_coordinates

		# parse something like this:
		# <coordinates>
		# 	-65.46989689572362,-13.76275306308587,0 -65.47014535431065,-13.7629641288033,0 -65.470207525674,-13.76326571202493,0 -65.46999022028939,-13.7635070337581,0 -65.469679719551,-13.76356741659089,0 -65.46943126108987,-13.76335635009848,0 -65.46936908437083,-13.76302460751419,0 -65.46961746099653,-13.76287375887052,0 -65.4697727040012,-13.76281340782663,0 -65.46989689572362,-13.76275306308587,0 
		# </coordinates>

		all_coordinates = []
		XPath.match(get_xml(), all_coordinates_path()).each {|coordinate_list_node|
			coordinate_list_node.text.split.each { |coordinate_string|
				numeric_tuple = coordinate_string.split(",").collect { |num_string| num_string.to_f }
				all_coordinates.push(numeric_tuple)				
			}
		}

		return all_coordinates
	end

	def get_bounding_box
		coordinates = get_coordinates()
		minX, minY, minZ = coordinates[0]
		maxX, maxY, maxZ = coordinates[0]

		coordinates.each { |x,y,z|
			minX = minX > x ? x : minX
			minY = minY > y ? y : minY
			maxX = maxX < x ? x : maxX
			maxY = maxY < y ? y : maxY
		}

		return [[minX, minY], [minX, maxY], [maxX, maxY], [maxX, minY]]
	end

	def original_filename_or_source_url()
	    errors.add_to_base("You must provide either a file or a source url") if self.original_filename.blank? && self.source_url.blank?  
	    errors.add_to_base("You cannot provide both a file and a source url") if !self.original_filename.blank? && !self.source_url.blank?
	end
end
