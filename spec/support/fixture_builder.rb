FixtureBuilder.configure do |fbuilder|
  # rebuild fixtures automatically when these files change:
  fbuilder.files_to_check += Dir["spec/factories/*.rb", "spec/support/fixture_builder.rb"]

  fbuilder.factory do
    # User
    user00 = User.create!(email: 'user00@example.com', password: 'password', password: 'password', invite_token: 'token')
    user01 = User.create!(fullname: 'User 01', email: 'user01@example.com', password: 'password', password_confirmation: 'password')
    user02 = User.create!(fullname: 'User 02', email: 'user02@example.com', password: 'password', password_confirmation: 'password')
    name(:user00, user00)
    name(:user01, user01)
    name(:user02, user02)

    # Friendship
    user01.friendship.update_attributes(friend_ids: [user02.id].to_json)
    user02.friendship.update_attributes(friend_ids: [user01.id].to_json)

  end
end