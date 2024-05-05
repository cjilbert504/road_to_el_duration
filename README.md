# RoadToElDuration
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "road_to_el_duration"
```

And then execute:
```bash
$ bundle
```
## Usage
```ruby
class Episode < ApplicationRecord
  include RoadToElDuration::Calculations

  belongs_to :series

  serialize :duration, coder: RoadToElDuration::DurationCoder
  updates_duration_of :series
end


class Series < ApplicationRecord
  include RoadToElDuration::Calculations

  has_many :episodes

  serialize :duration, coder: RoadToElDuration::DurationCoder
  calculates_duration_from :episodes
end
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
