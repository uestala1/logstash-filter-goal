# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "json"

# This  filter will replace the contents of the default 
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an .
class LogStash::Filters::Goal < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   {
  #     goal {
  #       json => "Path to Json file"
  #       type => "My Type"
  #       category => "My Category"
  #       action => "My Action"
  #   }
  # }
  #
  config_name "goal"
  
  config :json, :validate => :string, :default => nil

  config :type, :validate => :string, :default => ""
  config :category, :validate => :string, :default => ""
  config :action, :validate => :string, :default => ""
  

  public
  def register
    # Add instance variables 
  end # def register

  public
  def filter(event)

    if @json.nil?
      @json = ::File.expand_path('../../../../json/goals.json', __FILE__)
    end

    file = ::File.read(@json)
    json = JSON.parse(file)

    value = self.get_children(json["data"], event.get(@type))
    if value.is_a? String
      event.set("[goal][goal_name]", value)
    elsif !value.nil?
      json = value
      value = self.get_children(json, event.get(@category))
      if value.is_a? String
        event.set("[goal][goal_name]", value)
      elsif !value.nil?
        json = value
        value = self.get_children(json, event.get(@action))
        if value.is_a? String
          event.set("[goal][goal_name]", value)
        end
      end
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter

  def get_children(json, pattern)

    json.each do |child|
      if child["comparison"].eql? "match"
        if child["pattern"].eql? pattern
          if child.key?("value")
            return child["value"]
          else
            return child["options"]
          end
        end
      elsif child["comparison"].eql? "regex"
        if pattern.scan(Regexp.new(child["pattern"])).size > 0
          if child.key?("value")
            return child["value"]
          else
            return child["options"]
          end
        end
      end
    end

    return nil
        
  end

end # class LogStash::Filters::Goal
