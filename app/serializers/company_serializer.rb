class CompanySerializer < ActiveModel::Serializer
  attributes :id, :logo_path, :name, :description, :logo_filename, :active
end
