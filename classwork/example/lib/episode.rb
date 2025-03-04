class Episode
  attr_reader :status

  def status=(new_status)
    @status = new_status
  end

  def publish
    @status = "published"
  end
end