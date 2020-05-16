class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact  
    mail(
      to: 'terakoyasuzuki@gmail.com',
      subject: "メールのタイトル"
      )
  end
end
