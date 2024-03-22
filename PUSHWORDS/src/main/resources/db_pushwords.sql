-- Suppression des tables si elles existent déjà
DROP TABLE IF EXISTS `tb_note`;
DROP TABLE IF EXISTS `tb_notetype`;
DROP TABLE IF EXISTS `tb_user`;

-- Création de la table `tb_user`
CREATE TABLE IF NOT EXISTS `tb_user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100),
  PRIMARY KEY (`user_id`)
);

-- Création de la table `tb_notetype`
CREATE TABLE IF NOT EXISTS `tb_notetype` (
  `notetype_id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`notetype_id`)
);

-- Création de la table `tb_note`
CREATE TABLE IF NOT EXISTS `tb_note` (
  `note_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT,
  `notetype_id` INT,
  `title` VARCHAR(100),
  `content` TEXT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`note_id`),
  FOREIGN KEY (`user_id`) REFERENCES `tb_user`(`user_id`),
  FOREIGN KEY (`notetype_id`) REFERENCES `tb_notetype`(`notetype_id`)
);

-- Insertion de données dans `tb_user`
INSERT INTO `tb_user` (`username`, `email`) VALUES
('JohnDoe', 'johndoe@example.com'),
('JaneDoe', 'janedoe@example.com');

-- Insertion de données dans `tb_notetype`
INSERT INTO `tb_notetype` (`type_name`) VALUES
('Personnel'),
('Travail'),
('Loisirs');

-- Insertion de données dans `tb_note`
INSERT INTO `tb_note` (`user_id`, `notetype_id`, `title`, `content`) VALUES
(1, 1, 'Note Perso 1', 'Contenu de la note personnelle 1'),
(1, 2, 'Note Travail 1', 'Contenu de la note de travail 1'),
(2, 3, 'Note Loisirs 1', 'Contenu de la note de loisirs 1');
