class Contact < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :user
	has_many :phone, dependent: :destroy
	PHONE_REGEX = /08+[0-9]/
	validates :phone_number, presence: true, :format => PHONE_REGEX, length: {minimum: 11, maximum:12}

end
