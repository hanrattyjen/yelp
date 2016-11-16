require 'rails_helper'

feature 'User signs up' do
  scenario 'user can see sign up/in from link on home page if not signed in' do
    visit('/')
    expect(page).to have_link('Sign up')
    expect(page).to have_link('Sign in')
  end

  scenario 'user should not see sign out link' do
    visit('/')
    expect(page).not_to have_link('Sign out')
  end

  scenario 'user signs up' do
    visit('/')
    click_link('Sign up')
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button('Sign up')
    expect(current_path).to eq('/')
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end

feature 'User signs in' do
  before do
    visit('/')
    click_link('Sign up')
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button('Sign up')
    click_link('Sign out')
  end

  scenario 'registered user can sign in' do
    visit('/')
    click_link('Sign in')
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_button('Sign in')
    expect(current_path).to eq('/')

  end
end

feature 'User not signed in' do
  scenario 'User cannot add a restaurant unless signed in' do
    visit('/')
    click_link('Add a restaurant')
    expect(current_path).to eq('/users/sign_in')
  end
end
