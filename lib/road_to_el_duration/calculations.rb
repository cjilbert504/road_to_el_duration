module RoadToElDuration
  module Calculations
    extend ActiveSupport::Concern

    included do
      # This callback will update the duration of the current and any previous
      # parent records. It will only update the parent records if the
      # parent_to_update attribute is set.
      #
      after_save_commit :update_any_parent_durations

      # These are class attribute accessors that will be set by the class
      # methods below.
      #
      cattr_accessor :duration_association, :duration_column, :parent_to_update
    end

    class_methods do
      # This class method is used to set the association that the duration will be
      # calculated from. It also sets the column that will be used from the
      # child records to calculate the duration of the parent. The default
      # column is :duration but you can set it to any column that will be used
      # to calculate the duration.
      #
      def calculates_duration_from(association_name, column: :duration)
        self.duration_association = association_name
        self.duration_column = column
      end

      # This class method is used to set the parent association that will be updated.
      #
      def updates_duration_of(parent_association)
        self.parent_to_update = parent_association
      end
    end

    # This method is used to update the duration of the record. It will sum the
    # :duration_column of the associated records and update the :duration_column of
    # the record. It is left as public API so that you can call it manually if
    # needed.
    #
    def update_duration!
      duration_value[send(:duration_column)] = calculate_duration
      update!(**duration_value)
    end

    # This method is used to update the duration of the parent records. It will
    # only update the parent records if the parent_to_update attribute is set.
    # It will update the duration of the current parent record and any previous
    # parent record if the record was transferred or removed from the collection.
    #
    def update_any_parent_durations
      update_previous_parent_duration if transferred_or_removed_from_collection?
      update_current_parent_duration if has_parent_record?
    end

    private

    attr_writer :duration_value

    def duration_value
      @duration_value ||= {}
    end

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
