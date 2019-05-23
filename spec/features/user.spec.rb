require 'rails_helper'

RSpec.feature "ユーザー管理機能",type: :feature do

  background do
    @test_user = User.create(name:"テストユーザー",email:"test@mail.com",password:"password",password_confirmation:"password")
    @task = Task.create!(title:"テストタイトル１",content:"テスト本文１",user_id:@test_user.id)
  end
  scenario "ユーザー作成のテスト＆作成と同時にログインするテスト" do
    visit new_user_path
    fill_in "Name",with: "テストユーザー2"
    fill_in "Email",with: "test2@mail.com"
    fill_in "Password",with: "password"
    fill_in "Password confirmation",with: "password"
    click_on "登録する"
    expect(page).to have_content "ユーザー登録完了しました！ログインしています"
  end

  scenario "既に登録されているメールアドレスではユーザー登録出来ないテスト" do
    visit new_user_path
    fill_in "Name",with: "テストユーザー"
    fill_in "Email",with: "test@mail.com"
    fill_in "Password",with: "password"
    fill_in "Password confirmation",with: "password"
    click_on "登録する"
    expect(page).to have_content "Emailはすでに存在します"
  end

  scenario "ログインとログアウトのテスト" do
    visit new_session_path
    fill_in "Email",with: "test@mail.com"
    fill_in "Password",with: "password"
    click_on "ログインする"
    expect(page).to have_content "ログインしました"
    click_on "ログアウト"
    expect(page).to have_content "ログアウトしました"
  end

  scenario "自分のタスクだけが一覧画面に表示されるテスト" do
    User.create(name:"テストユーザー3",email:"test3@mail.com",password:"password",password_confirmation:"password")
    visit new_session_path
    fill_in "Email",with: "test3@mail.com"
    fill_in "Password",with: "password"
    click_on "ログインする"
    click_on "タスク新規登録"
    fill_in "Title", with: "テストタイトル２"
    fill_in "Content", with: "テスト本文２"
    click_on "登録する"
    expect(page).to have_content "テストタイトル２"
    expect(page).not_to have_content "テストタイトル１"
  end

  scenario "ログインせずにタスクのページにアクセスしようとすると、ログインページに遷移するテスト" do
    visit new_task_path
    expect(page).to have_content "ログインが必要です"
    visit tasks_path
    expect(page).to have_content "ログインが必要です"
  end

  scenario "他のユーザーの詳細にアクセス、タスクの編集、削除ができないテスト" do
    User.create(name:"テストユーザー4",email:"test4@mail.com",password:"password",password_confirmation:"password")
    visit new_session_path
    fill_in "Email",with: "test4@mail.com"
    fill_in "Password",with: "password"
    click_on "ログインする"
    visit user_path(@test_user.id)
    expect(page).to have_content "権限がありません"
    visit task_path(@task.id)
    expect(page).to have_content "権限がありません"
    visit edit_task_path(@task.id)
    expect(page).to have_content "権限がありません"
  end

  scenario "ユーザー詳細のテスト" do
    visit new_session_path
    fill_in "Email",with: "test@mail.com"
    fill_in "Password",with: "password"
    click_on "ログインする"
    visit user_path(@test_user.id)
    expect(page).to have_content "#{@test_user.name}のマイページ"
    expect(page).to have_content "#{@test_user.email}"
  end

  scenario "管理画面でユーザー 一覧のテスト" do
    User.create(name:"テストユーザー5",email:"test5@mail.com",password:"password",password_confirmation:"password")
    visit admin_users_path
    expect(page).to have_content "テストユーザー"
    expect(page).to have_content "テストユーザー5"
  end

  scenario "管理画面でユーザー作成のテスト" do
    visit new_admin_user_path
    fill_in "Name",with: "テストユーザー6"
    fill_in "Email",with: "test6@mail.com"
    fill_in "Password",with: "password"
    fill_in "Password confirmation",with: "password"
    click_on "登録する"
    expect(page).to have_content "管理者権限でユーザー登録しました！"
  end

  scenario "管理画面でユーザー情報編集のテスト" do
    visit edit_admin_user_path(@test_user)
    fill_in "Name",with: "テストユーザー7"
    fill_in "Password",with: "hoge"
    fill_in "Password confirmation",with: "hoge"
    click_on "更新する"
    expect(page).to have_content "管理者権限でユーザー情報を編集しました！"
    expect(page).to have_content "テストユーザー7"
  end

  scenario "管理画面でユーザー削除のテスト" do
    visit admin_user_path(@test_user)
    click_on "このユーザーを削除する"
    expect(page).to have_content "管理者権限でユーザーを削除しました"
    expect(page).not_to have_content "テストユーザー1"
  end

  scenario "管理画面のユーザー詳細でそのユーザーのタスク一覧が表示されているかのテスト" do
    Task.create(title:"テストタイトル３",content:"テスト本文３",user_id:@test_user.id)
    visit admin_user_path(@test_user)
    expect(page).to have_content "テストタイトル１"
    expect(page).to have_content "テストタイトル３"
  end
 end