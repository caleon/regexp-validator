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
        opts = args.extract_options!
        old_reqs = opts[:constraints] || {}
        
        rsym = args.first.to_s.to_sym
        new_reqs = Array.wrap(Rexval::FIELDS[rsym]).inject({}) do |hsh, fld|
          regex_for(rsym, fld).and_also { |rex| hsh[fld] = rex }
          hsh
        end
        
        reqs = new_reqs.merge(old_reqs)
        
        super(*args, opts.merge(:constraints => reqs))
      end
    
      def resources(*args, &block)
        opts = args.extract_options!
        old_reqs = opts[:constraints] || {}
        
        rsym = args.first.to_s.to_sym
        new_reqs = Array.wrap(Rexval::FIELDS[rsym]).inject({}) do |hsh, fld|
          regex_for(rsym, fld).and_also { |rex| hsh[fld] = rex }
          hsh
        end
        
        reqs = new_reqs.merge(old_reqs)
        
        super(*args, opts.merge(:constraints => reqs))
      end
    
    end
    
  end
end