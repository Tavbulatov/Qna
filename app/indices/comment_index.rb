ThinkingSphinx::Index.define :comment, with: :active_record do
  indexes comment
  indexes author.first_name, as: :author, sortable: true
end
