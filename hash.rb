class Hash

	## Recursively yield block for all keys in hash
  def transform_keys!(&block)
    keys.each do |key|
      if self[key].is_a? Hash
        self[key].transform_keys!(&block) if block_given?
      end
      self[yield(key)] = delete(key)
    end
    self
  end

end