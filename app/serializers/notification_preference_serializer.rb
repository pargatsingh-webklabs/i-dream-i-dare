class NotificationPreferenceSerializer < ActiveModel::Serializer
  attributes :id, :notification_reason, :notification_type, :user_id
end
