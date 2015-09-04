module ActiveNullObject
  CreateNullObject = Struct.new(:class_name, :custom_name) do
    def call
      object_name.constantize.public_send(ActiveNullObject.initialize_method)
    end

    private

    def object_name
      if custom_name.is_a?(String)
        custom_name
      else
        "Null#{class_name.to_s.classify}"
      end
    end
  end
end
