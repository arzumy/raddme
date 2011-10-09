class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :friendship, :dependent => :destroy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fullname, :family, :given, :prefix
  validates_presence_of :fullname

  before_validation :downcase_email
  after_create { |user| user.create_friendship }

  def to_param
    self.id.to_s
  end

  def friends
    User.where(:id => friend_ids)
  end

  def friend_ids
    friendship.nil? ? [] : friendship.friend_ids
  end

  def self.dummy_create(new_email)
    new_password = ActiveSupport::SecureRandom::hex(4)
    new_invite_token = ActiveSupport::Base64::urlsafe_encode64(new_email+ActiveSupport::SecureRandom::hex(4))
    User.create(email: new_email, password: new_password, password_confirmation: new_password, invite_token: new_invite_token)
  end

  def registered?
    self.invite_token.nil?
  end

  def add_friend(friend)
    transaction do
      self.friendship.append(friend)
      friend.friendship.append(self)
    end
  end

  protected
  def downcase_email
    self.email.downcase! if self.email
  end
end
