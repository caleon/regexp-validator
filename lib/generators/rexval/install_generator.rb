require 'securerandom'

module Rexval
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Rexval initializer and copy locale files to your application."
      class_option :orm

      def copy_initializers
        init_path = "config/initializers/rexval"
        empty_directory init_path
        template "rexval.rb",               "#{init_path}/rexval.rb"
        template "regular_expressions.rb",  "#{init_path}/regular_expressions.rb"
      end

      def copy_locale
        copy_file "../../../config/locales/en.yml", "config/locales/rexval.en.yml"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end
