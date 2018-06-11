class QuoteSerializer < ActiveModel::Serializer
  attributes :id, :body, :author, :url_for_image
end
