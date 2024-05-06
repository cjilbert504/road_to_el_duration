class Episode < ApplicationRecord
  include RoadToElDuration::Calculations

  belongs_to :series, optional: true

  serialize :duration, coder: RoadToElDuration::DurationCoder
  updates_duration_of :series
end
