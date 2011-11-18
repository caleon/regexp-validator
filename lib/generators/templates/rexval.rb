Rexval.setup do |config|

  # ==> ORM configuration
  # Load and configure the ORM. Supports :active_record (default) and
  # :mongoid (bson_ext recommended) by default. Other ORMs may be
  # available as additional gems.
  require 'rexval/orm/<%= options[:orm] %>'  
  
  # Configure which authentication keys should be case-insensitive.
  # These keys will be downcased upon creating or modifying a record.
  # Default is :email.
  config.case_insensitive_keys = [ :email ]

  # Configure which authentication keys should have whitespace stripped.
  config.strip_whitespace_keys = [ :email ]
end
