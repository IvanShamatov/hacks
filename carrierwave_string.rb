class CarrierwaveString < StringIO
  attr_accessor :filepath

  def initialize(*args)
    super(*args[1..-1])
    @filepath = URI.parse(args[0])
  end

  def original_filename
    File.basename(@filepath.path)
  end
end

# Carrierwave expects from object to respond on #original_filename method
# Example:
# 
# class Sample < ActiveRecord::Base 
#   attr_accessible :file
#   mount_uploader :file, FileUploader
# end
#
# s = Sample.new
# s.file = CarrierwaveString("filename_you_want_to_use", "YOUR STRING GOES HERE") 
# s.save
