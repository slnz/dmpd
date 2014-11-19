module TimeZoneHelpers
  extend ActiveSupport::Concern

  def self.randomise_timezone!
    offsets = ActiveSupport::TimeZone.all.group_by(&:formatted_offset)
    zones = offsets[offsets.keys.sample]
    Time.zone = zones.sample
    puts "Current rand time zone: #{Time.zone}."
  end

  module ClassMethods
    def context_with_time_zone(zone, &block)
      context ", in the time zone #{zone}," do
        before do
          @prev_time_zone = Time.zone
          Time.zone = zone
        end
        after { Time.zone = @prev_time_zone }
        instance_eval(&block)
      end
    end

    def across_time_zones(options, &block)
      options.assert_valid_keys(:step)
      step_seconds = options.fetch(:step)
      offsets = ActiveSupport::TimeZone.all.group_by(&:utc_offset)
      last_offset = -10.days
      offsets.sort_by { |off, _zones| off }.each do |(current_offset, zones)|
        next unless (current_offset - last_offset) >= step_seconds
        last_offset = current_offset
        context_with_time_zone(zones.sample, &block)
      end
    end
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    TimeZoneHelpers.randomise_timezone!
  end
  config.include TimeZoneHelpers
end
