require 'rails/generators/active_record'
require 'generators/rexval/orm_helpers'

module ActiveRecord
  module Generators
    class RexvalGenerator < ActiveRecord::Generators::Base
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
      
      include Rexval::Generators::OrmHelpers
      source_root File.expand_path('../templates', __FILE__)
      
      def copy_rexval_migration
        if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))
          migration_template 'migration_existing.rb', "db/migrate/add_rexval_to_#{table_name}"
        else
          migration_template 'migration.rb', "db/migrate/rexval_create_#{table_name}"
        end
      end
      
      def generate_model
        invoke 'active_record:model', [name], :migration => false unless model_exists? && behavior == :invoke
      end
      
      def inject_rexval_content
        inject_into_class(model_path, class_name, model_contents + <<CONTENT) if model_exists?
  # validates :name, :regexp => true
  validates :name, :regexp => true      
CONTENT
      end
      
    end
  end
end