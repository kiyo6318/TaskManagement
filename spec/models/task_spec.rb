require "rails_helper"

RSpec.describe Task,type: :model do

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
