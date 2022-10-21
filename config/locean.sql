CREATE SCHEMA IF NOT EXISTS `locean` ;
USE `locean` ;

CREATE TABLE IF NOT EXISTS `locean`.`prof` (
  `id_prof` INT NOT NULL AUTO_INCREMENT,
  `nome_prof` VARCHAR(40) NULL DEFAULT NULL,
  `email_prof` VARCHAR(80) NULL DEFAULT NULL,
  `senha_prof` VARCHAR(20) NULL DEFAULT NULL,
  `disciplina_prof` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`id_prof`));

CREATE TABLE IF NOT EXISTS `locean`.`curso` (
  `id_curso` INT NOT NULL AUTO_INCREMENT,
  `nome_curso` VARCHAR(40) NULL DEFAULT NULL,
  `categoria` VARCHAR(40) NULL DEFAULT NULL,
  `prof_id_prof` INT NOT NULL,
  PRIMARY KEY (`id_curso`, `prof_id_prof`),
  INDEX `fk_curso_prof1_idx` (`prof_id_prof` ASC) VISIBLE,
  CONSTRAINT `fk_curso_prof1`
    FOREIGN KEY (`prof_id_prof`)
    REFERENCES `locean`.`prof` (`id_prof`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `locean`.`avaliacao` (
  `id_aula` INT NOT NULL AUTO_INCREMENT,
  `nome_aula` VARCHAR(40) NULL DEFAULT NULL,
  `nome_aluno` VARCHAR(40) NULL DEFAULT NULL,
  `curso_id_curso` INT NOT NULL,
  PRIMARY KEY (`id_aula`, `curso_id_curso`),
  INDEX `fk_avaliacao_curso1_idx` (`curso_id_curso` ASC) VISIBLE,
  CONSTRAINT `fk_avaliacao_curso1`
    FOREIGN KEY (`curso_id_curso`)
    REFERENCES `locean`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `locean`.`aula` (
  `id_aula` INT NOT NULL AUTO_INCREMENT,
  `nome_aula` VARCHAR(40) NULL DEFAULT NULL,
  `categoria` VARCHAR(40) NULL DEFAULT NULL,
  `disciplina` VARCHAR(40) NULL DEFAULT NULL,
  `curso_id_curso` INT NOT NULL,
  `prof_id_prof` INT NOT NULL,
  PRIMARY KEY (`id_aula`, `curso_id_curso`, `prof_id_prof`),
  INDEX `fk_aula_curso1_idx` (`curso_id_curso` ASC) VISIBLE,
  INDEX `fk_aula_prof1_idx` (`prof_id_prof` ASC) VISIBLE,
  CONSTRAINT `fk_aula_curso1`
    FOREIGN KEY (`curso_id_curso`)
    REFERENCES `locean`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aula_prof1`
    FOREIGN KEY (`prof_id_prof`)
    REFERENCES `locean`.`prof` (`id_prof`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `locean`.`aluno` (
  `id_aluno` INT NOT NULL AUTO_INCREMENT,
  `nome_aluno` VARCHAR(40) NULL DEFAULT NULL,
  `senha_aluno` CHAR(60) NULL DEFAULT NULL,
  `nasc_aluno` DATE NULL DEFAULT NULL,
  `email_aluno` VARCHAR(80) NULL DEFAULT NULL,
  `curso_id_curso` INT NOT NULL,
  `avaliacao_id_aula` INT NOT NULL,
  `aula_id_aula` INT NOT NULL,
  PRIMARY KEY (`id_aluno`, `curso_id_curso`, `avaliacao_id_aula`, `aula_id_aula`),
  INDEX `fk_aluno_curso_idx` (`curso_id_curso` ASC) VISIBLE,
  INDEX `fk_aluno_avaliacao1_idx` (`avaliacao_id_aula` ASC) VISIBLE,
  INDEX `fk_aluno_aula1_idx` (`aula_id_aula` ASC) VISIBLE,
  CONSTRAINT `fk_aluno_curso`
    FOREIGN KEY (`curso_id_curso`)
    REFERENCES `locean`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aluno_avaliacao1`
    FOREIGN KEY (`avaliacao_id_aula`)
    REFERENCES `locean`.`avaliacao` (`id_aula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aluno_aula1`
    FOREIGN KEY (`aula_id_aula`)
    REFERENCES `locean`.`aula` (`id_aula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- locean.prof
INSERT INTO locean.prof (nome_prof, senha_prof, disciplina_prof, email_prof) VALUES ("João", '5998',STR_TO_DATE ('01-01-1971','%d-%m-%Y'), "joaoprof@hotmail.com");
INSERT INTO locean.prof (nome_prof, senha_prof, disciplina_prof, email_prof) VALUES ("Maria", 'mariade',STR_TO_DATE ('11-07-1991','%d-%m-%Y'), "mariaprofe@hotmail.com");
INSERT INTO locean.prof (nome_prof, senha_prof, disciplina_prof, email_prof) VALUES ("gabriela", 'gabi563',STR_TO_DATE ('14-09-1996','%d-%m-%Y'), "gabriela3@hotmail.com");
INSERT INTO locean.prof (nome_prof, senha_prof, disciplina_prof, email_prof) VALUES ("Anthony Melo", 'antonydev',STR_TO_DATE ('26-12-1981','%d-%m-%Y'), "meloantony@hotmail.com");
INSERT INTO locean.prof (nome_prof, senha_prof, disciplina_prof, email_prof) VALUES ("Bryan Cunha", 'cunhatech',STR_TO_DATE ('17-06-1999','%d-%m-%Y'), "tecnologicocunha@hotmail.com");
INSERT INTO locean.prof (nome_prof, senha_prof, disciplina_prof, email_prof) VALUES ("Camila Aragão", 'aragao2101',STR_TO_DATE ('23-02-1990','%d-%m-%Y'), "aragaomila@hotmail.com");
INSERT INTO locean.prof (nome_prof, senha_prof, disciplina_prof, email_prof) VALUES ("Maria Julia", 'julialeao',STR_TO_DATE ('20-04-1980','%d-%m-%Y'), "juliamaria@hotmail.com");
INSERT INTO locean.prof (nome_prof, senha_prof, disciplina_prof, email_prof) VALUES ("Isaac Rodrigues", 'rodriguesnil',STR_TO_DATE ('12-08-1969','%d-%m-%Y'), "isaac@hotmail.com");
INSERT INTO locean.prof (nome_prof, senha_prof, disciplina_prof, email_prof) VALUES ("Vitória Araújo", 'araujo19',STR_TO_DATE ('25-11-1990','%d-%m-%Y'), "araujo@hotmail.com");
INSERT INTO locean.prof (nome_prof, senha_prof, disciplina_prof, email_prof) VALUES ("Natália da Mata", 'damata14',STR_TO_DATE ('17-07-1994','%d-%m-%Y'), "natalia@hotmail.com");

-- locean.curso
INSERT INTO locean.curso (nome_curso, categoria, prof_id_prof) VALUES ("web","tecnologia", 1);
INSERT INTO locean.curso (nome_curso, categoria, prof_id_prof) VALUE ("ingles","idiomas", 2);
INSERT INTO locean.curso (nome_curso, categoria, prof_id_prof) VALUES ("frances","idiomas", 3);
INSERT INTO locean.curso (nome_curso, categoria, prof_id_prof) VALUES ("automacao","tecnologia", 4);
INSERT INTO locean.curso (nome_curso, categoria, prof_id_prof) VALUES ("adobe xd","ux e desing", 5);
INSERT INTO locean.curso (nome_curso, categoria, prof_id_prof) VALUES ("html e css","programacao", 6);
INSERT INTO locean.curso (nome_curso, categoria, prof_id_prof) VALUES ("excel","informatica basica", 8);
INSERT INTO locean.curso (nome_curso, categoria, prof_id_prof) VALUES ("linguagem pyton","programacao", 9);
INSERT INTO locean.curso (nome_curso, categoria, prof_id_prof) VALUES ("administrando banco de dados","tecnologia da informacao", 7);
INSERT INTO locean.curso (nome_curso, categoria, prof_id_prof) VALUES ("microsoft word","produtividade", 10);

-- locean.avaliacao 
INSERT INTO locean.avaliacao (nome_aula, nome_aluno, curso_id_curso) VALUES ("soma","julio cesar", 1);
INSERT INTO locean.avaliacao (nome_aula, nome_aluno, curso_id_curso) VALUES ("linguagem","carlos eduardo", 2);
INSERT INTO locean.avaliacao (nome_aula, nome_aluno, curso_id_curso) VALUES ("node","rubens brito", 3);
INSERT INTO locean.avaliacao (nome_aula, nome_aluno, curso_id_curso) VALUES ("numeros","carla endente", 4);
INSERT INTO locean.avaliacao (nome_aula, nome_aluno, curso_id_curso) VALUES ("informatica","joel santos", 5);

-- locean.aula
INSERT INTO locean.aula (nome_aula, categoria, disciplina, prof_id_prof, curso_id_curso) VALUES ("informatica",'tecnologia','tecnologia da informacao', 1, 1);
INSERT INTO locean.aula (nome_aula, categoria, disciplina, prof_id_prof, curso_id_curso) VALUES ("login",'tecnologia','tecnologia da informacao', 2, 1);
INSERT INTO locean.aula (nome_aula, categoria, disciplina, prof_id_prof, curso_id_curso) VALUES ("inserindo no banco",'tecnologia','criacao de banco', 3, 2);
INSERT INTO locean.aula (nome_aula, categoria, disciplina, prof_id_prof, curso_id_curso) VALUES ("node js",'tecnologia','programacao', 4, 3);
INSERT INTO locean.aula (nome_aula, categoria, disciplina, prof_id_prof, curso_id_curso) VALUES ("cabecalho no html",'tecnologia','front end', 5, 4);

-- locean.aluno
INSERT INTO locean.aluno (nome_aluno, senha_aluno, nasc_aluno, email_aluno, curso_id_curso, avaliacao_id_aula, aula_id_aula) VALUES ("Nicolas Vieira", '78159',STR_TO_DATE ('21-07-2003','%d-%m-%Y'), "vieirinha@hotmail.com", 1, 1, 1);
INSERT INTO locean.aluno (nome_aluno, senha_aluno, nasc_aluno, email_aluno, curso_id_curso, avaliacao_id_aula, aula_id_aula) VALUES ("Igor da Conceição", 'igorsa',STR_TO_DATE ('04-03-1994','%d-%m-%Y'), "igorda@hotmail.com", 2, 2, 2);
INSERT INTO locean.aluno (nome_aluno, senha_aluno, nasc_aluno, email_aluno, curso_id_curso, avaliacao_id_aula, aula_id_aula) VALUES ("Beatriz Souza", 'souza32',STR_TO_DATE ('20-01-1991','%d-%m-%Y'), "souzabia@hotmail.com", 3, 3, 3);
INSERT INTO locean.aluno (nome_aluno, senha_aluno, nasc_aluno, email_aluno, curso_id_curso, avaliacao_id_aula, aula_id_aula) VALUES ("Leandro Souza", 'Leoleo',STR_TO_DATE ('29-08-1980','%d-%m-%Y'), "leadro@hotmail.com", 4, 4, 4);
INSERT INTO locean.aluno (nome_aluno, senha_aluno, nasc_aluno, email_aluno, curso_id_curso, avaliacao_id_aula, aula_id_aula) VALUES ("Gabriel Rocha", 'bielrocha',STR_TO_DATE ('19-10-1985','%d-%m-%Y'), "gabriel14@hotmail.com", 5, 5, 5);
INSERT INTO locean.aluno (nome_aluno, senha_aluno, nasc_aluno, email_aluno, curso_id_curso, avaliacao_id_aula, aula_id_aula) VALUES ("Diego Peixoto", 'peixotodi',STR_TO_DATE ('27-11-1992','%d-%m-%Y'), "diegopeixe@hotmail.com", 6, 1, 1);
INSERT INTO locean.aluno (nome_aluno, senha_aluno, nasc_aluno, email_aluno, curso_id_curso, avaliacao_id_aula, aula_id_aula) VALUES ("Larissa Monteiro", 'monteirola',STR_TO_DATE ('02-02-2002','%d-%m-%Y'), "larimonteiro@hotmail.com", 7, 2, 2);
INSERT INTO locean.aluno (nome_aluno, senha_aluno, nasc_aluno, email_aluno, curso_id_curso, avaliacao_id_aula, aula_id_aula) VALUES ("Ana Lívia", 'aninhalivia',STR_TO_DATE ('13-06-2000','%d-%m-%Y'), "livia@hotmail.com", 8, 3, 3);
INSERT INTO locean.aluno (nome_aluno, senha_aluno, nasc_aluno, email_aluno, curso_id_curso, avaliacao_id_aula, aula_id_aula) VALUES ("André Caldeira", 'andreconta',STR_TO_DATE ('15-09-1993','%d-%m-%Y'), "dede@hotmail.com", 9, 4, 4);


