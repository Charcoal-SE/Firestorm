class PresignedLinks < ActiveRecord::Base
  attr_accessible :flag_id, :presigned_string
  def self.generate_string_and_save()
  	self.presigned_string = "Foo!"
  	self.save!
  end
end
