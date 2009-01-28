class Info < ActiveRecord::Base
  @@beginning_of_this_week  = Time.today.beginning_of_week
  @@beginning_of_last_week  = Time.today.beginning_of_week.yesterday.beginning_of_week
  @@beginning_of_this_month = Time.today.beginning_of_month
  @@beginning_of_last_month = Time.today.last_month.beginning_of_month
  
  def self.sok_statistikk
    alle = Info.find(:all, :conditions => "created_at >= #{@@beginning_of_last_month.to_date}")
    denne_maaned, forrige_maaned        = partition_on_created_at(alle, @@beginning_of_this_month)
    denne_uke, tidligere_enn_denne_uken = partition_on_created_at(alle, @@beginning_of_this_week)
    forrige_uke, rest                   = partition_on_created_at(tidligere_enn_denne_uken, @@beginning_of_last_week)
        
    {:denne_uke => denne_uke.length,
     :forrige_uke => forrige_uke.length,
     :denne_maaned => denne_maaned.length,
     :forrige_maaned => forrige_maaned.length }
  end
  
  
  private
  
  def self.partition_on_created_at(infos, time)
    infos.partition {|info| info.created_at >= time}
  end
    
end
