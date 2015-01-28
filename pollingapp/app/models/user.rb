class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(
    :authored_polls,
    class_name: 'Poll',
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: 'Response',
    foreign_key: :user_id,
    primary_key: :id
  )

  def completed_polls
    # Poll.find_by_sql [<<-SQL, self.id]
    #   SELECT
    #     polls.*
    #   FROM
    #     polls
    #   JOIN
    #     questions ON questions.poll_id = polls.id
    #   LEFT OUTER JOIN
    #     (
    #     SELECT
    #       *
    #     FROM
    #       responses
    #     JOIN
    #       answer_choices ON answer_choices.id = responses.answer_choice_id
    #     WHERE
    #       responses.user_id = ?
    #     ) as user_answers
    #   ON
    #     questions.id = user_answers.question_id
    #   GROUP BY
    #     polls.id
    #   HAVING
    #     COUNT(DISTINCT questions.id) = COUNT(user_answers.user_id)
    # SQL

    join = 'JOIN questions ON questions.poll_id = polls.id JOIN answer_choices ON answer_choices.question_id = questions.id JOIN responses ON responses.answer_choice_id = answer_choices.id JOIN answer_choices AS all_answer_choices ON all_answer_choices.id = responses.answer_choice_id JOIN questions AS all_questions ON all_questions.id = all_answer_choices.question_id JOIN polls as all_polls ON all_polls.id = all_questions.poll_id JOIN questions AS final_questions ON final_questions.poll_id = all_polls.id'

    Poll.joins(join).group('polls.id').where('responses.user_id = ?', self.id).having('(COUNT(DISTINCT final_questions.id) ) = COUNT(responses.id)')


  end
end
