require "spec_helper"

shared_examples "exchange_email" do
  let(:user)    { users(:user01) }
  let(:friend)  { users(:user00) }

  describe "setup" do
    it 'sends to friend' do
      mail.to.should == [friend.email]
    end

    it 'sets reply-to to user' do
      mail.reply_to.should == [user.email]
    end

    it "renders user's email" do
      mail.body.encoded.should match user.email
    end
  end
end

describe UserMailer do
  describe "exchanged_unregistered" do
    it_behaves_like "exchange_email" do
      let(:mail)    { UserMailer.exchanged_unregistered(user, friend) }
    end
  end

  describe "exchanged" do
    it_behaves_like "exchange_email" do
      let(:mail)    { UserMailer.exchanged(user, friend) }
    end
  end
end

