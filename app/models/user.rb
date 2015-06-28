class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :apps

  is_impressionable

  has_attached_file :avatar, :styles => { :small => "200x200>", :thumb => "80x80>" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage/
  
end
