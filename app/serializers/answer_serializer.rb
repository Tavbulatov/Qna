# frozen_string_literal: true

class AnswerSerializer < ActiveModel::Serializer
  # ответ (включает в себя список комментариев, список прикрепленных файлов в виде url и список прикрепленных
  # ссылок)
  attributes :id, :body, :question_id, :author_id, :created_at, :updated_at, :files

  has_many :comments
  has_many :links

  def files
    object.files.map(&:url)
  end
end
