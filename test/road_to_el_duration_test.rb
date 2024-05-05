require "test_helper"

class RoadToElDurationTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert RoadToElDuration::VERSION
  end

  test "it updates the parent record duration_column when child records are added or removed" do
    episode = Episode.create(name: "Episode 1", duration: 10.minutes)
    series = Series.create(name: "Series 1")
    episode.update(series: series)

    assert_equal 10.minutes, series.reload.duration
  end

  test "the duration_coder is used to serialize and deserialize the duration column" do
    episode = Episode.create(name: "Episode 1", duration: 10.minutes)
    series = Series.create(name: "Series 1")
    episode.update(series: series)

    binding.irb
    assert_instance_of ActiveSupport::Duration, series.reload.duration
  end
end
