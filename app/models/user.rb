class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :collaborations
  has_many :collaborating_users, through: :collaborations, source: :wikis
  has_many :wikis

  after_initialize { self.role ||= :standard }

  enum role: [:standard, :premium, :admin]
end
