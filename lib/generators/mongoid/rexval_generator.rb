require 'generators/rexval/orm_helpers'

module Mongoid
  module Generators
    class RexvalGenerator < Rails::Generators::NamedBase
      include Rexval::Generators::OrmHelpers

      def generate_model
        invoke "mongoid:model", [name] unless model_exists? && behavior == :invoke
      end

      def inject_rexval_content
        inject_into_file model_path, model_contents, :after => "include Mongoid::Document\n" if model_exists?
      end
    end
  end
end