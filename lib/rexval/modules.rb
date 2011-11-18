require 'active_support/core_ext/object/with_options'

Rexval.with_options :model => true do |d|
  d.add_module :validatable
end