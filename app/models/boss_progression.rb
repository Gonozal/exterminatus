class BossProgression < ActiveRecord::Base
  def signup_css
    css_class = []
    css_class << status.downcase.tr(" ", "-")
    css_class.join " "
  end
end
