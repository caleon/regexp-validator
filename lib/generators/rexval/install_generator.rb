require 'securerandom'

module Rexval
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Rexval initializer and copy locale files to your application."
      class_option :orm

      def copy_initializers
        empty_directory "config/initializers/rexval"
        template "rexval.rb", "config/initializers/rexval/rexval.rb"
        template "regular_expressions.rb", "lib/rexval/regular_expressions.rb"
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
