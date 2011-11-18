module Rexval
  module Generators
   module OrmHelpers
     def model_contents
<<-CONTENT
  # rex_validate :name, :content, :title, :username, :login, :email, :address
  #   or
  # Add or modify validations in your model file in the following fashion, 
  # as an alternative way, making sure to include the :regexp => true option.
  
CONTENT
     end
     
     def model_exists?
       File.exists?(File.join(destination_root, model_path))
     end
     
     def model_path
       @model_path ||= File.join("app", "models", "#{file_path}.rb")
     end
   end
  end
end