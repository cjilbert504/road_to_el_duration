class Episode < ApplicationRecord
  include RoadToElDuration::Calculations

  belongs_to :series

  serialize :duration, coder: RoadToElDuration::DurationCoder
  updates_duration_of :series
end
