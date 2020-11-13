feature 'User can see notifications when emails arrive' do
  let(:sender) { FactoryBot.create(:user, name:'Tom', email: 'tom@gmail.com') }
  let(:receiver) { FactoryBot.create(:user, name:'Tim', email: 'tim@gmail.com') }

  it 'when receiver login and click on inbox' do
    sender.send_message(receiver, 'Message', 'Title')
    login_as(receiver, scope: :user)
    visit mailbox_inbox_path
    expect(page).to have_link '1 Inbox', href: '/mailbox/inbox'
  end
  
  it 'when receiver reload current page' do
    login_as(receiver, scope: :user)
    visit mailbox_inbox_path
    expect(page).to have_link 'Inbox', href: '/mailbox/inbox'
    sender.send_message(receiver, 'Message', 'Title')
    visit current_path
    expect(page).to have_link '1 Inbox', href: '/mailbox/inbox'
  end
end
 