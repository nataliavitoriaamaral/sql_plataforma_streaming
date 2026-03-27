CREATE DATABASE BrenoNakamura;
USE BrenoNakamura;




-- Tabelas independentes:


CREATE TABLE PLANO (
   id_plano INT,
   nome VARCHAR(50) NOT NULL,
   valor DECIMAL(10,2) NOT NULL,
   resolucao_maxima VARCHAR(20),
   qtd_telas_simultaneas INT NOT NULL,
   PRIMARY KEY (id_plano)
);


CREATE TABLE CONTEUDO (
   id_conteudo INT,
   titulo_conteudo VARCHAR(150) NOT NULL,
   sinopse_conteudo TEXT,
   ano_lancamento INT,
   classificacao_indicativa VARCHAR(10),
   imagem_conteudo VARCHAR(255),
   PRIMARY KEY (id_conteudo)
);


CREATE TABLE IDIOMA (
   id_idioma INT,
   nome_idioma VARCHAR(50) NOT NULL,
   PRIMARY KEY (id_idioma)
);


CREATE TABLE LEGENDA (
   id_legenda INT,
   nome_legenda VARCHAR(50) NOT NULL,
   sigla_legenda VARCHAR(5),
   PRIMARY KEY (id_legenda)
);


CREATE TABLE CATEGORIA (
   id_categoria INT,
   nome_categoria VARCHAR(50) NOT NULL,
   PRIMARY KEY (id_categoria)
);


CREATE TABLE PALAVRACHAVE (
   id_palavra_chave INT,
   termo VARCHAR(50) NOT NULL,
   PRIMARY KEY (id_palavra_chave)
);


CREATE TABLE ARTISTA (
   id_artista INT,
   nome_artista VARCHAR(100) NOT NULL,
   foto_artista VARCHAR(255),
   PRIMARY KEY (id_artista)
);


CREATE TABLE DIRETOR (
   id_diretor INT,
   nome_diretor VARCHAR(100) NOT NULL,
   foto_diretor VARCHAR(255),
   PRIMARY KEY (id_diretor)
);




-- Tabelas dependentes:


-- tabelas de pagamento e perfil sao dependentes de usuario


CREATE TABLE USUARIO (
   id_usuario INT,
   id_plano INT NOT NULL,
   nome_completo VARCHAR(150) NOT NULL,
   email VARCHAR(100) NOT NULL,
   senha VARCHAR(255) NOT NULL,
   cpf VARCHAR(14) NOT NULL,
   data_cadastro DATE,
   PRIMARY KEY (id_usuario),
   FOREIGN KEY (id_plano) REFERENCES PLANO(id_plano)
);


CREATE TABLE PAGAMENTO (
   id_pagamento INT,
   id_usuario INT NOT NULL,
   data_pagamento DATE NOT NULL,
   valor_pago DECIMAL(10,2) NOT NULL,
   metodo_pagamento VARCHAR(50) NOT NULL,
   status VARCHAR(20),
   PRIMARY KEY (id_pagamento),
   FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);


CREATE TABLE PERFIL (
   id_perfil INT,
   id_usuario INT NOT NULL,
   nome_perfil VARCHAR(50) NOT NULL,
   classificacao_conteudo VARCHAR(10),
   avatar VARCHAR(255),
   PRIMARY KEY (id_perfil),
   FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);




-- especializacoes de conteudo 
CREATE TABLE FILME (
   id_conteudo_filme INT,
   duracao_filme INT NOT NULL,
   link_filme VARCHAR(255),
   PRIMARY KEY (id_conteudo_filme),
   FOREIGN KEY (id_conteudo_filme) REFERENCES CONTEUDO(id_conteudo)
);


CREATE TABLE SERIE (
   id_conteudo_serie INT,
   PRIMARY KEY (id_conteudo_serie),
   FOREIGN KEY (id_conteudo_serie) REFERENCES CONTEUDO(id_conteudo)
);




-- estrutura de series (episodios e temporadas)


CREATE TABLE TEMPORADA (
   id_temporada INT,
   id_conteudo_serie INT NOT NULL,
   numero_temporada INT NOT NULL,
   ano_exibicao INT,
   PRIMARY KEY (id_temporada),
   FOREIGN KEY (id_conteudo_serie) REFERENCES SERIE(id_conteudo_serie)
);


CREATE TABLE EPISODIO (
   id_episodio INT,
   id_temporada INT NOT NULL,
   numero_episodio INT NOT NULL,
   titulo_episodio VARCHAR(150) NOT NULL,
   sinopse_episodio TEXT,
   duracao_episodio INT NOT NULL,
   link_episodio VARCHAR(255),
   imagem_episodio VARCHAR(255),
   PRIMARY KEY (id_episodio),
   FOREIGN KEY (id_temporada) REFERENCES TEMPORADA(id_temporada)
);




-- interacoes do usuario e historico 

CREATE TABLE MINHALISTA (
   id_perfil INT NOT NULL,
   id_conteudo INT NOT NULL,
   data_adicao DATETIME,
   PRIMARY KEY (id_perfil, id_conteudo),
   FOREIGN KEY (id_perfil) REFERENCES PERFIL(id_perfil),
   FOREIGN KEY (id_conteudo) REFERENCES CONTEUDO(id_conteudo)
);


CREATE TABLE AVALIACAO (
   id_perfil INT NOT NULL,
   id_conteudo INT NOT NULL,
   nota INT NOT NULL,
   comentario TEXT,
   data_avaliacao DATETIME,
   PRIMARY KEY (id_perfil, id_conteudo),
   FOREIGN KEY (id_perfil) REFERENCES PERFIL(id_perfil),
   FOREIGN KEY (id_conteudo) REFERENCES CONTEUDO(id_conteudo)
);


CREATE TABLE HISTORICOFILME (
   id_perfil INT NOT NULL,
   id_conteudo_filme INT NOT NULL,
   data DATETIME NOT NULL,
   tempo_parada TIME,
   PRIMARY KEY (id_perfil, id_conteudo_filme, data),
   FOREIGN KEY (id_perfil) REFERENCES PERFIL(id_perfil),
   FOREIGN KEY (id_conteudo_filme) REFERENCES FILME(id_conteudo_filme)
);


CREATE TABLE HISTORICOEPISODIO (
   id_perfil INT NOT NULL,
   id_episodio INT NOT NULL,
   data DATETIME NOT NULL,
   tempo_parada TIME,
   PRIMARY KEY (id_perfil, id_episodio, data),
   FOREIGN KEY (id_perfil) REFERENCES PERFIL(id_perfil),
   FOREIGN KEY (id_episodio) REFERENCES EPISODIO(id_episodio)
);




-- audios e legendas
CREATE TABLE DISPONIBILIZA_AUDIO_FILME (
   id_idioma INT NOT NULL,
   id_conteudo_filme INT NOT NULL,
   PRIMARY KEY (id_idioma, id_conteudo_filme),
   FOREIGN KEY (id_idioma) REFERENCES IDIOMA(id_idioma),
   FOREIGN KEY (id_conteudo_filme) REFERENCES FILME(id_conteudo_filme)
);


CREATE TABLE DISPONIBILIZA_LEGENDA_FILME (
   id_legenda INT NOT NULL,
   id_conteudo_filme INT NOT NULL,
   PRIMARY KEY (id_legenda, id_conteudo_filme),
   FOREIGN KEY (id_legenda) REFERENCES LEGENDA(id_legenda),
   FOREIGN KEY (id_conteudo_filme) REFERENCES FILME(id_conteudo_filme)
);


CREATE TABLE DISPONIBILIZA_AUDIO_EPISODIO (
   id_idioma INT NOT NULL,
   id_episodio INT NOT NULL,
   PRIMARY KEY (id_idioma, id_episodio),
   FOREIGN KEY (id_idioma) REFERENCES IDIOMA(id_idioma),
   FOREIGN KEY (id_episodio) REFERENCES EPISODIO(id_episodio)
);


CREATE TABLE DISPONIBILIZA_LEGENDA_EPISODIO (
   id_legenda INT NOT NULL,
   id_episodio INT NOT NULL,
   PRIMARY KEY (id_legenda, id_episodio),
   FOREIGN KEY (id_legenda) REFERENCES LEGENDA(id_legenda),
   FOREIGN KEY (id_episodio) REFERENCES EPISODIO(id_episodio)
);




-- diretores, categorias, palavras-chave, artistas (relacionados com conteudo)


CREATE TABLE DIRIGIDO_POR (
   id_diretor INT NOT NULL,
   id_conteudo INT NOT NULL,
   PRIMARY KEY (id_diretor, id_conteudo),
   FOREIGN KEY (id_diretor) REFERENCES DIRETOR(id_diretor),
   FOREIGN KEY (id_conteudo) REFERENCES CONTEUDO(id_conteudo)
);


CREATE TABLE CLASSIFICADO_EM (
   id_categoria INT NOT NULL,
   id_conteudo INT NOT NULL,
   PRIMARY KEY (id_categoria, id_conteudo),
   FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria),
   FOREIGN KEY (id_conteudo) REFERENCES CONTEUDO(id_conteudo)
);


