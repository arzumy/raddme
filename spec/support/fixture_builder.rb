FixtureBuilder.configure do |fbuilder|
  # rebuild fixtures automatically when these files change:
  fbuilder.files_to_check += Dir["spec/factories/*.rb", "spec/support/fixture_builder.rb"]

  fbuilder.factory do
    # User
    user01 = User.create!(fullname: 'User 01', email: 'user01@example.com', password: 'password', password: 'password')
    name(:user01, user01)
  end
end