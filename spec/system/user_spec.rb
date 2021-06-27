require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:task) { FactoryBot.create(:task, user_id: user.id) }
  let!(:second_task) { FactoryBot.create(:second_task, user_id: user.id) }
  let!(:third_task) { FactoryBot.create(:third_task, user_id: user.id) }
  before do
    # visit new_session_path
  end
  
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
  describe 'セッション機能' do
    context 'ログインした場合' do
      it 'タスク一覧ページが表示される' do
        visit new_session_path
        user_login
        # admin_login
        # binding.irb
        expect(page).to have_content 'マイページ'
      end
    end
    context 'マイページに飛んだ場合' do
      it 'ユーザの名前が表示される' do
        visit new_session_path
        user_login
        visit user_path(user.id)
        # admin_login
        # binding.irb
        expect(page).to have_content 'test_user1@sample.com'
      end
    end
    context '一般ユーザが他人の詳細画面に飛んだ場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_session_path
        user_login
        visit user_path(second_user.id)
        expect(page).to have_content 'Task一覧'
        # binding.irb
      end
    end
    context 'ログアウトした場合' do
      it 'ログインページが表示される' do
        visit new_session_path
        user_login
        click_on 'Logout'
        # visit session_path(user.id), method: :delete
        expect(page).to have_content 'Log in'
        # binding.irb
        expect(current_path).to eq new_session_path 
      end
    end
    describe '管理画面' do
      context '管理ユーザが管理画面にアクセスした場合' do
        it 'ユーザ一覧ページが表示される' do
          visit new_session_path
          admin_login
          visit admin_users_path
          # binding.irb
          expect(page).to have_content '管理画面'
          expect(current_path).to eq admin_users_path
        end
      end
      context '一般ユーザが管理画面にアクセスした場合' do
        it 'ユーザ一覧ページが表示される' do
          visit new_session_path
          user_login
          visit admin_users_path
          expect(page).to have_content '管理者以外はadminページにアクセス出来ません'
        end
      end
      context '管理ユーザがユーザの新規登録をした場合' do
        it '登録ユーザ一覧画面に追加される' do
          visit new_session_path
          admin_login
          visit new_admin_user_path
          fill_in 'user_name', with: 'test_name1'
          fill_in 'user_email', with: 'test_email1@sample.com'
          fill_in 'user_password', with: 'test_password1'
          fill_in 'user_password_confirmation', with: 'test_password1'
          click_on '登録する'
          expect(page).to have_content '新規ユーザを登録しました'
          expect(page).to have_selector '.name_row', text: 'test_name1'
        end
      end

    end

  end

end