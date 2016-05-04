require 'spec_helper'

describe 'StaticPages' do
  subject { page }
  describe 'Home page' do
    before { visit root_path }
    it { should have_title full_title('') }
    it { should have_content 'Sample App' }
    it { should_not have_title '| Home' }

    describe 'for signed-in users' do
      let(:user) { create :user }
      before do
        create :micropost, user: user, content: 'Lorem ipsum'
        create :micropost, user: user, content: 'Dolor sit amet'
        sign_in user
        visit root_path
      end

      it 'should render the user\'s feed' do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  describe 'Help page' do
    it 'should have the right title' do
      visit help_path
      expect(page).to have_title(full_title('Help'))
    end

    it 'should have the content "Help"' do
      visit help_path
      expect(page).to have_content('Help')
    end
  end

  describe 'About page' do
    it 'should have the right title' do
      visit about_path
      expect(page).to have_title(full_title('About Us'))
    end

    it 'should have the content "About Us"' do
      visit about_path
      expect(page).to have_content('About Us')
    end
  end

  describe 'Contact page' do
    it 'should have the content "Contact"' do
      visit contact_path
      expect(page).to have_content('Contact')
    end

    it 'should have the title "Contact"' do
      visit contact_path
      expect(page).to have_title(full_title('Contact'))
    end
  end
end
