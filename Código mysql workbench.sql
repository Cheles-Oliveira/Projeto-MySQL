# codigo para mostrar tabelas 
show tables;

# codigo para criar meu banco de dados
create database sistema_gestao_faculdade;

# codigo para usar meu bancos de dados
use sistema_gestao_faculdade;

#select mostra informacoes das tabelas
SELECT * FROM tbl_curso;
SELECT * FROM tbl_aluno;
SELECT * FROM tbl_email;
SELECT * FROM tbl_cursos_relacionados;
SELECT * FROM tbl_disciplina;
SELECT * FROM tbl_professor;
SELECT * FROM tbl_turma;
SELECT * FROM tbl_horario;
SELECT * FROM tbl_disciplinas_ministradas;
SELECT * FROM tbl_historico;
SELECT * FROM tbl_frequencia;
SELECT * FROM tbl_nota;

#drop serve para poder deletar tabelas.
DROP TABLE IF EXISTS tbl_nota;
DROP TABLE IF EXISTS tbl_frequencia;
DROP TABLE IF EXISTS tbl_historico;
DROP TABLE IF EXISTS tbl_disciplinas_ministradas;
DROP TABLE IF EXISTS tbl_horario;
DROP TABLE IF EXISTS tbl_turma;
DROP TABLE IF EXISTS tbl_professor;
DROP TABLE IF EXISTS tbl_disciplina;
DROP TABLE IF EXISTS tbl_cursos_relacionados;
DROP TABLE IF EXISTS tbl_email;
DROP TABLE IF EXISTS tbl_aluno;
DROP TABLE IF EXISTS tbl_curso;

# codigo create table para criar tabelas
CREATE TABLE tbl_curso (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    curso VARCHAR(45),
    duracao_semestre VARCHAR(45),
    carga_horaria_total VARCHAR(45),
    coordenador_nome VARCHAR(45)
);

CREATE TABLE tbl_aluno (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(45),
    nome VARCHAR(45),
    matricula INT,
    data_nascimento DATE,
    tbl_curso_id INT,
    CONSTRAINT fk_aluno_curso FOREIGN KEY (tbl_curso_id) REFERENCES tbl_curso(id)
);

CREATE TABLE tbl_email (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(45),
    tbl_aluno_id INT,
    CONSTRAINT fk_email_aluno FOREIGN KEY (tbl_aluno_id) REFERENCES tbl_aluno(id)
);

CREATE TABLE tbl_cursos_relacionados (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cursos_relacionados VARCHAR(100),
    tbl_curso_id INT,
    CONSTRAINT fk_cursosrelacionados_curso FOREIGN KEY (tbl_curso_id) REFERENCES tbl_curso(id)
);

CREATE TABLE tbl_disciplina (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    carga_horaria INT
);

CREATE TABLE tbl_professor (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(45),
    nome VARCHAR(45),
    titulacao VARCHAR(45),
    carga_horaria_total VARCHAR(45)
);

CREATE TABLE tbl_turma (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sala VARCHAR(45),
    turno VARCHAR(45),
    limites_alunos INT,
    semestre VARCHAR(45),
    tbl_curso_id INT,
    CONSTRAINT fk_turma_curso FOREIGN KEY (tbl_curso_id) REFERENCES tbl_curso(id)
);

CREATE TABLE tbl_horario (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    turno VARCHAR(45),
    sala VARCHAR(45),
    dia_semana VARCHAR(45),
    horario_inicio VARCHAR(45),
    horario_fim VARCHAR(45),
    tbl_turma_id INT,
    CONSTRAINT fk_horario_turma FOREIGN KEY (tbl_turma_id) REFERENCES tbl_turma(id)
);

CREATE TABLE tbl_disciplinas_ministradas (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    disciplinas_ministradas VARCHAR(45),
    tbl_disciplinas_id INT,
    tbl_professor_id INT,
    tbl_turma_id INT,
    CONSTRAINT fk_ministradas_disciplina FOREIGN KEY (tbl_disciplinas_id) REFERENCES tbl_disciplina(id),
    CONSTRAINT fk_ministradas_professor FOREIGN KEY (tbl_professor_id) REFERENCES tbl_professor(id),
    CONSTRAINT fk_ministradas_turma FOREIGN KEY (tbl_turma_id) REFERENCES tbl_turma(id)
);

CREATE TABLE tbl_historico (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ano DATE,
    situacao TEXT,
    tbl_aluno_id INT,
    tbl_disciplinas_id INT,
    CONSTRAINT fk_historico_aluno FOREIGN KEY (tbl_aluno_id) REFERENCES tbl_aluno(id),
    CONSTRAINT fk_historico_disciplina FOREIGN KEY (tbl_disciplinas_id) REFERENCES tbl_disciplina(id)
);

CREATE TABLE tbl_frequencia (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    porcentagem_presenca FLOAT,
    tbl_aluno_id INT,
    tbl_disciplinas_id INT,
    CONSTRAINT fk_frequencia_aluno FOREIGN KEY (tbl_aluno_id) REFERENCES tbl_aluno(id),
    CONSTRAINT fk_frequencia_disciplina FOREIGN KEY (tbl_disciplinas_id) REFERENCES tbl_disciplina(id)
);

CREATE TABLE tbl_nota (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nota_1 FLOAT,
    nota_2 FLOAT,
    media_final_aluno FLOAT,
    tbl_aluno_id INT,
    tbl_turma_id INT,
    tbl_disciplinas_id INT,
    CONSTRAINT fk_nota_aluno FOREIGN KEY (tbl_aluno_id) REFERENCES tbl_aluno(id),
    CONSTRAINT fk_nota_turma FOREIGN KEY (tbl_turma_id) REFERENCES tbl_turma(id),
    CONSTRAINT fk_nota_disciplina FOREIGN KEY (tbl_disciplinas_id) REFERENCES tbl_disciplina(id)
);

