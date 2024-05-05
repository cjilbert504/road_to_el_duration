module RoadToElDuration
  class DurationCoder
    def self.dump(value)
      value.to_i
    end

    def self.load(value)
      initial_duration = ActiveSupport::Duration.build(value || 0)
      ActiveSupport::Duration.new(initial_duration.to_i, convert_parts(initial_duration.parts))
    end

    def self.convert_parts(duration_parts)
      new_duration_parts = {
        hours: duration_parts.delete(:hours) || 0,
        minutes: duration_parts.delete(:minutes) || 0
      }
      duration_parts.delete(:seconds)

      # Take remaining parts (parts larger than hours) and convert to hours
      duration_parts.each do |name, value|
        new_duration_parts[:hours] += value.send(name).in_hours.to_i
      end

      new_duration_parts
    end
  end
end
