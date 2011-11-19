require 'core_utilities/core_ext/array'

module Rexval
  module Routing
    
    module RegexpFinder
      def reges_for(*args)
        # super(:route, *args)
        super(*args.merge_options(:route => true))
      end
    end
  end
end