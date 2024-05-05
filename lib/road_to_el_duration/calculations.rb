module RoadToElDuration
  module Calculations
    extend ActiveSupport::Concern

    included do
      after_save_commit :update_any_parent_durations
      cattr_accessor :duration_association, :duration_column, :parent_to_update
    end

    class_methods do
      def calculates_duration_from(association_name, column: :duration)
        self.duration_association = association_name
        self.duration_column = column
      end

      def updates_duration_of(parent_association)
        self.parent_to_update = parent_association
      end
    end

    def update_duration!
      update!(duration: calculate_duration)
    end

    def update_any_parent_durations
      update_previous_parent_duration if transferred_or_removed_from_collection?
      update_current_parent_duration if has_parent_record?
    end

    private

    def calculate_duration
      send(duration_association).sum(duration_column)
    end

    def has_parent_record?
      !!send(parent_to_update) if parent_to_update
    end

    def transferred_or_removed_from_collection?
      send(:"#{parent_to_update}_id_previously_changed?") if parent_to_update
    end

    def previous_parent_id
      send(:"#{parent_to_update}_id_previously_was")
    end

    def update_previous_parent_duration
      return if previous_parent_id.nil?
      parent_to_update.to_s.classify.constantize.find(previous_parent_id).update_duration!
    end

    def update_current_parent_duration
      send(parent_to_update).update_duration!
    end
  end
end