CREATE TABLE INDEXADO_POR (
   id_palavra_chave INT NOT NULL,
   id_conteudo INT NOT NULL,
   PRIMARY KEY (id_palavra_chave, id_conteudo),
   FOREIGN KEY (id_palavra_chave) REFERENCES PALAVRACHAVE(id_palavra_chave),
   FOREIGN KEY (id_conteudo) REFERENCES CONTEUDO(id_conteudo)
);


CREATE TABLE ESTRELADO_POR (
   id_artista INT NOT NULL,
   id_conteudo INT NOT NULL,
   PRIMARY KEY (id_artista, id_conteudo),
   FOREIGN KEY (id_artista) REFERENCES ARTISTA(id_artista),
   FOREIGN KEY (id_conteudo) REFERENCES CONTEUDO(id_conteudo)
);

-- insercao de artistas de epocas e generos de filmes variados

INSERT INTO ARTISTA (id_artista, nome_artista, foto_artista) VALUES
(1, 'Tom Cruise', '/img/artistas/tom_cruise.jpg'),
(2, 'Johnny Depp', '/img/artistas/johnny_depp.jpg'),
(3, 'Leonardo DiCaprio', '/img/artistas/leonardo_dicaprio.jpg'),
(4, 'Brad Pitt', '/img/artistas/brad_pitt.jpg'),
(5, 'Patrick Swayze', '/img/artistas/patrick_swayze.jpg'),
(6, 'Tom Hanks', '/img/artistas/tom_hanks.jpg'),
(7, 'Keanu Reeves', '/img/artistas/keanu_reeves.jpg'),
(8, 'Jennifer Aniston', '/img/artistas/jennifer_aniston.jpg'),
(9, 'Cameron Diaz', '/img/artistas/cameron_diaz.jpg'),
(10, 'Brooke Shields', '/img/artistas/brooke_shields.jpg'),
(11, 'Robert Downey Jr.', '/img/artistas/robert_downey_jr.jpg'),
(12, 'Tom Holland', '/img/artistas/tom_holland.jpg'),
(13, 'Zendaya', '/img/artistas/zendaya.jpg'),
(14, 'Henry Cavill', '/img/artistas/henry_cavill.jpg'),
(15, 'Anne Hathaway', '/img/artistas/anne_hathaway.jpg'),
(16, 'Richard Gere', '/img/artistas/richard_gere.jpg'),
(17, 'John Travolta', '/img/artistas/john_travolta.jpg'),
(18, 'Olivia Newton-John', '/img/artistas/olivia_newton_john.jpg'),
(19, 'Jim Carrey', '/img/artistas/jim_carrey.jpg'),
(20, 'Adam Sandler', '/img/artistas/adam_sandler.jpg'),
(21, 'Helena Bonham Carter', '/img/artistas/helena_bonham_carter.jpg'),
(22, 'Millie Bobby Brown', '/img/artistas/millie_bobby_brown.jpg'),
(23, 'Noah Schnapp', '/img/artistas/noah_schnapp.jpg'),
(24, 'Finn Wolfhard', '/img/artistas/finn_wolfhard.jpg'),
(25, 'Sean Connery', '/img/artistas/sean_connery.jpg'),
(26, 'Winona Ryder', '/img/artistas/winona_ryder.jpg'),
(27, 'Caleb McLaughlin', '/img/artistas/caleb_mclaughlin.jpg'),
(28, 'Sadie Sink', '/img/artistas/sadie_sink.jpg'),
(29, 'Gaten Matarazzo', '/img/artistas/gaten_matarazzo.jpg'),
(30, 'David Harbour', '/img/artistas/david_harbour.jpg'),
(31, 'Joe Keery', '/img/artistas/joe_keery.jpg'),
(32, 'Jamie Campbell Bower', '/img/artistas/jamie_campbell_bower.jpg'),
(33, 'Natalia Dyer', '/img/artistas/natalia_dyer.jpg'),
(34, 'Blake Lively', '/img/artistas/blake_lively.jpg'),
(35, 'Leighton Meester', '/img/artistas/leighton_meester.jpg'),
(36, 'Ed Westwick', '/img/artistas/ed_westwick.jpg'),
(37, 'Lindsay Lohan', '/img/artistas/lindsay_lohan.jpg'),
(38, 'Chace Crawford', '/img/artistas/chace_crawford.jpg'),
(39, 'Lauren Graham', '/img/artistas/lauren_graham.jpg'),
(40, 'Alexis Bledel', '/img/artistas/alexis_bledel.jpg'),
(41, 'Will Smith', '/img/artistas/will_smith.jpg'),
(42, 'Chad Michael Murray', '/img/artistas/chad_michael_murray.jpg'),
(43, 'Bryan Cranston', '/img/artistas/bryan_cranston.jpg'),
(44, 'Aaron Paul', '/img/artistas/aaron_paul.jpg'),
(45, 'Paul Walker', '/img/artistas/paul_walker.jpg'),
(46, 'Vin Diesel', '/img/artistas/vin_diesel.jpg'),
(47, 'Anna Gunn', '/img/artistas/anna_gunn.jpg'),
(48, 'Dean Norris', '/img/artistas/dean_norris.jpg'),
(49, 'Gal Gadot', '/img/artistas/gal_gadot.jpg'),
(50, 'Morgan Freeman', '/img/artistas/morgan_freeman.jpg'),
(51, 'Harrison Ford', '/img/artistas/harrison_ford.jpg'),
(52, 'Robert Pattinson', '/img/artistas/robert_pattinson.jpg'),
(53, 'Kristen Stewart', '/img/artistas/kristen_stewart.jpg'),
(54, 'Scarlett Johansson', '/img/artistas/scarlett_johansson.jpg'),
(55, 'Meryl Streep', '/img/artistas/meryl_streep.jpg'),
(56, 'Ariana Grande', '/img/artistas/ariana_grande.jpg'),
(57, 'Natalie Portman', '/img/artistas/natalie_portman.jpg'),
(58, 'Julia Roberts', '/img/artistas/julia_roberts.jpg'),
(59, 'Jennifer Lawrence', '/img/artistas/jennifer_lawrence.jpg'),
(60, 'Angelina Jolie', '/img/artistas/angelina_jolie.jpg'),
(61, 'Jonathan Bailey', '/img/artistas/jonathan_bailey.jpg'),
(62, 'Nicola Coughlan', '/img/artistas/nicola_coughlan.jpg'),
(63, 'Phoebe Dynevor', '/img/artistas/phoebe_dynevor.jpg'),
(64, 'Simone Ashley', '/img/artistas/simone_ashley.jpg'),
(65, 'Luke Newton', '/img/artistas/luke_newton.jpg'),
(66, 'Hyun Bin', '/img/artistas/hyun_bin.jpg'),
(67, 'Son Ye-jin', '/img/artistas/son_ye_jin.jpg'),
(68, 'Kim Soo-hyun', '/img/artistas/kim_soo_hyun.jpg'),
(69, 'Seo Ji-hye', '/img/artistas/seo_ji_hye.jpg'),
(70, 'Kim Jung-hyun', '/img/artistas/kim_jung_hyun.jpg'),
(71, 'Yang Kyung-won', '/img/artistas/yang_kyung_won.jpg'),
(72, 'Adam Driver', '/img/artistas/adam_driver.jpg'),
(73, 'Lily Collins', '/img/artistas/lily_collins.jpg'),
(74, 'Uma Thurman', '/img/artistas/uma_thurman.jpg'),
(75, 'Ryan Gosling', '/img/artistas/ryan_gosling.jpg'),
(76, 'Rachel McAdams', '/img/artistas/rachel_mcadams.jpg'),
(77, 'Miles Teller', '/img/artistas/miles_teller.jpg'),
(78, 'Glen Powell', '/img/artistas/glen_powell.jpg'),
(79, 'Demi Moore', '/img/artistas/demi_moore.jpg'),
(80, 'Whoopi Goldberg', '/img/artistas/whoopi_goldberg.jpg'),
(81, 'Madelyn Cline', '/img/artistas/madelyn_cline.jpg'),
(82, 'Rudy Pankow', '/img/artistas/rudy_pankow.jpg'),
(83, 'Chase Stokes', '/img/artistas/chase_stokes.jpg'),
(84, 'Madison Bailey', '/img/artistas/madison_bailey.jpg'),
(85, 'Arnold Schwarzenegger', '/img/artistas/arnold_schwarzenegger.jpg'),
(86, 'Sylvester Stallone', '/img/artistas/sylvester_stallone.jpg'),
(87, 'Drew Starkey', '/img/artistas/drew_starkey.jpg'),
(88, 'George Clooney', '/img/artistas/george_clooney.jpg'),
(89, 'Macaulay Culkin', '/img/artistas/macaulay_culkin.jpg'),
(90, 'Al Pacino', '/img/artistas/al_pacino.jpg'),
(91, 'Sam Claflin', '/img/artistas/sam_claflin.jpg'),
(92, 'Louis Partridge', '/img/artistas/louis_partridge.jpg'),
(93, 'Timothée Chalamet', '/img/artistas/timothee_chalamet.jpg'),
(94, 'Thomas Brodie-Sangster', '/img/artistas/thomas_brodie_sangster.jpg'),
(95, 'Dylan O''Brien', '/img/artistas/dylan_obrien.jpg');


