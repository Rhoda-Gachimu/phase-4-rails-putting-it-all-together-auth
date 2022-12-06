class User < ApplicationRecord
    has_many :recipes

    validates :username, presence: true, uniqueness: true
    validates :image_url, :bio , presence: true
    has_secure_password
end
