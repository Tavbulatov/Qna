class QuestionSerializer < ActiveModel::Serializer
  # вопрос (включает в себя список комментариев, список прикрепленных файлов в виде url и
  # список прикрепленных ссылок)

  attributes :id, :author_id, :title, :body, :best_answer_id, :created_at, :updated_at, :files

  has_many :answers, serializer: AnswersSerializer
  has_many :comments
  has_many :links

  def files
    object.files.map {_1.url}
  end
end
