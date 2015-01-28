class Question < ActiveRecord::Base
  validates :poll_id, :question_text, presence: true

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id,
    dependent: :destroy
  )

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    # answers = answer_choices.includes(:responses)
    # question_response_count = {}
    #
    # answers.each do |answer|
    #   question_response_count[answer.choice_text] = answer.responses.length
    # end
    answer_choices.joins(:responses).group('answer_choices.choice_text').count(:answer_choice_id)
  end


end
