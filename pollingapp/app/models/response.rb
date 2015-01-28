class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_is_not_author
  validate :respondent_has_not_already_answered_question

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  
  def sibling_responses
    # self.question.responses.where(' ? IS NULL OR responses.id != ?', self.id, self.id)

    Response
      .select('DISTINCT responses_answer_choices.*')
      .joins(answer_choice: [question: [answer_choices: :responses]])
      .where('answer_choices.id = ?', self.answer_choice_id)
      .where(' ? IS NULL OR responses_answer_choices.id != ?', self.id, self.id)
  end

  def respondent_has_not_already_answered_question
    sibling_ids = sibling_responses.pluck(:id)
    if Response.exists?(id: sibling_ids, user_id: self.user_id)
      errors[:base] << "Can't answer question more than once"
    end
  end

  def respondent_is_not_author
    poll_author = Poll
      .joins(questions: :answer_choices)
      .where('answer_choices.id = ?', self.answer_choice_id)
      .first
      .author_id

    if poll_author == user_id
       errors[:user_id] << "You can't respond to your own poll"
    end
  end

end
