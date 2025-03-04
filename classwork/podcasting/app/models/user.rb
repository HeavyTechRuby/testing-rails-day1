class User < ApplicationRecord
  def blocked?
    status == "blocked"
  end
end
