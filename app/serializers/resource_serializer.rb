class ResourceSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :resource_string, :resource_type_id, :tag_1, :tag_2, :tag_3
end
