require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task) }
  # let!(:second_task) { FactoryBot.create(:second_task) }
  before do
    FactoryBot.create(:task, task_name: 'task_1')
    FactoryBot.create(:task, task_name: 'task_2')
    FactoryBot.create(:task, task_name: 'task_3')
  end
  
  binding.irb
  
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_task_name', with: 'manyo'
        fill_in 'task_details', with: 'manyokadai'
        fill_in 'task_deadline', with: '2021-06-20'
        click_on '登録する'
        expect(page).to have_content 'manyo'
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
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
    #     task = FactoryBot.create(:task)
    #     task = FactoryBot.create(:second_task)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]). to have_content 'manyo'
        expect(task_list[2]). to have_content 'task_2'
        expect(task_list[3]). to have_content 'task_3'
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

