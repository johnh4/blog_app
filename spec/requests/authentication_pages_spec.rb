require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  describe "Signin Page" do
  	before { visit signin_path }

  	it { should have_selector('title', text: 'Sign In') }

  	describe "with invalid information" do
  		before { click_button "Sign In" }

  		it { should have_selector('title', text: 'Sign In') }
  		it { should have_selector('div.alert.alert-error', text: 'Invalid') }

  		describe "error should not persist to next page" do
  			before { visit root_path }

  			it { should_not have_selector('div.alert.alert-error') }
  		end
  	end
  
  	describe "with valid information" do
  		before do
  			fill_in "Email",    with: 'testuser@example.com'
  			fill_in "Password", with: 'password'
  			click_button 'Sign In'
  		end

  		specify { signed_in.should_not be_nil }
  	end
  end


end
