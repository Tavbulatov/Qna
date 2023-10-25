ThinkingSphinx::Index.define :question, with: :active_record do
  indexes title, sortable: true
  indexes body
  indexes author.first_name, as: :author, sortable: true
end
