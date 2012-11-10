class GlobalConfig

  ##
  # This is the default configuration hash.
  DEFAULT_CONFIG = {'site_title' => "Craftsmanship", 
  'site_tag' => "Reviewed katas for software excellence",
  'activity_name' => "Kata",
  'activity_type' => "kata",
  'activity_page_header' => "Kata-logue",
  'comment_default' => "1. Why would you recommend (or not recommend) this activity to a peer?<br /><br />
																															2. What worked well?<br /><br />
																															3. What didn't work well?<br /><br />
																															4. What programming language did you use?<br /><br />
																															5. Where there any 'ah-hah!' moments or unintended consequences?<br /><br />"}

  class << self
    ##
    # Get the configured site title.
    def site_title
      config_hash['site_title']
    end

    ##
    # Get the configured site tag.
    def site_tag
      config_hash['site_tag']
    end

    ##
    # Get the configured site activity name.
    def activity_name
      config_hash['activity_name']
    end

    ##
    # Get the configured site activity type.
    def activity_type
      config_hash['activity_type']
    end

    def activity_page_header
      config_hash['activity_page_header']
    end

    ##
    # Get the configured comment placeholder.
    def comment_default
      config_hash['comment_default']
    end

    ##
    # Get the configuration hash.
    def config_hash
      @config_hash ||= DEFAULT_CONFIG.merge(read_settings_hash)
    end

    ##
    # Read the configuration file if any into the configuration hash.
    def read_settings_hash
      if File.exists?("#{Rails.root}/config/hibiscus.yml")
        YAML::load_file("#{Rails.root}/config/hibiscus.yml")[Rails.env.to_s]
      else
        {}
      end
    end
  end
end