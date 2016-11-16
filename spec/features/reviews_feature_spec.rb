require 'rails_helper'

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
    visit '/restaurants'
    click_link "Review KFC"
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    click_link 'KFC'
    expect(page).to have_content('so so')
  end
end
