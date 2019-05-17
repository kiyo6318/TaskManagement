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
    fill_in "Deadline",with: "2020-01-01"
    select "高",from: "task_priority"
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

  scenario "’終了期限でソートする’リンクをクリックしたら終了期限の降順で表示されるかのテスト" do
   visit tasks_path
   click_on "終了期限でソートする"
   click_on "詳細",match: :first
   expect(page).to have_content "2020年03月01日"
  end

  scenario "’優先順位でソートする’リンクをクリックしたら優先順位の高い順に表示されるかのテスト" do
    visit tasks_path
    click_on "優先順位でソートする"
    click_on "詳細",match: :first
    expect(page).to have_content "高"
  end

  scenario "タスク一覧の1ページ内にタスクが12個だけ表示されるかのテスト" do
    60.times do |i = 4|
      Task.create!(id:i, title: "タイトル#{i}", content: "本文#{i}" , deadline: Date.today , status: "未着手" ,priority: "high")
    end
    visit tasks_path
    expect(all("table tr").size).to eq(13) #見出しで１行
  end

  scenario "ページネーション(next)" do
    57.times do |i|
      Task.create!(id:i, title: "タイトル#{i}", content: "本文#{i}" , deadline: Date.today , status: "未着手" ,priority: "high")
    end
    visit tasks_path

    click_on "Next"
    first_task = all("table tr td")[0]
    expect(first_task).to have_content "タイトル47"
  end

  scenario "ページネーション(Last)" do
    57.times do |i|
      Task.create!(id:i, title: "タイトル#{i}", content: "本文#{i}" , deadline: Date.today , status: "未着手" ,priority: "high")
    end
    visit tasks_path

    click_on "Last"
    first_task = all("table tr td")[0]
    expect(first_task).to have_content "タイトル11"
  end

  scenario "ページネーション(Previous)" do
    57.times do |i|
      Task.create!(id:i, title: "タイトル#{i}", content: "本文#{i}" , deadline: Date.today , status: "未着手" ,priority: "high")
    end
    visit tasks_path

    click_on "Last"
    click_on "Previous"
    first_task = all("table tr td")[0]
    expect(first_task).to have_content "タイトル23"
  end

  scenario "ページネーション(First)" do
    57.times do |i|
      Task.create!(id:i, title: "タイトル#{i}", content: "本文#{i}" , deadline: Date.today , status: "未着手" ,priority: "high")
    end
    visit tasks_path

    click_on "Last"
    click_on "First"
    first_task = all("table tr")[4]
    expect(first_task).to have_content "タイトル56"
  end
end

RSpec.feature "タスク検索機能",type: :feature do
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end
  scenario "titleとstatus両方で絞り込み検索テスト" do
    visit tasks_path
    fill_in "title_search", with: "タイトル1"
    select "完了", from: "status_search"
    click_on "検索"
    expect(page).to have_content "タイトル1"
    expect(page).not_to have_content "タイトル2"
    expect(page).not_to have_content "タイトル3"
  end
  scenario "titleだけで絞り込み検索テスト" do
    visit tasks_path
    fill_in "title_search", with: "タイトル2"
    click_on "検索"
    expect(page).to have_content "タイトル2"
    expect(page).not_to have_content "タイトル1"
    expect(page).not_to have_content "タイトル3"
  end
  scenario "statusだけで絞り込み検索テスト" do
    visit tasks_path
    select "着手中",from: "status_search"
    click_on "検索"
    expect(page).to have_content "タイトル3"
    expect(page).not_to have_content "タイトル1"
    expect(page).not_to have_content "タイトル2"
  end
  scenario "条件なしで検索すると全タスクが表示されるテスト" do
    visit tasks_path
    click_on "検索"
    expect(page).to have_content "タイトル1"
    expect(page).to have_content "タイトル2"
    expect(page).to have_content "タイトル3"
  end
  scenario "存在しないタイトルで検索すると一つも表示されないテスト" do
    visit tasks_path
    fill_in "title_search",with: "タイトル4"
    click_on "検索"
    expect(page).not_to have_content "タイトル1"
    expect(page).not_to have_content "タイトル2"
    expect(page).not_to have_content "タイトル3"
  end
end