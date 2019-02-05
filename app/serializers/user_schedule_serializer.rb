class UserScheduleSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :schedule_id, :completed
end
