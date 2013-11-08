class EmailInterceptor
  # Observer
  def self.delivered_email message
  end

  # Interceptor
  def self.delivering_email message 
  end
end