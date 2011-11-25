require 'rails'
require 'active_support/core_ext/numeric/time'
require 'active_support/dependencies'
require 'orm_adapter'
require 'set'
require 'securerandom'

require 'core_utilities'

module Rexval
  autoload :RegexpFinder,   'rexval/regexp_finder'
  
  module Routing
    autoload :RegexpFinder, 'rexval/routing/regexp_finder'
    autoload :Constraints,  'rexval/routing/constraints'
  end
  
  # Constants which holds rexval configuration for extensions. Those should
  # not be modified by the "end user" (this is why they are constants).
  ALL         = []
  FIELDS      = ActiveSupport::OrderedHash.new
  # ROUTE_REQS  = ActiveSupport::OrderedHash.new
  
  # def self.add_route_reqs(rsym, reqs)
  #   ROUTE_REQS[rsym] = (ROUTE_REQS[rsym] || {}).merge(reqs)
  # end
  
  mattr_accessor :default_regexp
  @@default_regexp = /^.*$/
  
  # Keys that should be case-insensitive.
  # False by default for backwards compatibility.
  mattr_accessor :case_insensitive_keys
  @@case_insensitive_keys = false
  
  # Keys that should have whitespace stripped.
  # False by default for backwards compatibility.
  mattr_accessor :strip_whitespace_keys
  @@strip_whitespace_keys = false
  
  # Default way to setup Rexval. Run rails generate rexval:install to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end

  class Getter
    def initialize name
      @name = name
    end

    def get
      ActiveSupport::Dependencies.constantize(@name)
    end
  end

  def self.ref(arg)
    if defined?(ActiveSupport::Dependencies::ClassCache)
      ActiveSupport::Dependencies::reference(arg)
      Getter.new(arg)
    else
      ActiveSupport::Dependencies.ref(arg)
    end
  end
  
  def self.add_module(module_name, options = {})
    ALL << module_name
    options.assert_valid_keys(:model)

    if options[:model]
      path = (options[:model] == true ? "rexval/models/#{module_name}" : options[:model])
      camelized = ActiveSupport::Inflector.camelize(module_name.to_s)
      Rexval::Models.send(:autoload, camelized.to_sym, path)
    end
  end
  
  # Include helpers in the given scope to AC.
  def self.include_helpers(scope)
    ActiveSupport.on_load(:action_controller) do
      helper RexvalHelper
    end
  end
  
  def self.reges_for(*args)
    (arg1, arg2), opts = args.args_and_opts!
    base = opts[:route] ? REGES[:route] : REGES
    
    if arg2
      base[arg1].try(:[], arg2) || base[arg2]
    else
      base[arg1]
    end or opts[:route] && reges_for(arg1, arg2) or ".*"
  end
    
end

require 'rexval/regexp_validator'
require 'rexval/models'
require 'rexval/modules'
require 'rexval/routing'
require 'rexval/devise_tweaks' if Object.const_defined?(:Devise)