-- inserindo os dados gerais na tabela conteudo 

INSERT INTO CONTEUDO (id_conteudo, titulo_conteudo, sinopse_conteudo, ano_lancamento, classificacao_indicativa, imagem_conteudo) VALUES
(1, 'Maze Runner: Correr ou Morrer', 'Em um futuro pós-apocalíptico, o jovem Thomas é transportado para uma comunidade de garotos isolada em um labirinto gigante.', 2014, '14 anos', '/img/posters/maze_runner.jpg'),
(2, 'Titanic', 'Uma aristocrata de dezessete anos se apaixona por um artista pobre a bordo do luxuoso e infortunado R.M.S. Titanic.', 1997, '12 anos', '/img/posters/titanic.jpg'),
(3, 'Top Gun: Ases Indomáveis', 'O estudante da escola naval de elite da Marinha compete para ser o melhor da classe e aprende lições de vida e amor.', 1986, '12 anos', '/img/posters/top_gun.jpg'),
(4, 'A Lagoa Azul', 'Duas crianças naufragadas em uma ilha tropical devem sobreviver e descobrir o amor enquanto crescem isoladas da civilização.', 1980, '14 anos', '/img/posters/lagoa_azul.jpg'),
(5, 'Embalos de Sábado à Noite', 'Um jovem do Brooklyn sente que sua única chance de sucesso é como o rei da pista de dança da discoteca local.', 1977, '16 anos', '/img/posters/embalos_sabado.jpg'),
(6, 'Ghost: Do Outro Lado da Vida', 'Após ser assassinado, o espírito de um homem tenta proteger sua amada com a ajuda de uma médium relutante.', 1990, '12 anos', '/img/posters/ghost.jpg'),
(7, 'Diário de uma Paixão', 'Um homem pobre e apaixonado se apaixona por uma jovem rica, dando-lhe uma sensação de liberdade, mas eles são separados por suas diferenças sociais.', 2004, '14 anos', '/img/posters/diario_paixao.jpg'),
(8, 'Alice no País das Maravilhas', 'Alice retorna ao mundo mágico de sua infância para se reunir com seus velhos amigos e acabar com o reinado de terror da Rainha Vermelha.', 2010, '10 anos', '/img/posters/alice_2010.jpg'),
(9, 'Dirty Dancing: Ritmo Quente', 'Passando o verão em um resort, uma jovem se apaixona pelo instrutor de dança do local.', 1987, '12 anos', '/img/posters/dirty_dancing.jpg'),
(10, 'Enola Holmes', 'Enquanto procura por sua mãe desaparecida, a adolescente Enola Holmes usa suas habilidades de detetive para despistar seu irmão Sherlock.', 2020, '12 anos', '/img/posters/enola_holmes.jpg'),
(11, 'O Diabo Veste Prada', 'Uma jovem recém-formada consegue um emprego como assistente de uma poderosa editora de revista de moda, onde sua sanidade é testada.', 2006, '10 anos', '/img/posters/diabo_veste_prada.jpg'),
(12, 'Esqueceram de Mim', 'Um garoto de oito anos deve proteger sua casa de dois ladrões quando é acidentalmente deixado para trás por sua família nas férias de Natal.', 1990, 'Livre', '/img/posters/esqueceram_mim.jpg'),
(13, 'Truque de Mestre', 'Um grupo de ilusionistas realiza assaltos a bancos durante suas apresentações e recompensa o público com o dinheiro.', 2013, '12 anos', '/img/posters/truque_mestre.jpg'),
(14, 'Wicked', 'A história não contada das bruxas de Oz, focando na improvável amizade entre Elphaba e Glinda.', 2024, '10 anos', '/img/posters/wicked.jpg'),
(15, 'Uma Linda Mulher', 'Um rico empresário contrata uma prostituta de Hollywood para ser sua acompanhante em eventos sociais, mas acaba se apaixonando.', 1990, '14 anos', '/img/posters/uma_linda_mulher.jpg'),
(16, 'Onze Homens e um Segredo', 'Danny Ocean e seus dez cúmplices planejam roubar três cassinos de Las Vegas simultaneamente.', 2001, '12 anos', '/img/posters/onze_homens.jpg'),
(17, 'Vingadores: Ultimato', 'Após os eventos devastadores de Guerra Infinita, os Vingadores se reúnem mais uma vez para reverter as ações de Thanos.', 2019, '12 anos', '/img/posters/vingadores_ultimato.jpg'),
(18, 'Crepúsculo', 'Uma adolescente se muda para uma nova cidade e se apaixona por um misterioso colega de classe que revela ser um vampiro.', 2008, '12 anos', '/img/posters/crepusculo.jpg'),
(19, 'Todo Poderoso', 'Um repórter de TV reclama de Deus com tanta frequência que recebe poderes divinos para ver se consegue fazer um trabalho melhor.', 2003, '12 anos', '/img/posters/todo_poderoso.jpg'),
(20, 'Velozes e Furiosos', 'Um policial se infiltra no mundo das corridas de rua de Los Angeles para investigar uma série de roubos.', 2001, '14 anos', '/img/posters/velozes_furiosos.jpg'),
(21, 'Operação Cupido', 'Gêmeas idênticas separadas no nascimento se reencontram em um acampamento e trocam de lugar para reunir seus pais.', 1998, 'Livre', '/img/posters/operacao_cupido.jpg'),
(22, 'Esposa de Mentirinha', 'Um cirurgião plástico convence sua leal assistente a fingir ser sua futura ex-esposa para encobrir uma mentira contada a uma nova namorada.', 2011, '12 anos', '/img/posters/esposa_mentirinha.jpg'),
(23, 'Grease: Nos Tempos da Brilhantina', 'Bons garotos e rebeldes vivem amores e aventuras no ensino médio na década de 1950.', 1978, '12 anos', '/img/posters/grease.jpg'),
(24, 'O Diário da Princesa', 'Uma adolescente comum descobre que é herdeira do trono de um pequeno país europeu.', 2001, 'Livre', '/img/posters/diario_princesa.jpg'),
(25, 'Homem-Aranha: De Volta ao Lar', 'Peter Parker tenta equilibrar sua vida como um estudante comum do ensino médio com sua identidade de super-herói.', 2017, '12 anos', '/img/posters/homem_aranha_homecoming.jpg'),
(26, 'O Amor Não Tira Férias', 'Duas mulheres com problemas amorosos trocam de casa nas férias de Natal, onde cada uma encontra um romance local.', 2006, '10 anos', '/img/posters/amor_nao_tira_ferias.jpg'),
(27, 'Sr. e Sra. Smith', 'Um casal entediado descobre que ambos são assassinos secretos trabalhando para agências rivais.', 2005, '14 anos', '/img/posters/sr_sra_smith.jpg');

-- inserindo os detalhes técnicos na tabela de filmes com o id correspondente 
INSERT INTO FILME (id_conteudo_filme, duracao_filme, link_filme) VALUES
(1, 113, 'https://streaming.com/watch/mazerunner'),
(2, 194, 'https://streaming.com/watch/titanic'),
(3, 110, 'https://streaming.com/watch/topgun'),
(4, 104, 'https://streaming.com/watch/lagoaazul'),
(5, 118, 'https://streaming.com/watch/embalos'),
(6, 127, 'https://streaming.com/watch/ghost'),
(7, 123, 'https://streaming.com/watch/diariopaixao'),
(8, 108, 'https://streaming.com/watch/alice'),
(9, 100, 'https://streaming.com/watch/dirtydancing'),
(10, 123, 'https://streaming.com/watch/enola'),
(11, 109, 'https://streaming.com/watch/diaboveste'),
(12, 103, 'https://streaming.com/watch/homealone'),
(13, 115, 'https://streaming.com/watch/truquemestre'),
(14, 160, 'https://streaming.com/watch/wicked'),
(15, 119, 'https://streaming.com/watch/lindamulher'),
(16, 116, 'https://streaming.com/watch/oceans11'),
(17, 181, 'https://streaming.com/watch/endgame'),
(18, 122, 'https://streaming.com/watch/crepusculo'),
(19, 101, 'https://streaming.com/watch/todopoderoso'),
(20, 106, 'https://streaming.com/watch/fastfurious'),
(21, 128, 'https://streaming.com/watch/parenttrap'),
(22, 117, 'https://streaming.com/watch/justgowithit'),
(23, 110, 'https://streaming.com/watch/grease'),
(24, 115, 'https://streaming.com/watch/diarioprincesa'),
(25, 133, 'https://streaming.com/watch/spiderman'),
(26, 136, 'https://streaming.com/watch/holiday'),
(27, 120, 'https://streaming.com/watch/mrsmith');

