class TaskSerializer < ActiveModel::Serializer
  attributes :id, :created_by, :title, :description
end
