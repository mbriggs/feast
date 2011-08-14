require 'spec_helper'

describe User do
  context "#find_or_create_by_token" do
    let(:token) do
      {
        'user_info' => {
          'email' => 'foo@nulogy.com'
        }
      }
    end

    after(:each) { User.destroy_all }

    it "can find" do
      user = User.create! \
        email: 'foo@nulogy.com',
        password: 'password'

      result = User.find_or_create_by_token(token)

      result.should == user
    end

    it "can create" do
      User.find_or_create_by_token(token)
      User.all.count.should == 1
    end
  end
end
