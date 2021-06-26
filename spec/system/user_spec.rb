require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user_id: user.id) }
  let!(:second_task) { FactoryBot.create(:second_task, user_id: user.id) }
  let!(:third_task) { FactoryBot.create(:third_task, user_id: user.id) }
  before do
    # visit new_session_path
  end
  def test_login
    fill_in 'session_email', with: 'test_user1@sample.com'
    fill_in 'session_password', with: 'pass1'
    click_on 'Log in'
  end


  describe 'ユーザ登録' do
    context 'ユーザを新規作成した場合' do
      it '作成したユーザが表示される' do
        visit new_user_path
        fill_in 'user_name', with: 'test_name1'
        fill_in 'user_email', with: 'test_email1@sample.com'
        fill_in 'user_password', with: 'test_password1'
        fill_in 'user_password_confirmation', with: 'test_password1'
        # binding.irb
        # click_on 'Create my account'
        # click_on find(:xpath, '/html/body/form/input[6]').click
        find(:xpath, '/html/body/form/input[6]').click
        # create = find(:xpath, '/html/body/form/input[6]')
        # create.click
        # /html/body/form/input[6]
        # test_login
        # visit user_path(user.id)
        expect(page).to have_content 'test_name1'
        expect(page).to have_content 'test_email1@sample.com'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき' do
      it '作成したユーザが表示される' do
        visit tasks_path
        # binding.irb
        expect(page).to have_content 'Log in'
      end
    end
  end
end