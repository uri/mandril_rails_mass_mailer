module MandrillHelper

  def log_and_mandrill_metadata sender=nil, receiver=nil, arugments={}
    mandrill_metadata arugments
    log sender, receiver
  end

  def log receivers=nil, sender =nil
    
    potential_action = caller.detect{ |paths| paths =~ /mailer\.rb/ }
    mailer_action = potential_action[/`.*'/][1..-2] if potential_action
    mailer_name = self.class.to_s

    receivers.respond_to?(:to_a) and receivers = receivers.to_a or [receivers]

    if String === sender
      sender_email = sender
      sender = nil
    elsif sender.respond_to?(:email)
      sender_email = sender.email
    end

    email_log_ids = []
    receivers.each do |receiver|
      email_log = EmailLog.new({
        mailer_name: mailer_name,
        mailer_action: mailer_action,
        from: sender_email,
        sendable: sender
      }).tap do |email_log|
        if String === receiver
          email_log.to = receiver  
        elsif receiver.respond_to?(:email)
          email_log.to = receiver.email
          email_log.receivable = receiver
        end
      end
      email_log.save
      rcpt_mandrill_metadata receiver.email, email_log_id: email_log.id
    end
    
  end

  def mandrill_metadata arguments
    @uniq_args ||= { }
    @uniq_args.merge!(arguments)
    headers["X-MC-Metadata"] = @uniq_args.to_json
  end

private

  def rcpt_mandrill_metadata receiver_email, data
    headers["X-MC-Metadata"] = {_rcpt: receiver_email }.merge(data).to_json
  end

end