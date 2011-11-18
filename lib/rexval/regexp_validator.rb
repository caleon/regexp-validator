class RegexpValidator < ActiveModel::EachValidator
  include Rexval::RegexpFinder
  
  def validate_each(record, attribute, value)
    # Note, the regexp should not check for presence. that is up to another validator. That is
    # why I pass it when `value.nil?`.
    unless value.nil? or value =~ field_regexp_for(record, options[:as] || attribute)
      record.errors.add(attribute, :regexp)
    end
  end
end