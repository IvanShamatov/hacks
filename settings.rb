# encoding: utf-8
class Settings

  # True variant to have "global" settings in Rails:
  #
  # Settings.keys
  #  => {"one"=>"one_value", 
  #      "two"=>"two_value"
  #
  # if your config/settings.yml looks like this
  #   production: &production
  #     keys:
  #       one: one_value
  #       two: two_value

  @app_config = YAML.load_file("#{Rails.root}/config/settings.yml")[Rails.env].with_indifferent_access

  @app_config.each_key do |m|
    define_singleton_method(m.to_sym) do
      @app_config[m]
    end
  end

end