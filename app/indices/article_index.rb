ThinkingSphinx::Index.define :article, :with => :active_record do
  # fields
  indexes title, :sortable => true
  indexes description

  # attributes
  has channel_id
  has created_at
  has updated_at
  has pub_date
  had read
end
