class App < ActiveRecord::Base
	belongs_to :user

	is_impressionable :counter_cache => true

	acts_as_taggable

	validates :image, :attachment_presence => true
    has_attached_file :image, :styles => { :small => "237x200>", :medium => "540x300>", :large => "600x430>", :thumb => "100x100>" }
    validates_attachment_content_type :image, :content_type => /\Aimage/
end
