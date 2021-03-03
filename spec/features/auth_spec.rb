require 'rails_helper'

feature 'signing up', type: :feature do 
    background :each do 
        visit new_user_url
    end

    scenario "has a user sign up page" do 
        expect(page).to have_content("Sign Up")
    end 

    scenario "has username, password, and age fields" do 
        # save_and_open_page
        expect(page).to have_content("Username")
        expect(page).to have_content("Age")
        expect(page).to have_content("Email")
        expect(page).to have_content("Password")
    end 

    scenario "redirects to user show page and displays username on success" do
        fill_in "Username", with: "dobby"
        fill_in "Age", with: 12
        fill_in "Email", with: "dobby@dobby.com"
        fill_in "Password", with: "password"

        # save_and_open_page
        click_button "Create User"

        expect(page).to have_content("dobby")

        user = User.find_by(username: "dobby")
        expect(current_path).to eq(user_path(user)) #/users/:id
    end

    scenario "re-renders sign up page with invalid user information" do 
        fill_in "Username", with: "dobby"
        fill_in "Age", with: 12
        fill_in "Email", with: "dobby@dobby.com"
        click_button "Create User"

        expect(page).to have_content("Password is too short (minimum is 6 characters")
    end 
end 