require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Home'" do
      visit root_path
    end

    it "should have the title 'Home'" do
      visit root_path
      expect(page).to have_title("Game Swap")
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
    end

    it "should have the title 'Help'" do
      visit help_path
      expect(page).to have_title("Game Swap | Help")
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit about_path
      expect(page).to have_content('About Us')
    end

    it "should have the title 'About'" do
      visit about_path
      expect(page).to have_title("Game Swap | About")
    end
  end
 

  describe "Contact page" do

    it "should have the content 'Contact'" do
      visit contact_path
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Contact'" do
      visit contact_path
      expect(page).to have_title("Game Swap | Contact")
    end
  end

end