# dados ficticios criados para preencher informacoes no banco de dados
# INSERT de cursos - deve ser o primeiro,pois outras tabelas dependem desses dados primeiro.
INSERT INTO tbl_curso (curso, duracao_semestre, carga_horaria_total, coordenador_nome) VALUES
('Engenharia de Software', '8', '3200h', 'Carlos Souza'),
('Administração', '6', '2400h', 'Maria Lima'),
('Ciência da Computação', '8', '3200h', 'João Pereira');

# INSERT de alunos - depende dos dados tbl_curso 
INSERT INTO tbl_aluno (cpf, nome, matricula, data_nascimento, tbl_curso_id) VALUES
('123.456.789-00', 'João Silva', 202301, '2000-05-15', 1),
('987.654.321-00', 'Maria Oliveira', 202302, '1998-08-21', 2),
('456.789.123-00', 'Ana Souza', 202303, '2001-02-28', 1),
('321.654.987-00', 'Pedro Santos', 202304, '1995-09-10', 3),
('654.321.987-00', 'Mariana Lima', 202305, '1993-07-15', 2);

# INSERT de e-mails - depende dos dados tbl_aluno
INSERT INTO tbl_email (email, tbl_aluno_id) VALUES
('joao.silva@email.com', 1),
('maria.oliveira@email.com', 2),
('ana.souza@email.com', 3),
('pedro.santos@email.com', 4),
('mariana.lima@email.com', 5);

# INSERT de cursos relacionados - depende dos dados tbl_curso
INSERT INTO tbl_cursos_relacionados (cursos_relacionados, tbl_curso_id) VALUES
('Sistemas de Informação', 1),
('Gestão Empresarial', 2),
('Inteligência Artificial', 3);

# INSERT de disciplinas
INSERT INTO tbl_disciplina (nome, carga_horaria) VALUES
('Algoritmos e Estruturas de Dados', 60),
('Cálculo I', 75),
('Administração Financeira', 60),
('Sociologia', 45),
('Programação Orientada a Objetos', 60);

# INSERT de professores
INSERT INTO tbl_professor (cpf, nome, titulacao, carga_horaria_total) VALUES
('111.222.333-44', 'Carlos Pereira', 'Mestre', '40'),
('555.666.777-88', 'Fernanda Costa', 'Doutora', '30'),
('888.999.000-11', 'Roberto Almeida', 'Doutor', '35'),
('333.444.555-66', 'Patrícia Souza', 'Mestre', '40'),
('777.888.999-00', 'Luís Oliveira', 'Doutor', '30');

# INSERT de turmas - depende dos dados tbl_curso
INSERT INTO tbl_turma (sala, turno, limites_alunos, semestre, tbl_curso_id) VALUES
('A101', 'Manhã', 40, '2025/1', 1),
('B202', 'Noite', 35, '2025/1', 2),
('C303', 'Tarde', 30, '2025/2', 3);

# INSERT de horários - depende dos dados tbl_turma
INSERT INTO tbl_horario (turno, sala, dia_semana, horario_inicio, horario_fim, tbl_turma_id) VALUES
('Manhã', 'A101', 'Segunda', '08:00', '12:00', 1),
('Noite', 'B202', 'Terça', '18:00', '22:00', 2),
('Tarde', 'C303', 'Quarta', '14:00', '18:00', 3);

# INSERT de disciplinas ministradas - depende dos dados tbl_disciplina e tbl_professor, tbl_turma
INSERT INTO tbl_disciplinas_ministradas (disciplinas_ministradas, tbl_disciplinas_id, tbl_professor_id, tbl_turma_id) VALUES
('Algoritmos e Estruturas de Dados', 1, 1, 1),
('Cálculo I', 2, 2, 1),
('Administração Financeira', 3, 3, 2),
('Sociologia', 4, 4, 2),
('Programação Orientada a Objetos', 5, 5, 3);

# INSERT de histórico - depende dos dados tbl_aluno e tbl_disciplina
INSERT INTO tbl_historico (ano, situacao, tbl_aluno_id, tbl_disciplinas_id) VALUES
('2025-01-01', 'Aprovado', 1, 1),
('2025-01-01', 'Aprovado', 2, 2),
('2025-01-01', 'Reprovado', 3, 3),
('2025-01-01', 'Aprovado', 4, 4),
('2025-01-01', 'Aprovado', 5, 5);

# INSERT de frequência - depende dos dados tbl_aluno e tbl_disciplina
INSERT INTO tbl_frequencia (porcentagem_presenca, tbl_aluno_id, tbl_disciplinas_id) VALUES
(92.5, 1, 1),
(85.0, 2, 2),
(60.0, 3, 3),
(95.0, 4, 4),
(88.0, 5, 5);

# INSERT de notas - depende dos dados tbl_aluno,tbl_turma e tbl_disciplina
INSERT INTO tbl_nota (nota_1, nota_2, media_final_aluno, tbl_aluno_id, tbl_turma_id, tbl_disciplinas_id) VALUES
(8.0, 9.0, 8.5, 1, 1, 1),
(7.5, 8.5, 8.0, 2, 1, 2),
(5.0, 4.0, 4.5, 3, 2, 3),
(9.0, 8.0, 8.5, 4, 2, 4),
(7.0, 7.5, 7.25, 5, 3, 5);






