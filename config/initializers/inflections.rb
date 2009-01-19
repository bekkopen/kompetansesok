# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format 
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
  inflect.plural(/$/, 'er')
  inflect.plural(/e$/i, 'er')
  
  inflect.singular(/er$/, '')
  inflect.singular(/ene$/, '')
   
  inflect.uncountable %w(kompetansemaalsett kompetansemaal trinn laereplansok fagsok fag)
  
  inflect.irregular 'hovedomraade','hovedomraader'
end
