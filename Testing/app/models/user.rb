class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true

    attr_reader :password

    after_initialize :ensure_session_token
    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && user.is_password?(password)
            user
        else
            nil
        end
    end
    
    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end
    
    def is_password?(password)
        BCrypt::Password(self.password_digest).is_password?(password)
    end


    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save
        self.session_token
    end

    def password=(password)
        @password = password
    end
    
    def create
        user = User.create(user_params)
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end