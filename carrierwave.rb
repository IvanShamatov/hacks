## Put this monkey patch into rails initiializers path

module CarrierWave
  module Uploader
    module Download
      class RemoteFile

        ## Adding ftp as allowed scheme
        # so process to save is similar
        #
        # p = Pricelist.new
        # => #<Pricelist id: nil, file: nil, created_at: nil, updated_at: nil> 
        # p.remote_file_url = "ftp://username:password@host:port/path_to_file"
        # => "ftp://username:password@host:port/path_to_file" 
        # p.save
        def http?
          @uri.scheme =~ /^(?:ftp|https?)$/
        end

      end
    end
  end
end