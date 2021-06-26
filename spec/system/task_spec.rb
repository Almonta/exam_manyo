require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # before { user = FactoryBot.create(:user) }
  let!(:user) { FactoryBot.create(:user) }
  # user = FactoryBot.create(:user)
  # let!(:task) { FactoryBot.create(:task) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  # let!(:task) { FactoryBot.create(:task, user_id: user.id) }
  # let!(:second_task) { FactoryBot.create(:second_task) }
  let!(:second_task) { FactoryBot.create(:second_task, user: user) }
  # let!(:second_task) { FactoryBot.create(:second_task, user_id: user.id) }
  # let!(:third_task) { FactoryBot.create(:third_task) }
  let!(:third_task) { FactoryBot.create(:third_task, user: user) }
  # let!(:third_task) { FactoryBot.create(:third_task, user_id: user.id) }
  before do
    # @task = FactoryBot.create(:task)
    # FactoryBot.create(:second_task)
    visit new_session_path
    # fill_in 'session_email', with: 'test_user1@sample.com'
    # fill_in 'session_password', with: 'pass1'
    # click_on 'Log in'
    # /html/body/form/input[5]
    # user = FactoryBot.create(:user)
    # tast_login #ここに書いても遅延だからログインできない
  end
  def test_login
    fill_in 'session_email', with: 'test_user1@sample.com'
    fill_in 'session_password', with: 'pass1'
    click_on 'Log in'
    # visit new_session_path
  end


  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        test_login
        visit new_task_path
        fill_in 'task_task_name', with: 'test_task1'
        fill_in 'task_details', with: 'test_content1'
        select '2021', from: 'task[deadline(1i)]'#'task_deadline_1i'
        select '6月', from: 'task_deadline_2i'
        select '22', from: 'task_deadline_3i'
        select '着手中', from: 'task[status]'
        click_on '登録する'
        expect(page).to have_content 'test_task1'
        expect(page).to have_content 'test_content1'
        expect(page).to have_content '2021-06-22'
        # expect(page).to have_content '2022-07-23'
        expect(page).to have_content '着手中'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      test_login
      sleep 0.2
      visit tasks_path
      sleep 0.2
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # task = FactoryBot.create(:task)
        # FactoryBot.create(:task) #task = がいらないのではと思い試してみた。ダメだった。必要！
        # visit tasks_path
        expect(page).to have_content 'test_task1'
        expect(page).to have_content 'test_content1'
        expect(page).to have_content 'test_task2'
        expect(page).to have_content 'test_content2'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
    #     task = FactoryBot.create(:task)
    #     task = FactoryBot.create(:second_task)
        # visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]). to have_content 'test_task3'
        expect(task_list[1]). to have_content 'test_task2'
        expect(task_list[2]). to have_content 'test_task1'
      end
    end
    context '終了期限が日付の降順に並んでいる場合' do
      it '終了期限が一番先のタスクが一番上に表示される' do
        # visit tasks_path
        # click_link '(ソート)'
        deadline_sort_link = find(:xpath, "/html/body/div/table/tbody/tr[1]/th[3]/a")
        deadline_sort_link.click
        sleep 0.2
        deadline_list = all('.deadline_row')
        expect(deadline_list[0]). to have_content '2023-08-24'
        expect(deadline_list[1]). to have_content '2022-07-23'
        expect(deadline_list[2]). to have_content '2021-06-22'
      end
    end
    context '優先順位が高い順に並んでいる場合' do
      it '優先順位が高のタスクが一番上に表示される' do
        # visit tasks_path
        # binding.irb
        # click_link '(sort)'
        deadline_sort_link = find(:xpath, "/html/body/div/table/tbody/tr[1]/th[6]/a")
        deadline_sort_link.click
        sleep 0.2
        priority_list = all('.priority_row')
        # binding.irb
        expect(priority_list[0]). to have_content '高'
        expect(priority_list[1]). to have_content '中'
        expect(priority_list[2]). to have_content '低'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        # task = FactoryBot.create(:task)
        # FactoryBot.create(:task) #task = がいらないのではと思い試してみた。
        test_login
        visit task_path(task.id)
        expect(page).to have_content 'test_task1'
      end
    end
  end
  describe '検索機能' do
    before do
      test_login
      sleep 0.5
      visit tasks_path
      sleep 0.5
      # FactoryBot.create(:task, title: "task")
      # FactoryBot.create(:second_task, title: "sample")
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        # visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in 'search', with: 'k1'
        # 検索ボタンを押す
        # click_on '検索'
        
        search_link = find(:xpath, "/html/body/form/div/input[2]")
        search_link.click

        # binding.irb
        expect(page).to have_content 'test_task1'
        expect(page).to_not have_content 'test_task2'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        # visit tasks_path
        # プルダウンを選択する「select」について調べてみること
        # fill_in 'search', with: ''
        select '着手中', from: 'status'
        click_on '検索'
        expect(page).to have_selector '.status_row', text: '着手中'
        expect(page).to_not have_selector '.status_row', text: '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに実装する
        # visit tasks_path
        fill_in 'search', with: 'k1'
        select '完了', from: 'status'
        click_on '検索'
        expect(page).to have_content 'test_task1'
        expect(page).to have_selector '.status_row', text: '完了'
        expect(page).not_to have_selector '.status_row', text: '未着手'
      end
    end
  end

end

