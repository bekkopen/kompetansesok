# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format 
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
  inflect.plural(/$/, 'er')
  inflect.plural(/s$/i, 'er')
   
  inflect.uncountable %w(kompetansemaalsett)
  
  #inflect.singular
  #inflect.irregular
end
