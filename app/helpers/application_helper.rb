module ApplicationHelper
  def generate_random_password
    Random.hex(12)
  end
end
