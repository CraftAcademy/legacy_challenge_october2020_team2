feature 'User' do
  let(:sender) { FactoryBot.create(:user, name: 'Nametoo', email: 'sender@mail.com') }
  let(:receiver) { FactoryBot.create(:user, name: 'Namethree', email: 'receiver@mail.com') }
  before do
    sender.send_message(receiver, 'A message', 'Subject')
    login_as(receiver, scope: :user)
    visit mailbox_inbox_path   
  end
    
  it 'can reply to message in inbox' do
    click_on "View"
    expect(page).to have_text 'A message'
    fill_in 'Reply Message', with: 'A reply'
    click_on "Reply"
    expect(page).to have_content 'Your reply message was successfully sent!'
  end

  it 'cannot reply to message without content' do
    click_on "View"
    expect(page).to have_text 'A message'
    fill_in 'Reply Message', with: ''
    click_on "Reply"
    expect(current_path).to eq mailbox_inbox_path
    expect(page).to have_content 'Please write a message'
  end
end