-- inserindo dados de series na tabela conteudo 
INSERT INTO CONTEUDO (id_conteudo, titulo_conteudo, sinopse_conteudo, ano_lancamento, classificacao_indicativa, imagem_conteudo) values
(28, 'Stranger Things', 'Quando um garoto desaparece, a cidade toda participa nas buscas. Mas o que encontram são segredos, forças sobrenaturais e uma menina.', 2016, '16 anos', '/img/posters/stranger_things.jpg'),
(29, 'Bridgerton', 'Os oito irmãos da unida família Bridgerton buscam amor e felicidade na alta sociedade de Londres.', 2020, '16 anos', '/img/posters/bridgerton.jpg'),
(30, 'Um Maluco no Pedaço', 'A vida de um rico banqueiro de Los Angeles vira de cabeça para baixo quando um parente malandro da Filadélfia vai morar com sua família.', 1990, 'Livre', '/img/posters/fresh_prince.jpg'),
(31, 'Gilmore Girls', 'Uma mãe solteira independente e sua filha talentosa mantêm uma relação de melhores amigas na pequena cidade de Stars Hollow.', 2000, '10 anos', '/img/posters/gilmore_girls.jpg'),
(32, 'Breaking Bad', 'Ao saber que tem câncer, um professor de química decide fabricar metanfetamina para pagar as dívidas e dar uma boa vida à família.', 2008, '16 anos', '/img/posters/breaking_bad.jpg'),
(33, 'The Vampire Diaries', 'A vida de Elena Gilbert muda completamente quando ela conhece dois irmãos vampiros que disputam sua alma e seu coração.', 2009, '14 anos', '/img/posters/vampire_diaries.jpg'),
(34, 'Pousando no Amor', 'Um acidente de parapente leva uma herdeira sul-coreana à Coreia do Norte. Lá, ela acaba conhecendo um oficial do exército que vai ajudá-la a se esconder.', 2019, '12 anos', '/img/posters/crash_landing.jpg'),
(35, 'Once Upon a Time', 'Uma jovem mulher com um passado conturbado é atraída para uma pequena cidade no Maine, onde a magia e o mistério dos contos de fadas podem ser reais.', 2011, '10 anos', '/img/posters/once_upon_a_time.jpg'),
(36, 'Daisy Jones & The Six', 'Em 1977, o grupo Daisy Jones & The Six estava no topo das paradas mundiais. A série detalha a ascensão e queda da renomada banda de rock.', 2023, '16 anos', '/img/posters/daisy_jones.jpg'),
(37, 'O Gambito da Rainha', 'Em um orfanato nos anos 50, uma garota prodigiosa do xadrez luta contra o vício enquanto enfrenta os grandes mestres do esporte.', 2020, '16 anos', '/img/posters/queens_gambit.jpg'),
(38, 'Shadowhunters', 'A vida de Clary Fray vira de cabeça para baixo quando ela descobre fazer parte de uma raça de humanos que caçam demônios e têm sangue de anjo.', 2016, '14 anos', '/img/posters/shadowhunters.jpg'),
(39, 'Dark', 'Quatro famílias iniciam uma desesperada busca por respostas quando uma criança desaparece e um complexo mistério envolvendo três gerações começa a se revelar.', 2017, '16 anos', '/img/posters/dark.jpg'),
(40, 'Supernatural', 'Os irmãos Dean e Sam vasculham o país em busca de atividades paranormais, brigando com demônios, fantasmas e monstros no caminho.', 2005, '14 anos', '/img/posters/supernatural.jpg'),
(41, 'Emily in Paris', 'Uma jovem executiva de marketing de Chicago é contratada para fornecer uma perspectiva americana em uma empresa de marketing em Paris.', 2020, '12 anos', '/img/posters/emily_in_paris.jpg'),
(42, 'Manual de Assassinato para Boas Garotas', 'Cinco anos após o assassinato de uma garota de 17 anos em uma cidade inglesa pacata, uma estudante decide descobrir a verdade e encontrar o verdadeiro assassino.', 2024, '14 anos', '/img/posters/agggtm.jpg'),
(43, 'The Good Doctor', 'Um jovem médico com autismo começa a trabalhar em um famoso hospital. Além dos desafios da profissão, ele precisa provar sua capacidade a seus colegas.', 2017, '12 anos', '/img/posters/good_doctor.jpg'),
(44, 'Anne with an E', 'Uma orfã destemida e com uma imaginação fértil acaba indo morar por engano com uma solteirona e seu irmão, transformando a vida deles.', 2017, '12 anos', '/img/posters/anne_with_an_e.jpg'),
(45, 'Gossip Girl', 'Um grupo de alunos de uma escola rica de Manhattan parece se safar de tudo, menos da blogueira anônima que acompanha cada passo deles.', 2007, '14 anos', '/img/posters/gossip_girl.jpg');

-- Inserindo os ids na tabela especializada serie
INSERT INTO SERIE (id_conteudo_serie) values
(28), (29), (30), (31), (32), (33), (34), (35), (36), 
(37), (38), (39), (40), (41), (42), (43), (44), (45);

-- inserindo mais filmes na tabela conteudo 
INSERT INTO CONTEUDO (id_conteudo, titulo_conteudo, sinopse_conteudo, ano_lancamento, classificacao_indicativa, imagem_conteudo) VALUES
(46, 'O Dublê', 'Um dublê maltratado retorna à ativa para trabalhar no filme de sua ex-namorada, apenas para se ver envolvido em uma conspiração criminosa.', 2024, '14 anos', '/img/posters/o_duble.jpg'),
(47, 'É Assim Que Acaba', 'Lily Bloom supera traumas do passado e inicia uma nova vida em Boston, mas seu relacionamento com um neurocirurgião desperta fantasmas antigos quando seu primeiro amor reaparece.', 2024, '14 anos', '/img/posters/assim_que_acaba.jpg'),
(48, 'Carros', 'A caminho da maior corrida de sua vida, o famoso Relâmpago McQueen se perde na pacata cidade de Radiator Springs e aprende que a vida é mais do que a linha de chegada.', 2006, 'Livre', '/img/posters/carros.jpg');

-- inserindo os detalhes tecnicos na tabela filme
INSERT INTO FILME (id_conteudo_filme, duracao_filme, link_filme) VALUES
(46, 126, 'https://streaming.com/watch/oduble'),
(47, 130, 'https://streaming.com/watch/assimqueacaba'),
(48, 117, 'https://streaming.com/watch/carros');

