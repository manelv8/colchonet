class User < ActiveRecord::Base

	 EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
	 validates_presence_of :email , :full_name, :location, :password
	 validates_confirmation_of :password
	 validates_length_of :bio, minimum: 30, allow_blank: true
	# validate :email_format
	 validates_uniqueness_of :email
	 validates_format_of :email, with: EMAIL_REGEXP

	 has_secure_password

	 before_create do |user|
		 user.confirmation_token = SecureRandom.urlsafe_base64
	 end

	 def confirm!
		 return if confirmed?

		 self.confirmed_at = Time.current
		 self.confirmation_token = ''
	 end
	 def confirmed?
		 confirmed_at.present?
	 end
=begin
private

	def email_format
		errors.add(:email,:invalid) unless email.match(EMAIL_REGEXP)
	end
=end
end
