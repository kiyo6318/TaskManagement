require 'rails_helper'

RSpec.feature "タスク管理機能",type: :feature do
  scenario "タスク一覧のテスト" do
    Task.create!(title:"テストタイトル1",content:"テスト本文1")
    Task.create!(title:"テストタイトル2",content:"テスト本文2")

    visit tasks_path

    expect(page).to have_content "テストタイトル1"
    expect(page).to have_content "テストタイトル2"
  end

  scenario "タスク作成のテスト" do
    visit new_task_path

    fill_in "Title", with: "テストタイトル3"
    fill_in "Content", with: "テスト本文3"

    click_on "Create Task"

    expect(page).to have_content "テストタイトル3"
  end

  scenario "タスク詳細のテスト" do
    task = Task.create!(title:"テストタイトル4",content:"テスト本文4")

    visit task_path(task.id)

    expect(page).to have_content "テスト本文4"
  end
end