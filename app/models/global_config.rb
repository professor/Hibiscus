class GlobalConfig

  DEFAULT_CONFIG = {'activity_name' => "Kata"}

  class << self
    def activity_name
      tmp = 1
      config_hash['activity_name']
    end

    def config_hash
      @config_hash ||= DEFAULT_CONFIG.merge(read_settings_hash)
    end

    def read_settings_hash
      if File.exists?("#{Rails.root}/config/hibiscus.yml")
        YAML::load_file("#{Rails.root}/config/hibiscus.yml")[Rails.env.to_s]
      else
        {}
      end
    end
  end


end