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
        # rexval_routing(*args, &block)
        rsym = args.first.to_s.to_sym
        reqs = Array.wrap(Rexval::FIELDS[rsym]).inject({}) do |hsh, fld|
          regex_for(rsym, fld).and_also { |rex| hsh[fld] = rex }
          hsh
        end
        
        Rexval.add_route_reqs(rsym, reqs)
      
        constraints(reqs) do
          super
        end
      end
    
      def resources(*args, &block)
        # rexval_routing(*args, &block)
        rsym = args.first.to_s.singularize.to_sym
        reqs = Array.wrap(Rexval::FIELDS[rsym]).inject({}) do |hsh, fld|
          regex_for(rsym, fld).and_also { |rex| hsh[fld] = rex }
          hsh
        end
        
        Rexval.add_route_reqs(rsym, reqs)
      
        constraints(reqs) do
          super
        end
      end
    
    protected
      # def rexval_routing(*args, &block)
      #   rsym = args.first
      #   hash = Array.wrap(Rexval::FIELDS[rsym.to_s.singularize]).inject({}) do |hsh, fld|
      #     hsh[fld] = regex_for(rsym, fld); hsh
      #   end
      #   
      #   Rexval::ROUTE_REXES[rsym] = (Rexval::ROUTE_REXES[rsym] || {}).merge(hash)
      # 
      #   constraints(hash) do
      #     super
      #   end
      # end
    end
    
  end
end