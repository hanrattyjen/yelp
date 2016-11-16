production:
  FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]
  # secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
  facebook_app_id: <%= FACEBOOK_CONFIG['app_id'] %>
  facebook_app_secret: <%= FACEBOOK_CONFIG['secret'] %>
