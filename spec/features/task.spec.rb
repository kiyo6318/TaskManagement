require 'rails_helper'

RSpec.feature "タスク管理機能",type: :feature do

  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end

  scenario "タスク一覧のテスト" do
    visit tasks_path

    expect(page).to have_content "タイトル1"
    expect(page).to have_content "タイトル2"
    expect(page).to have_content "タイトル3"
  end

  scenario "タスク作成のテスト" do
    visit new_task_path

    fill_in "Title", with: "タイトル4"
    fill_in "Content", with: "本文4"

    click_on "登録する"

    expect(page).to have_content "タイトル4"
  end

  scenario "タスク詳細のテスト" do
    task = Task.create!(title:"タイトル5",content:"本文5")

    visit task_path(task.id)

    expect(page).to have_content "本文5"
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    click_on "詳細",match: :first
    expect(page).to have_content "タイトル3"
  end
end