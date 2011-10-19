require 'spec_helper'

describe User do
  context "validation" do
    context "proper registration" do
      describe "fullname" do
        it "invalid without fullname" do
          user = User.new(fullname: nil, email: 'user02@example.com', password: 'password', password_confirmation: 'password', url: 'user02')
          user.should have(1).error_on(:fullname)
        end
      end

      describe "url" do
        it "invalid without url" do
          user = User.new(fullname: 'fullname', email: 'user02@example.com', password: 'password', password_confirmation: 'password', url: nil)
          user.should have(1).error_on(:url)
        end
      end
    end

    context "user created from user#show page" do
      describe "fullname" do
        it "valid without fullname" do
          user = User.new(fullname: nil, email: 'user02@example.com', password: 'password', password_confirmation: 'password', url: 'user02', invite_token: 'token')
          user.should be_valid
          user.should have(0).error_on(:fullname)
        end
      end

      describe "url" do
        it "valid without url" do
          user = User.new(fullname: 'fullname', email: 'user02@example.com', password: 'password', password_confirmation: 'password', url: nil, invite_token: 'token')
          user.should be_valid
          user.should have(0).error_on(:url)
        end
      end
    end

    describe "email" do
      it "downcase email" do
        user = User.create!(fullname: "downcase", email: 'DOWNCASE@example.com', url: 'downcase', password: 'password', password_confirmation: 'password')
        user.email.should == 'downcase@example.com'
      end
    end
  end

  describe "#friends" do
    it "returns users who are friends" do
      user01 = users(:user01)
      user01.friends.should == [users(:user02)]
    end
  end

  describe "#friend_ids" do
    context "no friends" do
      it "returns empty array" do
        users(:user00).friend_ids.should be_empty
      end
    end
    
    context "with one friend" do
      it "returns array of user id" do
        users(:user01).friend_ids.should == [users(:user02).id]
      end
    end
  end

  describe "User.dummy_create()" do
    context "valid email" do
      it "creates new user" do
        User.dummy_create('thisisnew@example.com').should be_valid
      end
    end

    context "invalid email" do
      it "raise exception" do
        expect do
          User.dummy_create('notanemail')
        end.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#registered?" do
    context "invite token is nil" do
      it "returns true" do
        user = users(:user01)
        user.registered?.should be_true
      end
    end

    context "invite token is not nil" do
      it "returns false" do
        user = users(:user00)
        user.registered?.should_not be_true
      end
    end
  end

  describe "#register!" do

    it "marks user as registered" do
      user = users(:user00)
      user.register!
      user.registered?.should be_true
    end

    it "send emails" do
      user = users(:user01)
      user.register!
      ActionMailer::Base.deliveries.last.to.should == [users(:user02).email]
    end
  end

  describe ".gravatar_url" do
    describe "generates gravatar url" do
      let(:user) {user = users(:user01)}

      def email_md5
        Digest::MD5.hexdigest('user01@example.com')
      end

      it "returns gravatar domain" do
        user.gravatar_url.should match /gravatar\.com/
      end

      describe "returns md5 of trimmed, lowercased email" do
        it "trims the email" do
          u = user
          u.email = ' user01@example.com '
          u.gravatar_url.should match /#{email_md5}/
        end

        it 'lowercase the email' do
          u = user
          u.email = 'USER01@example.com'
          u.gravatar_url.should match /#{email_md5}/
        end
      end

      it "forces default mystery man avatar" do
        user.gravatar_url.should match /d=mm/
      end

      it "rates as pg" do
        user.gravatar_url.should match /r=pg/
      end

      it "type should be png " do
        user.gravatar_url.should match /\.png/
      end
    end
  end

  describe "#vcard" do
    let(:user) {users(:user01)}

    it "includes photo" do
      user.vcard.to_s.should match /PHOTO/
    end

    context 'organization account' do
      it "doesn't not include first name" do
        company = users(:company01)
        company.vcard.to_s.should match /N:;;;;/
      end
    end

    pending 'more spec for vcard'
  end
end