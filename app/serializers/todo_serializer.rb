class TodoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :created_by
end
