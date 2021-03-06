class Notifications::NotifyCommand
  def initialize(notification)
    @notification = notification
  end

  def execute
    ActiveRecord::Base.transaction do
      @notification.update!(sent_at: Time.current)
      TelegramNotification.new(@notification.recipient, @notification.message).run
    end
  end
end
