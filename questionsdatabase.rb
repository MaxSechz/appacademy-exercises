require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end

end

module Save
  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?,?)

      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname, @id)
        UPDATE
          users
        SET
          fname = ?,
          lname = ?
        WHERE
          id = ?
      SQL
    end

end

class User

  attr_accessor :id, :fname, :lname

  def self.find_by_name(fname, lname)
    result = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    result.map {|user| User.new(user)}
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    User.new(result.first)
  end

  def initialize(options = {})
    @id = options["id"]
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_user_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    Follower.followed_questions_for_user_id(@id)
  end

  def liked_questions
    Like.liked_questions_for_user_id(@id)
  end

  def average_karma
    result = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        CAST (COUNT(likes.id) AS FLOAT)/COUNT(DISTINCT(questions.id)) AS karma
      FROM
        questions
      LEFT OUTER JOIN
        question_likes AS likes
      ON
        likes.question_id = questions.id
      WHERE
        questions.user_id = ?
    SQL

    result.first['karma']
  end

  def save

    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?,?)

      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname, @id)
        UPDATE
          users
        SET
          fname = ?,
          lname = ?
        WHERE
          id = ?
      SQL
    end
  end
end

class Question

  attr_accessor :id, :title, :body, :user_id

  def self.most_liked(n)
    Like.most_liked_questions(n)
  end

  def self.most_followed(n)
    Follower.most_followed_questions(n)
  end

  def self.find_by_user_id(user_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL
    result.map {|question| Question.new(question)}
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    Question.new(result.first)
  end

  def initialize(options={})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    Follower.followers_for_question_id(@id)
  end

  def likers
    Like.likers_for_question_id(@id)
  end

  def num_likes
    Like.num_likes_for_question_id(@id)
  end

  def save
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @user_id)
      INSERT INTO
        questions(title, body, user_id)
      VALUES
        (?,?,?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end



end

class Follower

  attr_accessor :id, :question_id, :user_id

  def self.most_followed_questions(n)
    result = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions
      JOIN
        question_followers
      ON
        question_followers.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_followers.user_id) DESC
      LIMIT ?
    SQL

    result.map { |question| Question.new(question) }
  end


  def self.followers_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        question_followers
      JOIN
        users
      ON
        users.id = question_followers.user_id
      WHERE
        question_followers.question_id = ?
    SQL

    result.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        question_followers
      JOIN
        questions
      ON
        questions.id = question_followers.question_id
      WHERE
        question_followers.user_id = ?
    SQL

    result.map {|question| Question.new(question)}
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_followers
      WHERE
        id = ?
    SQL

    Follower.new(result.first)
  end

  def initialize(options={})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

end

class Reply

  attr_accessor :id, :question_id, :user_id, :body, :parent_reply_id

  def self.find_by_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    result.map{|reply| Reply.new(reply)}
  end

  def self.find_by_user_id(user_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    result.map{|reply| Reply.new(reply)}
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
      SQL

    Reply.new(result.first)
  end

  def initialize(options={})
    @id = options['id']
    @question_id = options['question_id']
    @body = options['body']
    @user_id = options['user_id']
    @parent_reply_id = options['parent_reply_id']
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_reply_id)
  end

  def child_replies
    result = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL

    result.map {|reply| Reply.new(reply)}
  end

  def save
      QuestionsDatabase.instance.execute(<<-SQL, @question_id, @parent_reply_id, @user_id, @body)
      INSERT INTO
        replies(question_id, parent_reply_id, user_id, body)
      VALUES
        (?,?,?,?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
  end
end

class Like

  attr_accessor :id, :question_id, :user_id

  def self.likers_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        users
      JOIN
        question_likes
      ON
        question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL

    result.map {|user| User.new(user)}
  end

  def self.num_likes_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(users.id) AS count
      FROM
        users
      JOIN
        question_likes
      ON
        question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
      GROUP BY
        question_likes.question_id
    SQL

    result.first['count']
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL

    Like.new(result.first)
  end

  def self.liked_questions_for_user_id(user_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions
      JOIN
        question_likes
      ON
        question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL
    result.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    result = QuestionsDatabase.instance.execute(<<-SQL, n)

      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions
      JOIN
        question_likes
      ON
        question_likes.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_likes.user_id) DESC
      LIMIT ?
    SQL

    result.map { |question| Question.new(question) }
  end

  def initialize(options={})
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

end
