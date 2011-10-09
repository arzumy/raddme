class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :friendship, :dependent => :destroy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fullname, :invite_token
  validates_presence_of :fullname, if: :registered?

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
    User.create!(email: new_email, password: new_password, password_confirmation: new_password, invite_token: new_invite_token)
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

  def update_with_password(params={})
    params.delete(:current_password)
    self.update_without_password(params)
  end

  def vcard
    Vpim::Vcard::Maker.make2 do |maker|
      maker.add_name do |name|
        name.fullname = self.fullname
      end
      maker.add_email(self.email) do |mail|
        mail.location = 'work'
        mail.preferred = 'yes'
      end
      maker.title = self.title if self.title
      maker.org = self.organization if self.organization
      maker.add_addr do |addr|
        addr.preferred = true
        addr.location = 'work'
        addr.street = self.street if self.street
        addr.locality = self.locality if self.locality
        addr.postalcode = self.postalcode if self.postalcode
        addr.country = self.country if self.country
      end if [self.street, self.locality, self.postalcode, self.country].any?
      maker.add_tel(self.phone_mobile) do |t|
        t.location = 'mobile'
        t.preferred = true
      end if self.phone_mobile
      maker.add_tel(self.phone_work) do |t|
        t.location = 'work'
        t.preferred = false
      end if self.phone_work
      maker.add_tel(self.phone_fax) do |t|
        t.location = 'work'
        t.capability = 'fax'
      end if self.phone_fax
    end
  end

  protected
  def downcase_email
    self.email.downcase! if self.email
  end
end
