class GlobalConfig

  DEFAULT_CONFIG = {'site_title' => "Craftsmanship", 
  'site_tag' => "For software excellence",
  'activity_name' => "Kata"}

  class << self
    def site_title
      config_hash['site_title']
    end  
    
    def site_tag
      config_hash['site_tag']
    end    

    def activity_name
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