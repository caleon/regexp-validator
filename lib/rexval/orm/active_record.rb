require 'orm_adapter/adapters/active_record'

module Rexval
  module Orm
   
    module ActiveRecord
      
    end
  end
end

ActiveRecord::Base.extend Rexval::Models
