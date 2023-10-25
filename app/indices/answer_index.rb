ThinkingSphinx::Index.define :answer, with: :active_record do
  indexes body
  indexes author.first_name, as: :author, sortable: true
end
