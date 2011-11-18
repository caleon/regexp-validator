# require 'core_utilities/core_ext/array'

module Rexval
  module RegexpFinder
    def reges_for(*args)
      (field, klass), opts = args.args_with_reverse_and_options!
      (klass && Rexval.reges_for(klass, field) rescue nil) || Rexval.reges_for(field) || ".*"
    end
  
    def regex_for(*args)
      Regexp.new(reges_for(*args))
    end
  
    def regexp_for(*args)
      Regexp.new("^#{reges_for(*args)}$")
    end
  
    def field_regexp_for(record, field)
      regexp_for(record.class.model_name.i18n_key, field)  || regexp_for(field)
    end
  end
end
