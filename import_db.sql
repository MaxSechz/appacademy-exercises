CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Joe', 'Smith'), ('Carl', 'Cruise'), ('Harry', 'Potter');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Why am I ugly?', 'Everyday I wonder why everyone else is prettier than me', (SELECT id FROM users WHERE fname = 'Harry'));

INSERT INTO
  question_followers (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Joe'), (SELECT questions.id FROM users JOIN questions ON users.id = questions.user_id WHERE users.fname = 'Harry'));

INSERT INTO
  replies(question_id, parent_reply_id, user_id, body)
VALUES
  ((SELECT questions.id FROM questions JOIN users ON users.id = questions.user_id WHERE fname = 'Harry'), null, (SELECT id FROM users WHERE fname = 'Carl'), 'body of reply');

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Carl'), (SELECT questions.id FROM questions JOIN users ON users.id = questions.user_id WHERE fname = 'Harry'));
