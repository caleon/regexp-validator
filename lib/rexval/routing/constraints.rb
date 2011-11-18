# require 'active_support/inflector'
# require 'active_support/core_ext/array/wrap'

module Rexval
  module Routing
    # class RoutingContraints
    #   def self.matches?(request)
    #     request.symbolized_path_parameters.select do |key, val|
    #       
    #     end
    #     true
    #   end
    # end
    module Constraints
      def resource(*args, &block)
        rexval_routing(*args, &block)
      end
    
      def resources(*args, &block)
        rexval_routing(*args, &block)
      end
    
    protected
      def rexval_routing(*args, &block)
        rsym = args.first
        hash = Array.wrap(Rexval::MODEL_FIELDS[rsym.to_s.singularize]).inject({}) do |hsh, fld|
          hsh[fld] = regex_for(rsym, fld); hsh
        end
      
        constraints(hash) do
          super
        end
      end
    end
    
  end
end