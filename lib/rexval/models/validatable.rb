# require 'active_support/core_ext/array/extract_options'
module Rexval
  module Models
    
    
    module Validatable
      extend ActiveSupport::Concern

      included do
        class_attribute :rexval_modules, :instance_writer => false
        self.rexval_modules ||= []
        
        class_attribute :rexval_fields, :instance_writer => false
        self.rexval_fields ||= []
        
        # validate *rexval_fields, :regexp => true
      end
      
      module ClassMethods
        Rexval::Models.config(self, :default_regexp)
        
        # def validates(*attributes)
        #   defaults = attributes.extract_options!
        #   
        #   if !(special_fields = self.rexval_fields & attributes).empty?
        #     super(*special_fields.push(defaults.merge(:regexp => true)))
        #   end
        #   
        #   if !(normal_fields = attributes - self.rexval_fields).empty?
        #     super(*normal_fields.push(defaults))
        #   end
        # end
                
      end
    end
  end
end