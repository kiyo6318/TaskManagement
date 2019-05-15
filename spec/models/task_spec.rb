require "rails_helper"

RSpec.describe Task,type: :model do

  describe "バリデーション" do
    it "titleが空ならバリデーションが通らない" do
      task = Task.new(title:"",content:"テストテストテスト")
      expect(task).not_to be_valid
      expect(task.errors.full_messages).to be_include("Titleを入力してください")
    end

    it "contentが空ならバリデーションが通らない" do
      task = Task.new(title:"テスト",content:"")
      expect(task).not_to be_valid
      expect(task.errors.full_messages).to be_include("Contentを入力してください")
    end

    it "titleとcontentに内容が記載されていればバリデーションが通る" do
      task = Task.new(title:"テスト",content:"テストテストテスト")
      expect(task).to be_valid
      expect(task.errors.full_messages).not_to be_present
    end

    it "titleが51文字以上だとバリデーションが通らない" do
      task = Task.new(title:"a"*51,content:"テストテストテスト")
      expect(task).not_to be_valid
      expect(task.errors.full_messages).to be_include("Titleは50文字以内で入力してください")
    end

    it "contentが151文字以上だとバリデーションが通らない" do
      task = Task.new(title:"テスト",content:"a"*151)
      expect(task).not_to be_valid
      expect(task.errors.full_messages).to be_include("Contentは150文字以内で入力してください")
    end

    it "titleが50文字以内、contentが150文字以内にならばバリデーションが通る" do
      task = Task.new(title:"a"*50,content:"b"*150)
      expect(task).to be_valid
      expect(task.errors.full_messages).not_to be_present
    end
  end

  describe "スコープ" do
    before do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
      FactoryBot.create(:third_task)
    end
    it "title_status_like_whereのテスト" do
      expect(Task.title_status_like_where("タイトル3","着手中")).to eq Task.where("title LIKE ? AND status LIKE ?","%タイトル3%","%着手中%")
    end

    it "title_like_whereのテスト" do
      expect(Task.title_like_where("タイトル2")).to eq Task.where("title LIKE ?","%タイトル2%")
    end

    it "status_like_whereのテスト" do
      expect(Task.status_like_where("着手中")).to eq Task.where("status LIKE ?","%着手中%")
    end

    it "created_at_descのテスト" do
      expect(Task.created_at_desc).to eq Task.all.order(created_at: :desc)
    end
    it "deadline_descのテスト" do
      expect(Task.deadline_desc).to eq Task.all.order(deadline: :desc)
    end
  end
end
