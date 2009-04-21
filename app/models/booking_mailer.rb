class BookingMailer < ActionMailer::Base
  def confirmation_email(booking)
    recipients booking.adults.first.email
    from "International Summer Course Registration <registration@international-summercourse.org>"
    subject "International Summer Course 2009 registration confirmation"
    sent_on Time.now
    body :booking => booking
  end
end
