require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(task_name: '', details: '失敗テスト')
        expect(task).not_to be_valid
        # expect(task).to be_falsey
        expect(task.errors[:task_name]).to be_present
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        # ここに内容を記載する
        task = Task.new(task_name: '失敗テスト', details: '')
        expect(task).not_to be_valid
        expect(task.errors[:details]).to be_present
        # xpathの方法でやってみたけどだめだった。
        # expect(task(:xpath, '//*[@id="error_explanation"]/ul/li[2]/text()')).to be_present
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        # ここに内容を記載する
        task = Task.new(task_name: '合格テスト', details: '合格テスト')
        # binding.irb
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) { FactoryBot.create(:task, task_name: 'task') }
    let!(:second_task) { FactoryBot.create(:second_task, task_name: "sample") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.search_task_name('ta')).to include(task)
        expect(Task.search_task_name('ta')).not_to include(second_task)
        expect(Task.search_task_name('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに内容を記載する
        expect(Task.search_status('着手中')).to include(task)
        expect(Task.search_status('着手中')).not_to include(second_task)
        expect(Task.search_status('着手中').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに内容を記載する
        expect(Task.search_task_name('ta')).to include(task)
        expect(Task.search_status('着手中')).to include(task)
        expect(Task.search_status('着手中').count).to eq 1
      end
    end
  end
end

