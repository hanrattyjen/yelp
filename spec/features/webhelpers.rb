def leave_review(thoughts, rating)
  # visit('/')
  # click_link('Sign up')
  # fill_in 'Email', with: 'test@test.com'
  # fill_in 'Password', with: '123456'
  # fill_in 'Password confirmation', with: '123456'
  # click_button('Sign up')
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end
