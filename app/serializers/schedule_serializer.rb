class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date, :frequency, :active, :task_id
end
