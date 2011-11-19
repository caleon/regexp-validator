module Rexval
  # REGES is the string representation of the Regular Expression. These will not automatically
  # be appended the ignore-case flag, so distinction must be made explicitly within the regexp.
  REGES = { 
           :model_name                 => '[a-z]\w*[a-z0-9]',
           
                  # Base level attributes:
                  :id                  =>  '\d+',
                  # Generic "name"
                  :name                =>  '[\w\(][\s\w\'\"\.\,\(\)]+[\w\)]+',
                  # The following is not within :user because this may apply to non-user models
                  # down the line, models that also deal with human names.
                  :first_name          =>  '[a-zA-Z]+(?:[a-zA-Z]|(?:([-\'\.\s])(?!\1)))*[a-zA-Z]+',
                  :last_name           =>  '[a-zA-Z]+(?:[a-zA-Z]|(?:([-\'\.\s])(?!\1)))*[a-zA-Z]+',
                  :middle_initial      =>  '[a-zA-Z]?',
                  :email               =>  '([\w\.%\+\-]+)@((?:[\w\-\+]+\.)+(?:[\w]{2,}))',

                  # Not sure if the ?i flag works, but I must have added it for a reason.
                  :url                 =>  '(?:https?://)?(?:www\.)?((\w+)\.)+([a-z]{2,3})',
                  :permalink           =>  '(?i)[a-z\d]+[-a-z\d]+[a-z\d]+',
                  :id_with_permalink   =>  '\d+\-[a-z\d]+[-a-z\d]+[a-z\d]+',

                  :postal_code         =>  '[a-zA-Z0-9]+(?:[-a-zA-Z0-9])*[a-zA-Z0-9]+',
                  :phone               =>  '.*\d{3}.*\d{3}.*\d{4}.*',               

      # Scoped by category (i.e. :route), or by model (i.e. :user)
      :route => { # :permalink           =>       '[a-z\d]+[-a-z\d]+[a-z\d]+',
                  :id_with_permalink   =>  '\d+\-[a-z\d]+[-a-z\d]+[a-z\d]+'   },

   :category => { :name                =>  '[a-zA-Z]+(?:[a-zA-Z0-9]|(?:(\W)(?!\1)))[a-zA-Z0-9]+' },
   
      :user =>  { :rid                 =>  '\d{6}',
                  :username            =>         
                    # The following means, begins with a letter, ends with a letter or numeric,
                    # hence minimum 2 characters, and the (optional) middle characters include
                    # alphanumerics or dashes (-), underscores (_), single quotations ('), or
                    # spaces ( ) as long as those non-alphanumerics aren't repeated back-to-back
                    # right after the same one. For instance, "a-'3" is technically valid, but
                    # "a--'3" is not, since it has a back-to-back symbol.
                    "[a-zA-Z]+([a-zA-Z0-9]|-(?!-)|_(?!_)|\'(?!\')|\.(?!\.)|\s(?!\s))*[a-zA-Z0-9]+" }
  }


end