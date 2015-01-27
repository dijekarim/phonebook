class Phone < ActiveRecord::Base
  belongs_to :contact
  PHONE_REGEX = /08+[0-9]/
  validates :more_phone, presence: true, :format => PHONE_REGEX, length: {minimum: 11, maximum:12}

end
