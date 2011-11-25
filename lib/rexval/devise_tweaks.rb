# Defaults: [[:"activerecord.errors.models.user.attributes.first_name.regexp", :"activerecord.errors.models.user.regexp"], :"activerecord.errors.messages.regexp", :"errors.attributes.first_name.regexp", :"errors.messages.regexp"]

# For #generate_message,
#   key = [:"activerecord.errors.models.user.attributes.email.regexp", :"activerecord.errors.models.user.regexp"]
#   defaults = [:"activerecord.errors.messages.regexp", :"errors.attributes.email.regexp", :"errors.messages.regexp"]
#   model = "User" (from @base.class.model_name.human)
#   attribute = "Email" (from @base.class.human_attribute_name(:email))
#   value = "" if blank... but I don't think this matters.
# All but the first of the above are part of the hash options passed as second argument
# to I18n.translate(key, options)
module Devise
  module Models
   # Override to utilize centralized REGEXP constants for validations. Note the lines marked by CHANGED tag.   
    module Validatable
      def self.included(base)
        base.extend ClassMethods
        assert_validations_api!(base)

        base.class_eval do
          validates_presence_of   :email, :if => :email_required?
          validates_uniqueness_of :email, :case_sensitive => (case_insensitive_keys != false), :allow_blank => true, :if => :email_changed?
          validates_format_of     :email, :with => Rexval::REGEXP[:email], :allow_blank => true, :if => :email_changed?, :message => :regexp # CHANGED
          validates_presence_of     :password, :if => :password_required?
          validates_confirmation_of :password, :if => :password_required?
          validates_length_of       :password, :within => password_length, :allow_blank => true
        end
      end
    end # end Validatable
  
 end # end Models
end # end Devise

# The following, along with the ActiveModel::Errors rewrite that follows in this file,
# are for the purposes of utilizing the centralized Regular Expression format initializers,
# with this next method specific to the purpose of giving an AR class itself have access
# to the types of messages generated for errors. This is used in the rewrite of
# Devise::Validatable in config/initializers/devise_tweaks.rb
module ActiveRecord
  class Base
    class << self
      def generate_error_message(attribute, type = :invalid, options = {})
        type = options.delete(:message) if options[:message].is_a?(Symbol)
      
        defaults = self.lookup_ancestors.map do |klass|
          [ :"#{self.i18n_scope}.errors.models.#{klass.model_name.i18n_key}.attributes.#{attribute}.#{type}",
            :"#{self.i18n_scope}.errors.models.#{klass.model_name.i18n_key}.#{type}" ]
        end
      
        defaults << options.delete(:message)
        defaults << :"#{self.i18n_scope}.errors.messages.#{type}"
        defaults << :"errors.attributes.#{attribute}.#{type}"
        defaults << :"errors.messages.#{type}"
      
        defaults.compact!
        defaults.flatten!
      
        key = defaults.shift

        options = {
          :default => defaults,
          :model => self.model_name.human,
          :attribute => self.human_attribute_name(attribute)
        }.merge(options)

        I18n.translate(key, options)
      end
    end
  end
end
 
# Rewrite of ActiveModel::Errors in:
# /Users/colin/.rvm/gems/ruby-1.9.2-p290\@crowdalpha/gems/activemodel-3.1.0/lib/active_model/errors.rb
# line 293, for #generate_message
module ActiveModel
  class Errors 
    def generate_message(attribute, type = :invalid, options = {})
      value = (attribute != :base ? @base.send(:read_attribute_for_validation, attribute) : nil)
      options.reverse_merge(:value => value)
    
      @base.class.generate_error_message(attribute, type, options)
    end
  end
end
