require 'rails_helper'
require_relative './webhelpers'

feature 'reviewing' do

  before do
    visit('/')
    click_link('Sign up')
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button('Sign up')
    Restaurant.create name: 'KFC'
  end

  scenario 'allows users to leave a review using a form' do
    leave_review('so so', '3')
    expect(current_path).to eq '/restaurants'
    click_link 'KFC'
    expect(page).to have_content('so so')
  end

  scenario 'a user can delete only their own reviews' do
    leave_review('so so', '3')
    click_link 'Sign out'
    click_link 'Sign up'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button('Sign up')
    expect(page).not_to have_content('Delete review')
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('So so', '3')
    click_link 'Sign out'
    sign_up_as_diff_user
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

  def sign_up_as_diff_user
    click_link 'Sign up'
    fill_in 'Email', with: 'jen@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button('Sign up')
  end
end
