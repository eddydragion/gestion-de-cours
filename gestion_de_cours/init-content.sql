-- Créer un schéma dédié
CREATE SCHEMA IF NOT EXISTS content;

-- TABLE COURSES
CREATE TABLE Courses (
   id SERIAL PRIMARY KEY,
   title VARCHAR(100) NOT NULL,
   theme VARCHAR(100),
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE CHAPTERS
CREATE TABLE Chapters (
   id SERIAL PRIMARY KEY,
   course_id INT NOT NULL,
   title VARCHAR(100),
   content TEXT,
   type VARCHAR(50),
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY (course_id) REFERENCES Courses(id)
     ON DELETE CASCADE
);

-- TABLE LEVELS
CREATE TABLE Levels (
   id SERIAL PRIMARY KEY,
   name VARCHAR(100),
   user_id INT NOT NULL,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE EXERCICES
CREATE TABLE Exercices (
   id SERIAL PRIMARY KEY,
   chapter_id INT,
   level_id INT,
   course_id INT,
   name VARCHAR(100),
   content TEXT,
   type VARCHAR(50),
   statut VARCHAR(50),
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

   FOREIGN KEY (chapter_id) REFERENCES Chapters(id)
     ON DELETE SET NULL,

   FOREIGN KEY (level_id) REFERENCES Levels(id)
     ON DELETE SET NULL,

   FOREIGN KEY (course_id) REFERENCES Courses(id)
     ON DELETE SET NULL
);

-- TABLE CORRECTION
CREATE TABLE Correction (
   id SERIAL PRIMARY KEY,
   exercice_id INT NOT NULL,
   content TEXT,
   source VARCHAR(50),
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

   FOREIGN KEY (exercice_id) REFERENCES Exercices(id)
     ON DELETE CASCADE
);

-- TABLE courses_has_levels (many-to-many)
CREATE TABLE Courses_Levels (
   course_id INT NOT NULL,
   level_id INT NOT NULL,
   PRIMARY KEY (course_id, level_id),

   FOREIGN KEY (course_id) REFERENCES Courses(id)
     ON DELETE CASCADE,

   FOREIGN KEY (level_id) REFERENCES Levels(id)
     ON DELETE CASCADE
);
