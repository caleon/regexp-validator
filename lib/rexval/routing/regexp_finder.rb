# require 'core_utilities/core_ext/array'

module Rexval
  module Routing
    
    module RegexpFinder
      def reges_for(*args)
        (field, klass), opts = args.args_with_reverse_and_options!
        (Rexval.reges_for(:route, field) rescue nil) || (klass && Rexval.reges_for(klass, field) rescue nil) || Rexval.reges_for(field) || ".*"
      end
    end
  end
end