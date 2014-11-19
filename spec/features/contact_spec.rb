require 'rails_helper.rb'

feature 'Looking up recipes', js: true do
  let(:user) { create(:user) }
  before do
    login_as(user, scope: :user)
  end
  scenario 'finding recipes' do
    visit '/'
    find('#main_navigation a[href="#contacts"]').click
    expect(page).to have_content('Baked Potato')
    expect(page).to have_content('Baked Brussel Sprouts')
  end
end
