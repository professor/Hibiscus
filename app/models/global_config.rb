class GlobalConfig

  DEFAULT_CONFIG = {'site_title' => "Craftsmanship", 
  'site_tag' => "For software excellence",
  'activity_name' => "Kata",
  'activity_tag' => "kata",
  'comment_default' => "1. Why would you recommend (or not recommend) this activity to a peer?<br /><br />
																															2. What worked well?<br /><br />
																															3. What didn't work well?<br /><br />
																															4. What programming language did you use?<br /><br />
																															5. Where there any 'ah-hah!' moments or unintended consequences?<br /><br />"}

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

    def activity_tag
      config_hash['activity_tag']
    end

    def comment_default
      config_hash['comment_default']
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