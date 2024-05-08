class Course < ApplicationRecord
  has_many :videos

  include RoadToElDuration::Calculations

  serialize :run_time, coder: RoadToElDuration::DurationCoder
  calculates_duration_from :videos, column: :length
end
