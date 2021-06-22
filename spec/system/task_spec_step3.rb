require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task) }
  let!(:second_task) { FactoryBot.create(:second_task) }
  before do
    # @task = FactoryBot.create(:task)
    # FactoryBot.create(:second_task)
  end
  
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_task_name', with: 'manyo'
        fill_in 'task_details', with: 'manyokadai'
        select '2021', from: 'task_deadline_1i'
        select '6月', from: 'task_deadline_2i'
        select '22', from: 'task_deadline_3i'
        select '着手中', from: 'task_status'
        click_on '登録する'
        expect(page).to have_content 'manyo'
        expect(page).to have_content 'monyo'
        expect(page).to have_content '2021-06-22'
        expect(page).to have_content '2022-07-23'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # task = FactoryBot.create(:task)
        # FactoryBot.create(:task) #task = がいらないのではと思い試してみた。ダメだった。必要！
        visit tasks_path
        expect(page).to have_content 'manyo'
        expect(page).to have_content 'manyokadai'
        expect(page).to have_content 'monyo'
        expect(page).to have_content 'monyokadai'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
    #     task = FactoryBot.create(:task)
    #     task = FactoryBot.create(:second_task)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]). to have_content 'monyo'
        expect(task_list[1]). to have_content 'manyo'
      end
    end
    context '終了期限が日付の降順に並んでいる場合' do
      it '終了期限が一番先のタスクが一番上に表示される' do
        visit tasks_path
        deadline_list = all('.deadline_row')
        expect(deadline_list[0]). to have_content '2022-07-23'
        expect(deadline_list[1]). to have_content '2021-06-22'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        # task = FactoryBot.create(:task)
        # FactoryBot.create(:task) #task = がいらないのではと思い試してみた。
        visit task_path(task.id)
        expect(page).to have_content 'manyo'
      end
    end
  end
end

