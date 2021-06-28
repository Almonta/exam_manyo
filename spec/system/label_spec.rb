require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  # let!(:second_user) { FactoryBot.create(:second_user) }
  # let!(:admin) { FactoryBot.create(:admin) }
  # let!(:task) { FactoryBot.create(:task) }
  let!(:task) { FactoryBot.create(:task, user_id: user.id) }
  # let!(:second_task) { FactoryBot.create(:second_task, user_id: user.id) }
  # let!(:third_task) { FactoryBot.create(:third_task, user_id: user.id) }
  # let!(:label) { FactoryBot.create(:label)}
  # let!(:second_label) { FactoryBot.create(:second_label)}
  # let!(:third_label) { FactoryBot.create(:third_label)}

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
    # visit new_session_path
    # user_login
  end

  describe 'ラベル登録' do
    context 'ラベルの新規作成をした場合' do
      it 'ラベル一覧に作成したラベルが表示される' do
        visit new_session_path
        user_login
        visit tasks_path
        click_on 'ラベル登録'
        sleep 0.5
        click_on 'New Label'
        fill_in 'label_name', with: '万葉'
        click_on '登録する'
        sleep 0.5
        visit tasks_path
        # binding.irb
        expect(page).to have_content '万葉'
      end
    end
    context 'タスクの新規作成時にラベルを選択した場合' do
      it '選択したラベルがタスク一覧画面に表示される' do
        visit new_session_path
        user_login
        visit new_task_path
        fill_in 'task_task_name', with: 'test_task1'
        fill_in 'task_details', with: 'test_content1'
        select '2021', from: 'task[deadline(1i)]'
        select '6月', from: 'task_deadline_2i'
        select '22', from: 'task_deadline_3i'
        select '着手中', from: 'task[status]'
        check 'test_label1'
        click_on '登録する'
        # binding.irb
        expect(page).to have_content 'test_label1'
      end
    end
    context 'タスクの新規作成時にラベルを複数選択した場合' do
      it '選択した複数のラベルがタスクに登録される' do
        visit new_session_path
        user_login
        visit new_task_path
        fill_in 'task_task_name', with: 'test_task1'
        fill_in 'task_details', with: 'test_content1'
        select '2021', from: 'task[deadline(1i)]'
        select '6月', from: 'task_deadline_2i'
        select '22', from: 'task_deadline_3i'
        select '着手中', from: 'task[status]'
        check 'test_label1'
        check 'test_label2'
        check 'test_label3'
        # binding.irb
        click_on '登録する'
        expect(page).to have_content 'test_label1' && 'test_label2' && 'test_label3'
      end
    end
    context 'タスク詳細画面を表示した場合' do
      it 'そのタスクに紐付いているラベルの一覧を表示する' do
      end
    end

  end
end

