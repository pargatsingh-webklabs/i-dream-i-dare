class BioSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :profile_text, :style_text, :expertise
end