-- relaciona o artista com os conteudos nos quais atuou 
INSERT INTO ESTRELADO_POR (id_artista, id_conteudo) VALUES
-- FILMES
(95, 1), (94, 1), -- Maze Runner (Dylan O'Brien, Thomas Brodie-Sangster)
(3, 2), -- Titanic (Leonardo DiCaprio)
(1, 3), -- Top Gun (Tom Cruise)
(10, 4), -- A Lagoa Azul (Brooke Shields)
(17, 5), -- Embalos de Sábado a noite (John Travolta)
(5, 6), (79, 6), (80, 6), -- Ghost (Patrick Swayze, Demi Moore, Whoopi Goldberg)
(75, 7), (76, 7), -- Diário de uma Paixão (Ryan Gosling, Rachel McAdams)
(2, 8), (15, 8), (21, 8), -- Alice (Johnny Depp, Anne Hathaway, Helena Bonham Carter)
(5, 9), -- Dirty Dancing (Patrick Swayze)
(22, 10), (14, 10), (21, 10), (91, 10), (92, 10), -- Enola Holmes (Millie, Henry Cavill, Helena BC, Sam Claflin, Louis Partridge)
(55, 11), (15, 11), -- O Diabo Veste Prada (Meryl Streep, Anne Hathaway)
(89, 12), -- Esqueceram de Mim (Macaulay Culkin)
(50, 13), -- Truque de Mestre (Morgan Freeman)
(56, 14), (61, 14), -- Wicked (Ariana Grande, Jonathan Bailey)
(16, 15), (58, 15), -- Uma Linda Mulher (Richard Gere, Julia Roberts)
(88, 16), (4, 16), (58, 16), -- Onze Homens e um Segredo (George Clooney, Brad Pitt, Julia Roberts)
(11, 17), (54, 17), (12, 17), -- Vingadores: Ultimato (Robert Downey Jr., Scarlett Johansson, Tom Holland)
(52, 18), (53, 18), -- Crepúsculo (Robert Pattinson, Kristen Stewart)
(19, 19), (50, 19), (8, 19), -- Todo Poderoso (Jim Carrey, Morgan Freeman, Jennifer Aniston)
(46, 20), (45, 20), (49, 20), -- Velozes e Furiosos (Vin Diesel, Paul Walker, Gal Gadot)
(37, 21), -- Operação Cupido (Lindsay Lohan)
(20, 22), (8, 22), -- Esposa de Mentirinha (Adam Sandler, Jennifer Aniston)
(17, 23), (18, 23), -- Grease (John Travolta, Olivia Newton-John)
(15, 24), -- O Diário da Princesa (Anne Hathaway)
(12, 25), (13, 25), (11, 25), -- Homem-Aranha (Tom Holland, Zendaya, Robert Downey Jr.)
(9, 26), -- O Amor Não Tira Férias (Cameron Diaz)
(4, 27), (60, 27), -- Sr. e Sra. Smith (Brad Pitt, Angelina Jolie)
(75, 46), -- O Dublê (Ryan Gosling)
(34, 47), -- É Assim Que Acaba (Blake Lively)
-- SÉRIES
(26, 28), (30, 28), (22, 28), (23, 28), (24, 28), (27, 28), (28, 28), (29, 28), (31, 28), (32, 28), (33, 28), -- Stranger Things (elenco principal)
(61, 29), (62, 29), (63, 29), (64, 29), (65, 29), -- Bridgerton (elenco principal)
(41, 30), -- Um Maluco no Pedaço (Will Smith)
(39, 31), (40, 31), (42, 31), -- Gilmore Girls (Lauren Graham, Alexis Bledel, Chad Michael Murray)
(43, 32), (44, 32), (47, 32), (48, 32), -- Breaking Bad (Bryan Cranston, Aaron Paul, Anna Gunn, Dean Norris)
(66, 34), (67, 34), (69, 34), (70, 34), (71, 34), (68, 34), -- Pousando no Amor (Hyun Bin, Son Ye-jin, elenco de apoio e cameo do Kim Soo-hyun)
(32, 35), -- Once Upon a Time (Jamie Campbell Bower como Rei Arthur)
(91, 36), -- Daisy Jones & The Six (Sam Claflin)
(94, 37), -- O Gambito da Rainha (Thomas Brodie-Sangster)
(73, 41), -- Emily in Paris (Lily Collins)

INSERT INTO ESTRELADO_POR (id_artista, id_conteudo) VALUES
(34, 45), (35, 45), (36, 45), (38, 45); -- Gossip Girl (Blake Lively, Leighton Meester, Ed Westwick, Chace Crawford)

-- inserindo mais uma serie em conteudo 
INSERT INTO CONTEUDO (id_conteudo, titulo_conteudo, sinopse_conteudo, ano_lancamento, classificacao_indicativa, imagem_conteudo) VALUES
(49, 'Outer Banks', 'Um grupo de adolescentes "Pogues" está determinado a descobrir o que aconteceu com o pai desaparecido do líder do grupo, o que os leva a uma caça ao tesouro lendária.', 2020, '16 anos', '/img/posters/outer_banks.jpg');

-- inserindo na tabela serie 
INSERT INTO SERIE (id_conteudo_serie) VALUES (49);

INSERT INTO ESTRELADO_POR (id_artista, id_conteudo) VALUES
(81, 49), -- Madelyn Cline
(82, 49), -- Rudy Pankow
(83, 49), -- Chase Stokes
(84, 49), -- Madison Bailey
(87, 49); -- Drew Starkey

-- adicionando os dados gerais do filme top gun: maverick  (so continha o primeiro filme)
INSERT INTO CONTEUDO (id_conteudo, titulo_conteudo, sinopse_conteudo, ano_lancamento, classificacao_indicativa, imagem_conteudo) VALUES
(50, 'Top Gun: Maverick', 'Depois de mais de 30 anos de serviço, Pete Mitchell é chamado para treinar um grupo de graduados do Top Gun para uma missão especializada.', 2022, '12 anos', '/img/posters/top_gun_maverick.jpg');

-- adicionando os detalhes tecnicos 
INSERT INTO FILME (id_conteudo_filme, duracao_filme, link_filme) VALUES
(50, 130, 'https://streaming.com/watch/topgunmaverick');

INSERT INTO ESTRELADO_POR (id_artista, id_conteudo) VALUES
(77, 50), -- Miles Teller
(78, 50), -- Glen Powell
(1, 50);  -- Tom Cruise 

INSERT INTO CATEGORIA (id_categoria, nome_categoria) VALUES
(1, 'Ação'),
(2, 'Aventura'),
(3, 'Comédia'),
(4, 'Drama'),
(5, 'Ficção Científica'),
(6, 'Romance'),
(7, 'Terror'),
(8, 'Fantasia'),
(9, 'Suspense'),
(10, 'Animação'),
(11, 'Documentário'),
(12, 'K-Drama');

INSERT INTO IDIOMA (id_idioma, nome_idioma) VALUES
(1, 'Português (Brasil)'),
(2, 'Inglês (Original)'),
(3, 'Espanhol'),
(4, 'Francês'),
(5, 'Alemão'),
(6, 'Italiano'),
(7, 'Japonês'),
(8, 'Coreano'),
(9, 'Mandarim'),
(10, 'Russo');


INSERT INTO LEGENDA (id_legenda, nome_legenda, sigla_legenda) VALUES
(1, 'Português', 'PT-BR'),
(2, 'Inglês', 'EN-US'),
(3, 'Espanhol', 'ES'),
(4, 'Francês', 'FR'),
(5, 'Alemão', 'DE'),
(6, 'Italiano', 'IT'),
(7, 'Japonês', 'JA'),
(8, 'Coreano', 'KO'),
(9, 'Chinês', 'ZH'),
(10, 'Russo', 'RU');

INSERT INTO PLANO (id_plano, nome, valor, resolucao_maxima, qtd_telas_simultaneas) VALUES
(1, 'Básico com anúncios', 18.90, '720p', 1),
(2, 'Básico sem anúncios', 25.90, '720p', 1),
(3, 'Padrão mensal', 39.90, '1080p', 2),
(4, 'Premium 4K', 55.90, '4K+HDR', 4),
(5, 'Plano mobile', 14.90, '480p', 1),
(6, 'Plano universitário', 19.90, '1080p', 1),
(7, 'Plano família', 69.90, '4K+HDR', 6),
(8, 'Anual básico', 200.00, '720p', 1),
(9, 'Anual premium', 500.00, '4K+HDR', 4),
(10, 'VIP', 89.90, '8K', 4);

INSERT INTO PALAVRACHAVE (id_palavra_chave, termo) VALUES
(1, 'Anos 80'),
(2, 'Vampiros'),
(3, 'Adolescente'),
(4, 'Baseado em Livros'),
(5, 'Super-herói'),
(6, 'Clássico'),
(7, 'Família'),
(8, 'Suspense psicológico'),
(9, 'Baseado em fatos reais'),
(10, 'Premiado no Oscar'),
(11, 'Viagem no tempo'),
(12, 'Distopia');

INSERT INTO DIRETOR (id_diretor, nome_diretor, foto_diretor) VALUES
-- Diretores com mais de um filme na base de dados
(1, 'Randal Kleiser', '/img/diretores/randal_kleiser.jpg'), -- Lagoa Azul e Grease
(2, 'Garry Marshall', '/img/diretores/garry_marshall.jpg'), -- Uma Linda Mulher e Diário da Princesa
(3, 'Nancy Meyers', '/img/diretores/nancy_meyers.jpg');     --  Operação Cupido e O Amor Não Tira Férias

-- Diretores com um filme na base 
INSERT INTO DIRETOR (id_diretor, nome_diretor, foto_diretor) VALUES
(4, 'James Cameron', '/img/diretores/james_cameron.jpg'),   -- Titanic
(5, 'Tony Scott', '/img/diretores/tony_scott.jpg'),         -- Top Gun (1986)
(6, 'Joseph Kosinski', '/img/diretores/joseph_kosinski.jpg'),--  Top Gun: Maverick (2022)
(7, 'Tim Burton', '/img/diretores/tim_burton.jpg'),         -- Alice no País das Maravilhas
(8, 'Wes Ball', '/img/diretores/wes_ball.jpg'),             -- Maze Runner
(9, 'David Frankel', '/img/diretores/david_frankel.jpg'),   -- O Diabo Veste Prada
(10, 'Justin Baldoni', '/img/diretores/justin_baldoni.jpg'); -- É Assim Que Acaba

-- Diretores sem filmes cadastrados 
INSERT INTO DIRETOR (id_diretor, nome_diretor, foto_diretor) VALUES
(11, 'Quentin Tarantino', '/img/diretores/quentin_tarantino.jpg'),
(12, 'Christopher Nolan', '/img/diretores/christopher_nolan.jpg'),
(13, 'Greta Gerwig', '/img/diretores/greta_gerwig.jpg');

INSERT INTO DIRIGIDO_POR (id_diretor, id_conteudo) VALUES
(1, 4),  -- A Lagoa Azul
(1, 23), -- grease
(2, 15), -- Uma linda mulher
(2, 24), -- o diário da princesa
(3, 21), -- Operação Cupido
(3, 26), -- O Amor Não Tira Férias
(4, 2),  -- James Cameron
(5, 3),  -- Tony Scott 
(6, 50), -- Joseph Kosinski 
(7, 8),  -- Tim Burton 
(8, 1),  -- Wes Ball 
(9, 11), -- David Frankel 
(10, 47); -- Justin Baldoni 

INSERT INTO USUARIO (id_usuario, id_plano, nome_completo, email, senha, cpf, data_cadastro) VALUES
(1, 4, 'Alice Kingsleigh', 'alice.k@wonderland.com', 'coelho123', '123.456.789-00', '2024-01-10'),
(2, 2, 'Sarah Vitoria', 'sarah.vitoria@email.com', 'svitoria22', '234.567.890-11', '2024-02-15'),
(3, 3, 'Breno Nakamura', 'breno.nakamura@email.com', 'breno@db', '345.678.901-22', '2024-03-01'),
(4, 1, 'Natalia Amaral', 'nati.amaral@email.com', 'amaral#99', '456.789.012-33', '2024-01-20'),
(5, 2, 'Jaqueline Alves', 'jaque.alves@email.com', 'jaque1234', '567.890.123-44', '2024-04-12'),
(6, 4, 'Barbara Silva', 'babi.silva@email.com', 'bsilva2024', '678.901.234-55', '2024-05-05'),
(7, 3, 'Joao Nascimento', 'joao.nasc@email.com', 'jnasc_007', '789.012.345-66', '2024-02-28'),
(8, 1, 'Maya Heart', 'maya.heart@email.com', 'heartbeat', '890.123.456-77', '2024-06-10'),
(9, 2, 'Franciny Cameron', 'fran.cameron@email.com', 'camfran88', '901.234.567-88', '2024-03-15'),
(10, 4, 'Lucas Byers', 'lucas.byers@email.com', 'willzombie', '012.345.678-99', '2024-01-05');

INSERT INTO PERFIL (id_perfil, id_usuario, nome_perfil, classificacao_conteudo, avatar) VALUES
(1, 1, 'Alice', 'Livre', '/img/avatars/alice.png'),
(2, 2, 'Sarah', '14 anos', '/img/avatars/sarah.png'),
(3, 3, 'Breno', '18 anos', '/img/avatars/breno.png'),
(4, 4, 'Nati', '12 anos', '/img/avatars/natalia.png'),
(5, 5, 'Jaque', '16 anos', '/img/avatars/jaque.png'),
(6, 6, 'Babi', '18 anos', '/img/avatars/barbara.png'),
(7, 7, 'João', '18 anos', '/img/avatars/joao.png'),
(8, 8, 'Maya', '10 anos', '/img/avatars/maya.png'),
(9, 9, 'Fran', '14 anos', '/img/avatars/franciny.png'),
(10, 10, 'Lucas', '16 anos', '/img/avatars/lucas.png');

INSERT INTO PAGAMENTO (id_pagamento, id_usuario, data_pagamento, valor_pago, metodo_pagamento, status) VALUES
(1, 1, '2024-05-10', 55.90, 'Cartão Crédito', 'Aprovado'),
(2, 1, '2024-06-10', 55.90, 'Cartão Crédito', 'Aprovado'),
(3, 3, '2024-04-01', 39.90, 'Cartão Crédito', 'Aprovado'),
(4, 3, '2024-05-01', 39.90, 'Cartão Crédito', 'Aprovado'),
(5, 3, '2024-06-01', 39.90, 'Cartão Crédito', 'Aprovado'),
(6, 2, '2024-06-15', 25.90, 'PIX', 'Aprovado'), 
(7, 4, '2024-06-20', 18.90, 'Boleto', 'Pendente'), 
(8, 5, '2024-06-12', 25.90, 'Cartão Débito', 'Aprovado'),
(9, 6, '2024-06-05', 55.90, 'PayPal', 'Aprovado'),
(10, 7, '2024-06-28', 39.90, 'Cartão Crédito', 'Falha'), 
(11, 9, '2024-06-15', 25.90, 'Cartão Crédito', 'Aprovado'); 

INSERT INTO TEMPORADA (id_temporada, id_conteudo_serie, numero_temporada, ano_exibicao) VALUES
(1, 28, 1, 2016), -- Stranger things
(2, 28, 2, 2017), -- Stranger things
(3, 28, 3, 2019), -- Stranger Things
(4, 32, 1, 2008), -- Breaking Bad
(5, 32, 2, 2009), -- Breaking Bad
(6, 39, 1, 2017), -- Dark 
(7, 39, 2, 2019), -- Dark 
(8, 29, 1, 2020),  -- Bridgerton
(9, 30, 1, 1990),  -- Um Maluco no Pedaço
(10, 31, 1, 2000), -- Gilmore Girls
(11, 33, 1, 2009), -- Vampire Diaries
(12, 34, 1, 2019), -- Pousando no Amor
(13, 35, 1, 2011), -- Once Upon a Time
(14, 36, 1, 2023), -- Daisy Jones & The Six
(15, 37, 1, 2020), -- O Gambito da Rainha
(16, 38, 1, 2016), -- Shadowhunters
(17, 40, 1, 2005), -- Supernatural
(18, 41, 1, 2020), -- Emily in Paris
(19, 42, 1, 2024), -- Manual de Assassinato
(20, 43, 1, 2017), -- The Good Doctor
(21, 44, 1, 2017), -- Anne with an E
(22, 45, 1, 2007), -- Gossip Girl
(23, 49, 1, 2020); -- Outer Banks

INSERT INTO EPISODIO (id_episodio, id_temporada, numero_episodio, titulo_episodio, sinopse_episodio, duracao_episodio, link_episodio) VALUES
(1, 1, 1, 'Capítulo Um: O Desaparecimento', 'No caminho de volta para casa, Will vê algo aterrorizante. Perto dali, um laboratório guarda um segredo.', 48, 'http://st/s1e1'),
(2, 1, 2, 'Capítulo Dois: A Estranha', 'Lucas, Mike e Dustin tentam falar com a menina que encontraram na floresta.', 55, 'http://st/s1e2'),
(3, 1, 3, 'Capítulo Três: Caramba', 'Barb acorda em um mundo estranho e Nancy se preocupa com o desaparecimento dela.', 52, 'http://st/s1e3'),
(4, 2, 1, 'MADMAX', 'Enquanto a cidade se prepara para o Halloween, um rival sacode os recordes de Dustin no fliperama.', 48, 'http://st/s2e1'),
(5, 4, 1, 'Piloto', 'Um professor de química descobre que tem câncer e decide fabricar metanfetamina.', 58, 'http://bb/s1e1'),
(6, 4, 2, 'O Gato Está no Saco...', 'Walt e Jesse tentam se livrar de dois corpos que se tornaram um problema inconveniente.', 48, 'http://bb/s1e2'),
(7, 5, 1, 'Sete Trinta e Sete', 'Walt e Jesse percebem o quão volátil Tuco pode ser e tentam encontrar uma maneira de sair do negócio.', 47, 'http://bb/s2e1'),
(8, 6, 1, 'Segredos', 'O desaparecimento de um garoto evoca medo e mistérios em Winden.', 51, 'http://dark/s1e1'),
(9, 7, 1, 'Princípios e Fins', 'Seis meses depois, Jonas explora o futuro e tenta voltar para casa.', 54, 'http://dark/s2e1'),
(10, 8, 1, 'Diamante da Temporada', 'Daphne estreia na temporada social de Londres e conhece o duque.', 58, 'http://bridgerton/s1e1'),
(11, 9, 1, 'O Projeto Fresh Prince', 'Will chega em Bel-Air e choca seus tios ricos com seu estilo.', 23, 'http://fresh/s1e1'),
(12, 10, 1, 'Piloto', 'Lorelai pede dinheiro aos pais para a educação de Rory.', 44, 'http://gg/s1e1'),
(13, 11, 1, 'Piloto', 'Elena conhece Stefan no primeiro dia de aula e sente uma conexão imediata.', 42, 'http://tvd/s1e1'),
(14, 12, 1, 'Aterrissagem Forçada', 'Um tornado derruba o parapente de Se-ri na zona desmilitarizada.', 70, 'http://cloy/s1e1'),
(15, 13, 1, 'Piloto', 'Emma Swan é levada até Storybrooke, onde contos de fadas são reais.', 43, 'http://ouat/s1e1'),
(16, 14, 1, 'Venha Pegar', 'Daisy Jones e a banda The Six trilham caminhos separados até se encontrarem.', 48, 'http://daisy/s1e1'),
(17, 15, 1, 'Aberturas', 'Enviada para um orfanato, Beth descobre um talento impressionante para o xadrez.', 59, 'http://gambit/s1e1'),
(18, 16, 1, 'O Cálice Mortal', 'Clary descobre ser uma caçadora de sombras em seu aniversário de 18 anos.', 42, 'http://sh/s1e1'),
(19, 17, 1, 'Piloto', 'Sam e Dean Winchester se reúnem para encontrar o pai desaparecido.', 44, 'http://spn/s1e1'),
(20, 18, 1, 'Emily em Paris', 'Emily chega a Paris e enfrenta o choque cultural em seu novo emprego.', 30, 'http://emily/s1e1'),
(21, 19, 1, 'Episódio 1', 'Pip decide investigar um caso de assassinato encerrado para um projeto escolar.', 45, 'http://agggtm/s1e1'),
(22, 20, 1, 'Comida Queimada', 'Shaun Murphy salva a vida de um garoto no aeroporto a caminho de sua entrevista.', 41, 'http://tgd/s1e1'),
(23, 21, 1, 'Sua Vontade Decidirá', 'Anne chega a Green Gables e tenta conquistar os irmãos Cuthbert.', 47, 'http://anne/s1e1'),
(24, 22, 1, 'Piloto', 'Serena van der Woodsen retorna misteriosamente a Manhattan.', 42, 'http://gg/s1e1'),
(25, 23, 1, 'Piloto', 'Um grupo de adolescentes encontra um barco naufragado após um furacão.', 50, 'http://outerbanks/s1e1');

INSERT INTO MINHALISTA (id_perfil, id_conteudo, data_adicao) VALUES
(1, 8, '2024-01-12'),  -- Alice salvou Alice no País das Maravilhas
(1, 29, '2024-01-12'), -- Alice salvou Bridgerton
(1, 24, '2024-01-15'), -- Alice salvou Diário da Princesa
(3, 50, '2024-03-02'), -- Breno salvou Top Gun Maverick
(3, 20, '2024-03-02'), -- Breno salvou Velozes e Furiosos
(3, 32, '2024-03-05'), -- Breno salvou Breaking Bad
(4, 28, '2024-01-21'), -- Nati salvou Stranger Things
(4, 10, '2024-01-21'), -- Nati salvou Enola Holmes
(6, 41, '2024-05-06'), -- Babi salvou Emily in Paris
(7, 46, '2024-02-28'), -- João salvou O Dublê
(10, 39, '2024-01-06'), -- Lucas salvou Dark
(10, 28, '2024-01-06'); -- Lucas salvou Stranger Things

INSERT INTO AVALIACAO (id_perfil, id_conteudo, nota, comentario, data_avaliacao) VALUES
(1, 8, 5, 'Simplesmente mágico! Johnny Depp incrível.', '2024-01-13'),
(1, 29, 5, 'Amei os figurinos e a história.', '2024-01-20'),
(3, 50, 5, 'A melhor sequência de filme já feita. Ação pura.', '2024-03-05'),
(3, 22, 3, 'Engraçado, mas meio bobo.', '2024-03-10'),
(2, 18, 4, 'Nostalgia pura da minha adolescência.', '2024-02-16'),
(4, 44, 5, 'Chorei em todos os episódios. Perfeito.', '2024-01-25'),
(5, 48, 5, 'Relâmpago McQueen é o cara! Katchau!', '2024-04-13'),
(7, 11, 4, 'Meryl Streep carrega o filme nas costas.', '2024-03-01'),
(9, 41, 2, 'Muitos clichês sobre Paris, esperava mais.', '2024-03-16'),
(10, 28, 5, 'Roteiro impecável e trilha sonora anos 80 sensacional.', '2024-01-08'),
(1, 39, 1, 'Muito confuso, não entendi nada da viagem no tempo.', '2024-02-01'),
(6, 47, 5, 'Livro era melhor, mas o filme emociona.', '2024-08-15');

INSERT INTO HISTORICOFILME (id_perfil, id_conteudo_filme, data, tempo_parada) VALUES
(1, 8, '2024-01-13 12:00:00', '01:48:00'),  -- Alice viu Alice inteiro
(3, 50, '2024-03-04 20:00:00', '02:10:00'), -- Breno viu Top Gun Maverick inteiro
(3, 3, '2024-03-03 19:00:00', '01:50:00'),  -- Breno viu Top Gun 1 inteiro
(2, 2, '2024-02-15 21:00:00', '03:14:00'),  -- Sarah viu Titanic inteiro
(5, 48, '2024-04-13 08:00:00', '01:57:00'), -- Jaque viu Carros inteiro
(7, 12, '2024-02-28 14:00:00', '00:45:00'), -- João parou Esqueceram de Mim na metade
(9, 22, '2024-03-15 20:00:00', '00:10:00'), -- Fran viu 10min de Esposa de Mentirinha 
(10, 6, '2024-01-07 23:00:00', '02:07:00'), -- Lucas viu Ghost inteiro
(4, 10, '2024-01-22 15:00:00', '02:03:00'), -- Nati viu Enola Holmes inteiro
(6, 47, '2024-08-14 20:00:00', '02:10:00'), -- Babi viu É Assim Que Acaba inteiro
(1, 2, '2024-05-10 14:00:00', '01:00:00');  -- Alice reviu metade de Titanic meses depois

INSERT INTO HISTORICOEPISODIO (id_perfil, id_episodio, data, tempo_parada) VALUES
(10, 1, '2024-01-06 14:00:00', '00:48:00'),-- Lucas esta maratonando Stranger Things (ep 1, 2 e 3)
(10, 2, '2024-01-06 15:00:00', '00:55:00'),
(10, 3, '2024-01-06 16:00:00', '00:52:00'),
(1, 10, '2024-01-20 18:00:00', '00:58:00'), -- Alice viu o primeiro episodio de Bridgerton 
(3, 5, '2024-03-06 21:00:00', '00:58:00'), -- Breno esta vendo Breaking Bad (viu ep 1 e 2)
(3, 6, '2024-03-06 22:00:00', '00:48:00'),
(4, 12, '2024-01-21 10:00:00', '00:44:00'), -- Nati vendo Gilmore Girls
(2, 13, '2024-02-16 14:00:00', '00:42:00'), -- Sarah vendo Vampire Diaries
(9, 20, '2024-03-16 13:00:00', '00:30:00'),-- Fran vendo Emily in Paris 
(6, 21, '2024-05-07 20:00:00', '00:45:00'), -- Babi vendo Manual de Assassinato
(7, 11, '2024-02-28 12:00:00', '00:10:00');-- João parou Um Maluco no Pedaço no meio

INSERT INTO DISPONIBILIZA_AUDIO_FILME (id_idioma, id_conteudo_filme) VALUES
(1, 2), (2, 2), (3, 2), -- Titanic
(1, 3), (2, 3), (3, 3), -- Top Gun
(1, 17), (2, 17), (3, 17), -- Vingadores: Ultimato
(1, 50), (2, 50), (3, 50), -- Top Gun: Maverick
(1, 1), (2, 1), -- Maze Runner
(1, 4), (2, 4), -- Lagoa Azul
(1, 6), (2, 6), -- Ghost
(1, 8), (2, 8), -- Alice
(1, 10), (2, 10), -- Enola Holmes
(1, 12), (2, 12), -- Esqueceram de Mim
(1, 18), (2, 18), -- Crepúsculo
(1, 20), (2, 20), -- Velozes e Furiosos
(1, 25), (2, 25), -- Homem-Aranha
(1, 47), (2, 47), -- É Assim Que Acaba
(1, 48), (2, 48), -- Carros
(1, 5), (1, 7), (1, 9), (1, 11), (1, 13), (1, 14), (1, 15), 
(1, 16), (1, 19), (1, 21), (1, 22), (1, 23), (1, 24), (1, 26), (1, 27), (1, 46);


INSERT INTO DISPONIBILIZA_LEGENDA_FILME (id_legenda, id_conteudo_filme) VALUES
(1, 2), (2, 2), (3, 2), -- Titanic
(1, 17), (2, 17), (3, 17), -- Vingadores
(1, 1), (2, 1), -- Maze Runner
(1, 3), (2, 3), -- Top Gun
(1, 6), (2, 6), -- Ghost
(1, 50), (2, 50), -- Maverick
(1, 11), (2, 11), -- Diabo Veste Prada
(1, 18), (2, 18), -- Crepúsculo
(1, 4), (1, 5), (1, 7), (1, 8), (1, 9), (1, 10), (1, 12), (1, 13), 
(1, 14), (1, 15), (1, 16), (1, 19), (1, 20), (1, 21), (1, 22), 
(1, 23), (1, 24), (1, 25), (1, 26), (1, 27), (1, 46), (1, 47), (1, 48);



INSERT INTO DISPONIBILIZA_AUDIO_EPISODIO (id_idioma, id_episodio) VALUES
(2, 1), (1, 1), (2, 2), (1, 2), (2, 3), (1, 3), (2, 4), (1, 4),
(2, 5), (1, 5), (3, 5), (2, 6), (2, 7),
(5, 8), (2, 8), (5, 9), (2, 9),
(2, 10), (1, 10),
(1, 11),
(2, 13),
(8, 14), (1, 14),
(2, 12), (2, 15), (2, 16), (2, 17), (2, 18), (2, 19), (2, 20), 
(2, 21), (2, 22), (2, 23), (2, 24),
(2, 25);


INSERT INTO DISPONIBILIZA_LEGENDA_EPISODIO (id_legenda, id_episodio) VALUES
(1, 1), (2, 1), (1, 2), (1, 3), (1, 4),
(1, 5), (2, 5), (3, 5), (1, 6), (1, 7),
(1, 8), (2, 8), (1, 9),
(1, 10), (2, 10),
(1, 11),
(1, 14), (2, 14), (8, 14),
(1, 20), (4, 20),
(1, 12), (1, 13), (1, 15), (1, 16), (1, 17), (1, 18), 
(1, 19), (1, 21), (1, 22), (1, 23), (1, 24);

INSERT INTO CLASSIFICADO_EM (id_categoria, id_conteudo) VALUES
-- Ação (ID 1)
(1, 1),(1, 3),(1, 16),(1, 17),(1, 20),(1, 25),(1, 27),(1, 46),(1, 50), 
-- Aventura (ID 2)
(2, 4),(2, 10),(2, 21), 
-- Comédia (ID 3)
(3, 5),(3, 11),(3, 12), (3, 15), (3, 19),(3, 22),(3, 24),
-- Drama (ID 4)
(4, 2),(4, 7),(4, 47), 
-- Romance (ID 6)
(6, 6),(6, 9),(6, 18),(6, 23),(6, 26), 
-- Fantasia (ID 8)
(8, 8),(8, 14),
-- Suspense (ID 9)
(9, 13), 
-- Animação (ID 10)
(10, 48), 
-- series
-- Ficção científica (ID 5) / terror (ID 7)
(5, 28),(7, 28),(5, 39), 
-- Romance (ID 6)
(6, 29),(6, 34),(6, 36),(6, 41), 
-- Comédia 
(3, 30),(3, 31), 
-- Drama (ID 4)
(4, 32),(4, 37),(4, 43),(4, 44),(4, 45), 
-- Fantasia (ID 8)
(8, 33),(8, 35),(8, 38),(8, 40),
-- Suspense (ID 9)
(9, 42),
-- Aventura (ID 2)
(2, 49),
-- K-Drama (ID 12)
(12, 34);

INSERT INTO INDEXADO_POR (id_palavra_chave, id_conteudo) VALUES
-- Distopia (ID 12)
(12, 1), 
-- Premiado no Oscar (ID 10)
(10, 2),(10, 6),
-- Clássico (ID 6)
(6, 3),(6, 4),(6, 9),(6, 15),(6, 16),(6, 23),
-- Anos 80 (ID 1)
(1, 5),(1, 50), 
-- Baseado em Livros (ID 4)
(4, 7),(4, 8),(4, 11),(4, 14),(4, 47), 
-- Adolescente (ID 3)
(3, 10),(3, 24), 
-- Família (ID 7)
(7, 12),(7, 19),(7, 20),(7, 21),(7, 22),(7, 26),(7, 48), 
-- Suspense Psicológico (ID 8)
(8, 13),(8, 27), 
-- Super-herói (ID 5)
(5, 17),(5, 25),(5, 46),
-- Vampiros (ID 2)
(2, 18), 
-- series
-- Anos 80 (ID 1)
(1, 28), 
-- Baseado em Livros (ID 4)
(4, 29), (4, 36), (4, 42),(4, 44),
-- Família (ID 7)
(7, 30),(7, 31),(7, 34),(7, 35),(7, 43), 
-- Suspense Psicológico (ID 8)
(8, 32),(8, 37), 
-- Vampiros (ID 2)
(2, 33),(2, 38),(2, 40), 
-- Viagem no Tempo (ID 11)
(11, 39), 
-- Adolescente (ID 3)
(3, 41),(3, 45),(3, 49); 

SELECT * FROM PLANO;
SELECT * FROM IDIOMA;
SELECT * FROM LEGENDA;
SELECT * FROM CATEGORIA;
SELECT * FROM PALAVRACHAVE;
SELECT * FROM ARTISTA;
SELECT * FROM DIRETOR;
SELECT * FROM CONTEUDO;
SELECT * FROM FILME;
SELECT * FROM SERIE; 
SELECT * FROM TEMPORADA;
SELECT * FROM EPISODIO;
SELECT * FROM USUARIO;
SELECT * FROM PERFIL;
SELECT * FROM PAGAMENTO;
SELECT * FROM MINHALISTA;
SELECT * FROM AVALIACAO;
SELECT * FROM HISTORICOFILME;
SELECT * FROM HISTORICOEPISODIO;
SELECT * FROM ESTRELADO_POR;
SELECT * FROM DIRIGIDO_POR;
SELECT * FROM CLASSIFICADO_EM;
SELECT * FROM INDEXADO_POR;
SELECT * FROM DISPONIBILIZA_AUDIO_FILME;
SELECT * FROM DISPONIBILIZA_LEGENDA_FILME;
SELECT * FROM DISPONIBILIZA_AUDIO_EPISODIO;
SELECT * FROM DISPONIBILIZA_LEGENDA_EPISODIO;

-- Busca o nome dos filmes e séries lançados depois de 2022 e retorna o título do conteúdo, o ano de lançamento e o nome do ator/atriz
SELECT conteudo.titulo_conteudo, conteudo.ano_lancamento, artista.nome_artista
FROM conteudo
JOIN estrelado_por ON conteudo.id_conteudo = estrelado_por.id_conteudo
JOIN artista ON estrelado_por.id_artista = artista.id_artista
WHERE conteudo.ano_lancamento >= 2022
ORDER BY conteudo.titulo_conteudo;

-- Verificar quais conteúdos os usuários “Alice” e “Breno” salvaram na opção “minha lista”. Retorna o nome do usuário e o conteúdo. 
SELECT perfil.nome_perfil, conteudo.titulo_conteudo
FROM perfil
JOIN minhalista ON perfil.id_perfil = minhalista.id_perfil
JOIN conteudo ON minhalista.id_conteudo = conteudo.id_conteudo
WHERE perfil.nome_perfil IN ('Alice', 'Breno')
ORDER BY perfil.nome_perfil;

-- Lista os filmes e séries que estão na categoria “terror”.
SELECT categoria.nome_categoria, conteudo.titulo_conteudo
FROM categoria
JOIN classificado_em ON categoria.id_categoria = classificado_em.id_categoria
JOIN conteudo ON classificado_em.id_conteudo = conteudo.id_conteudo
WHERE categoria.nome_categoria = 'Terror';

-- Retorna todos os episódios cadastrados para a série "Stranger Things", mostrando a qual temporada pertencem e o título de cada episódio.
SELECT conteudo.titulo_conteudo, temporada.numero_temporada, episodio.numero_episodio, episodio.titulo_episodio
FROM conteudo
JOIN serie ON conteudo.id_conteudo = serie.id_conteudo_serie
JOIN temporada ON serie.id_conteudo_serie = temporada.id_conteudo_serie
JOIN episodio ON temporada.id_temporada = episodio.id_temporada
WHERE conteudo.titulo_conteudo = 'Stranger Things'
ORDER BY temporada.numero_temporada, episodio.numero_episodio;

-- Retorna o histórico de pagamento apenas para o plano “premium 4K”. 
SELECT usuario.nome_completo, plano.nome, pagamento.valor_pago, pagamento.data_pagamento
FROM usuario
JOIN plano ON usuario.id_plano = plano.id_plano
JOIN pagamento ON usuario.id_usuario = pagamento.id_usuario
WHERE plano.nome = 'Premium 4K';

-- Retorna todos os diretores cadastrados no sistema e seus filmes. Caso o diretor não tenha nenhum filme na plataforma, ele também é mostrado na pesquisa.
SELECT diretor.nome_diretor, conteudo.titulo_conteudo
FROM diretor
LEFT JOIN dirigido_por ON diretor.id_diretor = dirigido_por.id_diretor
LEFT JOIN conteudo ON dirigido_por.id_conteudo = conteudo.id_conteudo
ORDER BY conteudo.titulo_conteudo;

-- Retorna episódios de séries sem legendas. Isso ocorre para a série “Outer banks”, pois o último episódio foi lançado recentemente e ainda não estão disponíveis legendas. 
SELECT conteudo.titulo_conteudo, episodio.numero_episodio, episodio.titulo_episodio
FROM episodio
JOIN temporada ON episodio.id_temporada = temporada.id_temporada
JOIN serie ON temporada.id_conteudo_serie = serie.id_conteudo_serie
JOIN conteudo ON serie.id_conteudo_serie = conteudo.id_conteudo
LEFT JOIN disponibiliza_legenda_episodio ON episodio.id_episodio = disponibiliza_legenda_episodio.id_episodio
WHERE disponibiliza_legenda_episodio.id_legenda IS NULL;

-- Retorna o cálculo da média das notas dadas pelos usuários para cada conteúdo. O uso do having serve para filtrar o resultado, mostrando apenas filmes e séries com média superior a 3 estrelas.
SELECT conteudo.titulo_conteudo, AVG(avaliacao.nota) AS media_nota
FROM conteudo
JOIN avaliacao ON conteudo.id_conteudo = avaliacao.id_conteudo
GROUP BY conteudo.titulo_conteudo
HAVING AVG(avaliacao.nota) > 3
ORDER BY media_nota DESC;

-- Esta consulta soma o valor total arrecadado pela plataforma, agrupando os valores pelo método de pagamento, além de contar quantas transações foram feitas em cada método.
SELECT pagamento.metodo_pagamento, SUM(pagamento.valor_pago) AS total_recebido, COUNT(*) AS qtd_transacoes
FROM pagamento
GROUP BY pagamento.metodo_pagamento
ORDER BY total_recebido DESC;

-- Retorna os atores e a quantidade de obras que cada um estrelou. O filtro exibe apenas os atores que participaram de dois ou mais filmes/séries.  
SELECT artista.nome_artista, COUNT(estrelado_por.id_conteudo) AS qtd_obras
FROM artista
JOIN estrelado_por ON artista.id_artista = estrelado_por.id_artista
GROUP BY artista.nome_artista
HAVING COUNT(estrelado_por.id_conteudo) >= 2
ORDER BY qtd_obras DESC
LIMIT 10;

-- Retorna quantos episódios estão cadastrados para cada série. A consulta é filtrada para séries com mais de um episódio no sistema. 
SELECT conteudo.titulo_conteudo, COUNT(episodio.id_episodio) AS total_episodios
FROM conteudo
JOIN serie ON conteudo.id_conteudo = serie.id_conteudo_serie
JOIN temporada ON serie.id_conteudo_serie = temporada.id_conteudo_serie
JOIN episodio ON temporada.id_temporada = episodio.id_temporada
GROUP BY conteudo.titulo_conteudo
HAVING COUNT(episodio.id_episodio) > 1;
-- Retorna a quantidade de tentativas e o valor envolvido para cada status de pagamento (Aprovado, Pendente, Falha). 
SELECT pagamento.status, COUNT(*) AS quantidade, SUM(pagamento.valor_pago) AS valor_total
FROM pagamento
GROUP BY pagamento.status
ORDER BY quantidade DESC;