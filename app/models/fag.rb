class Fag < ActiveRecord::Base
  def to_param
    uuid
  end
end
