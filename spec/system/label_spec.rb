require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  # let!(:second_user) { FactoryBot.create(:second_user) }
  # let!(:admin) { FactoryBot.create(:admin) }
  # let!(:task) { FactoryBot.create(:task, user_id: user.id) }
  # let!(:second_task) { FactoryBot.create(:second_task, user_id: user.id) }
  # let!(:third_task) { FactoryBot.create(:third_task, user_id: user.id) }
  
  def user_login
    fill_in 'session_email', with: 'test_user1@sample.com'
    fill_in 'session_password', with: 'pass1'
    click_on 'Log in'
  end
  
  def admin_login
    fill_in 'session_email', with: 'test_user3@sample.com'
    fill_in 'session_password', with: 'pass3'
    click_on 'Log in'
  end
  
  before do
    visit new_session_path
    user_login
  end

  describe 'ラベル登録' do
    context 'ラベルの新規作成をした場合' do
      it 'ラベル一覧に作成したラベルが表示される' do
        visit tasks_path
        click_on 'ラベル登録'
        sleep 0.5
        click_on 'New Label'
        fill_in 'label_name', with: '万葉'
        click_on '登録する'
        sleep 0.5
        visit tasks_path
        expect(page).to have_content '万葉'
      end
    end
  end
end

