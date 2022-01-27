# Preview all emails at http://localhost:3000/rails/mailers/messages_mailer
class MessagesMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/messages_mailer/submitted
  def submitted
    MessagesMailer.submitted Message.first
  end

end
