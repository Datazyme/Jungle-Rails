require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do 
    it "allows a user to register if all fields filled out" do 
      @user = User.new(:first_name => "TEST", :last_name => "Testorius", :email => "test@testorius.com", :password =>"testing", :password_confirmation => "testing")
      expect(@user).to be_valid 
    end 

    it "checks if first_name is blank" do 
      @user = User.new(:first_name => nil, :last_name => "Testorius", :email => "test@testorius.com", :password =>"testing", :password_confirmation => "testing")
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages[0]).to eq("First name can't be blank")
    end 

    it "checks if last_name is blank" do 
      @user = User.new(:first_name => "TEST", :last_name => nil, :email => "test@testorius.com", :password =>"testing", :password_confirmation => "testing")
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages[0]).to eq("Last name can't be blank")
    end 

    it "checks if email is blank" do 
      @user = User.new(:first_name => "TEST", :last_name => "Testorius", :email => nil, :password =>"testing", :password_confirmation => "testing")
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages[0]).to eq("Email can't be blank")
    end 

    it "checks if passwords don't match and doesn't create user if not" do
      @user = User.new(:first_name => "TEST", :last_name => "Testorius", :email => "test@testorius.com", :password =>"testing", :password_confirmation => "testorius")
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
    end

    it "password should have minimum 5 charaters" do 
      @user = User.new(:first_name => "TEST", :last_name => "Testorius", :email => "test@testorius.com", :password =>"test", :password_confirmation => "test")
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages[0]).to eq("Password is too short (minimum is 5 characters)")
    end


    it "emails should be unique case sensitive " do 
      @user = User.new(:first_name => "test", :last_name => "2test",  :email => "test@test.com" , :password => "test12", :password_confirmation => "test12" )
      @user.save
      @user2 =User.new(:first_name => "2test", :last_name => "test",  :email => "test@test.COM" , :password => "2test1", :password_confirmation => "2test1" )
      expect(@user2).not_to be_valid 
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
    end

    it "emails should be unique NOT case sensitive " do 
      @user = User.new(:first_name => "test", :last_name => "2test",  :email => "test@test.com" , :password => "test12", :password_confirmation => "test12" )
      @user.save
      @user2 =User.new(:first_name => "2test", :last_name => "test",  :email => "test@test.com" , :password => "2test1", :password_confirmation => "2test1" )
      expect(@user2).not_to be_valid 
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
    end
  
  describe '.authenticate_with_credentials' do 
      it "should authenticate with credentials" do 
        @user = User.new(:first_name => "test", :last_name => "2test",  :email => "test@test.com" , :password => "test12", :password_confirmation => "test12" )
        @user.save 
        expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
      end


      it "should not authenticate with invalid email" do 
        @user = User.new(:first_name => "test", :last_name => "2test",  :email => "test@test.com" , :password => "test12", :password_confirmation => "test12" )
        @user.save 
        expect(User.authenticate_with_credentials("wrong@test.com", @user.password)).to be_nil
      end

      it "should not authenticate with invalid password" do 
        @user = User.new(:first_name => "test", :last_name => "2test",  :email => "test@test.com" , :password => "test12", :password_confirmation => "test12" )
        @user.save 
        expect(User.authenticate_with_credentials(@user.email, "wrongpassword")).to be_nil
      end

      it "should authenticate with extra spaces before email" do 
        @user = User.new(:first_name => "test", :last_name => "2test",  :email => "test@test.com" , :password => "test12", :password_confirmation => "test12" )
        @user.save 
        expect(User.authenticate_with_credentials("   test@test.com",@user.password)).to eq(@user)
      end


      it "should authenticate with wrong case email" do 
        @user = User.new(:first_name => "test", :last_name => "2test",  :email => "TeST@test.com" , :password => "test12", :password_confirmation => "test12" )
        @user.save 
        expect(User.authenticate_with_credentials("test@TeST.com",@user.password)).to eq(@user)
      end
    end 
  end
end
