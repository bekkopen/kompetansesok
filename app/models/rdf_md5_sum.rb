class RdfMd5Sum < ActiveRecord::Base
  def self.current=(value)
    if RdfMd5Sum.find(:first)
      rdfsum = RdfMd5Sum.find(:first)
      rdfsum.current = value
      rdfsum.save!
    else
      RdfMd5Sum.create(:current => value)
    end
  end

  def self.current
    if RdfMd5Sum.find(:first)
      RdfMd5Sum.find(:first).current
    else
      ""
    end
  end
  
end
