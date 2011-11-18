module Rexval
  module Generators
    class RexvalGenerator < Rails::Generators::NamedBase
      namespace 'rexval'
      source_root File.expand_path('../templates', __FILE__)
      
      desc "Generates regular expression entries in the constants file for NAME."
      
      hook_for :orm

      # class_option :routes, :desc => "Generate routes", :type => :boolean, :default => false
      
      def add_rexval_routes
        # rexval_route  = "rex_route :#{plural_name}"
        # route rexval_route
      end
    end
  end
end