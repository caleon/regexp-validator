module Rexval
  module Models
    
    def self.config(mod, *accessors) #:nodoc:
      (class << mod; self; end).send :attr_accessor, :available_configs
      mod.available_configs = accessors

      accessors.each do |accessor|
        mod.class_eval <<-METHOD, __FILE__, __LINE__ + 1
          def #{accessor}
            if defined?(@#{accessor})
              @#{accessor}
            elsif superclass.respond_to?(:#{accessor})
              superclass.#{accessor}
            else
              Rexval.#{accessor}
            end
          end

          def #{accessor}=(value)
            @#{accessor} = value
          end
        METHOD
      end
    end
    
    
    # Validate the chosen fields in your model:
    #
    #   rex_validate :name, :email, :age
    #
    # You can also give any of the rexval configuration values in form of a hash,
    # with specific values for this model. Please check your Rexval initializer
    # for a complete description on those values.
    #
    def rex_validate(*selected_fields)
      include Rexval::Models::Validatable
      options = selected_fields.extract_options!.dup
      
      selected_fields.map(&:to_sym).uniq.each do |fld|
        validates fld, :regexp => true
      end
      
      selected_modules = [].map(&:to_sym).uniq.sort_by do |s|
        Rexval::ALL.index(s) || -1
      end
      
      rexval_modules_hook! do
        selected_modules.each do |m|
          mod = Rexval::Models.const_get(m.to_s.classify)
        
          if mod.const_defined?("ClassMethods")
            class_mod = mod.const_get("ClassMethods")
            extend class_mod
          
            if class_mod.respond_to?(:available_configs)
              available_configs = class_mod.available_configs
              available_configs.each do |config|
                next unless options.key?(config)                
                send(:"#{config}=", options.delete(config))
              end
            end
          end
        
          include mod
        end
        
        self.rexval_modules |= selected_modules
        self.rexval_fields  |= selected_fields
        
        Rexval::FIELDS[self.model_name.i18n_key] = self.rexval_fields
        
        options.each { |key, value| send(:"#{key}=", value) }
      end
    end

    # The hook which is called inside rexval. So your ORM can include rexval
    # compatibility stuff.
    def rexval_modules_hook!
      yield
    end
  end
end

require 'rexval/models/validatable'