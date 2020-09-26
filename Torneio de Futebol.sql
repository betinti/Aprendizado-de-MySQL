drop database somativa2_BernardoTinti;

create database somativa2_BernardoTinti;
use somativa2_BernardoTinti;


create table TBPatrocinadores(
	CNPJ char(14), primary key(CNPJ),
    razaoSocial varchar(70),
    bonificacao int
    );

	insert into TBPatrocinadores values
		('74538259430283', 'Adidas',	2000000),
        ('93827492837481', 'Nike', 		1500000);

create table TBCidadeEstado(
	codigoCE char(2), primary key (codigoCE),
    UF char(2),
    cidade varchar(70)
	);
    
	insert into TBCidadeEstado values
		('81','ES','Vila Velha'),
        ('82','ES','Cariacica'),
        ('83','SP','Sao Paulo'),
        ('84','SP','Campos do Jordao'),
        ('85','RJ','Rio de Janeiro'),
        ('86','RJ','Jacone'),
        ('87','PR','Curitba'),
        ('88','PR','Sao Jose dos Pinhais'),
        ('89','ES','Foz do Iguacu');

create table TBEstadio(
	codigoEstadio char(2), primary key(codigoEstadio),
    lotacaoMaxima int,
    nome varchar(70),
    codigoCE char(2), foreign key (codigoCE) references TBCidadeEstado (codigoCE),
    rua varchar(70),
    numero varchar(6),
    bairro varchar(50),
    CEP char(8)
    );

    insert into TBEstadio values
		('10', 21000, 'Estadio Kleber Andrade', 			'82','Rua Padre Anchieta', '2', 'Rio Branco', 				'29147620'),
		('12', 78838, 'Maracana', 							'85','Avenida Presidente Castelo Branco', '3', 'Maracana', 	'20271130'),
        ('21', 66795, 'Estadio Cicero Pompeu de Toledo', 	'87','Rua Pires de Oliveira', '1', 'Morumbi', 				'05653070');
    
create table TBEstadio_Patrocinio(
	CNPJ_patrocinio char(14), foreign key (CNPJ_patrocinio) references TBPatrocinadores(CNPJ),
    codigoEstadio char(2), foreign key (codigoEstadio) references TBEstadio(codigoEstadio )
); 
    
    insert into TBEstadio_Patrocinio values 
		('93827492837481', '10'),	#Estadio Kleber Andrade
		('74538259430283', '12'),	#Maracana
        ('93827492837481', '12'),	#Maracana
        ('74538259430283', '21');	#Estadio Cicero Pompeu de Toledo
	
create table TBClube(
	codigoCE char(2), foreign key (codigoCE) references TBCidadeEstado (codigoCE),
    nomeClube varchar(70),
    codigoClube char(14), primary key(codigoClube)
    );
    
    insert into TBClube values
		('85', 'Clube de Regatas do Flamengo',  '45002300120043'),
        ('83', 'Sao Paulo Futebol Clube', 		'65003200450012');
        

    
create table TBClassificacao_Time(
	classificacao varchar(20),
    codigoClassificacao char(3), primary key (codigoClassificacao)
	);
		
        insert into TBClassificacao_Time values
			('Serie A','101'),
            ('Serie B','102'),
            ('Serie C','103');
    
create table TBPartida (
	codigoPartida char(2), primary key (codigoPartida),
    dataPartida date,
    codigoClassificacaoPartida char(3), foreign key (codigoClassificacaoPartida) references TBClassificacao_Time(codigoClassificacao),
    codigoClubeCasa char(14), foreign key (codigoClubeCasa) references TBClube(codigoClube),
    codigoClubeFora char(14), foreign key (codigoClubeCasa) references TBClube(codigoClube),
    codigoEstadio char(2), foreign key (codigoEstadio) references TBEstadio(codigoEstadio)
	);
    
    insert into TBPartida values
		('21','2019-05-12','101','45002300120043','65003200450012','12'),	#Maracana
        ('23','2020-03-31','101','65003200450012','45002300120043','21'),	#Estadio Cicero Pompeu de Toledo
		('25','2021-11-22','102','45002300120043','65003200450012','12');	#Maracana

create table TBTime(
	codigoTime char(3), primary key(codigoTime),
    codigoClassificacao char(3), foreign key (codigoClassificacao) references TBClassificacao_Time (codigoClassificacao),
    nome varchar(70),
    codigoClube char(14), foreign key (codigoClube) references TBClube(codigoClube)
    );
    
		insert into TBTime values
			('201', '101', 'Flamengo', 			'45002300120043'),	#Clube de Regatas do Flamengo
            ('202', '102', 'Flamengo Junior', 	'45002300120043'),	#Clube de Regatas do Flamengo
            ('203', '103', 'Flamengo Mirim', 	'45002300120043'),	#Clube de Regatas do Flamengo
            ('211', '101', 'Sao Paulo', 		'65003200450012'),	#Sao Paulo Futebol Clube
            ('212', '102', 'Sao Paulo Junior', 	'65003200450012'),	#Sao Paulo Futebol Clube
            ('213', '103', 'Sao Paulo Mirim', 	'65003200450012');	#Sao Paulo Futebol Clube
    
create table TBMembro(
	salario int,
    idade varchar(3),
    RG char(7),
    CPF char(11), primary key(CPF),
    nome varchar(70),
    codigoCE char(2), foreign key (codigoCE) references TBCidadeEstado (codigoCE),
    rua varchar(70),
    numero varchar(6),
    bairro varchar(50),
    CEP char(8),
    codigoTime char(3), foreign key (codigoTime) references TBTime (codigoTime)
	);
    
    insert into TBMembro values
		#Clube de Regatas do Flamengo
		(10000, '26', '4739284', '58394857123', 'Bruno Henrique', 	'85','Rua A', '123', 'Maracana', 	'44391283', '201'), #serie A - Jogador
        (10000, '21', '5739213', '74309853938', 'Gabriel Barbosa', 	'86','Rua B', '321', 'Ipanema', 	'57492038', '201'), #serie A - Jogador
        (20000, '65', '4729845', '29387562930', 'Jorge Jesus', 		'85','Rua C', '213', 'Ipanema', 	'75389345', '201'), #serie A - Assessor
        (5000,  '20', '5709392', '48239573372', 'Arrascaeta',		'86','Rua D', '456', 'Ipanema', 	'46489482', '202'), #serie B - Jogador
        (5000,  '19', '4792323', '29387261245', 'Gerson Santos',	'85','Rua E', '654', 'Ipanema',		'23872323', '202'), #serie B - Jogador
        (5000,  '56', '4398237', '32842348352', 'Diego Ribas',		'86','Rua F', '546', 'Maracana',  	'34857342', '202'), #serie B - Assessor
        (2500,	'17', '3443768', '49238429711', 'Rafinha',			'85','Rua J', '789', 'Ipanema',	 	'89327023', '203'), #serie C - Jogador
        (2500,	'18', '2398522', '75925973203', 'Everton Ribeito',	'86','Rua K', '987', 'Maracana',	'93847534', '203'), #serie C - Jogador
        (2500,	'36', '2398742', '23876423935', 'Filipe Luis',		'85','Rua L', '798', 'Ipanema', 	'47653235', '203'), #serie C - Assessor
        #Sao Paulo Futebol Clube
        (10000, '26', '5723425', '45720397522', 'Daniel Alves', 	'83','Rua Z', '1923', 'Centro', 	'56937223', '211'), #serie A - Jogador
        (10000, '23', '0593822', '43934023475', 'Alexandre Pato', 	'84','Rua Y', '2914', 'Morumbi', 	'44723952', '211'), #serie A - Jogador
        (10000, '46', '2753725', '09475349853', 'Fernando Diniz', 	'83','Rua X', '2196', 'Centro',  	'99337592', '211'), #serie A - Assessor
        (5000,  '19', '4986530', '49865343453', 'Antony Matheus', 	'83','Rua W', '3874', 'Centro',		'82934752', '212'), #serie B - Jogador
        (5000,  '20', '4386773', '67499233024', 'Juanfran',		 	'83','Rua V', '8673', 'Centro',		'34875343', '212'), #serie B - Jogador
        (5000,  '38', '3984752', '34632938753', 'Igor Gomes', 		'84','Rua U', '3568', 'Morumbi',	'67439234', '212'), #serie B - Assessor
        (2500,  '18', '5323245', '64364323392', 'Tiago Luis', 		'83','Rua T', '974',  'Centro',		'63498354', '213'), #serie C - Jogador
        (2500,  '17', '5732923', '63457293523', 'Everton Cardoso', 	'84','Rua S', '5234', 'Morumbi',	'57230234', '213'), #serie C - Jogador
        (2500,  '35', '5325224', '96734064888', 'Pablo Felipe', 	'83','Rua R', '9634', 'Centro',		'63423453', '213'); #serie C - Assessor
    
create table TBPosicao_Jogador(
	posicao varchar(20),
    codigoPosicao char(2), primary key (codigoPosicao)
	);
    
    insert into TBPosicao_Jogador values
		('Atacante',	'70'),
        ('Goleiro',		'71'),
        ('Meia',		'72'),
        ('Defesa',		'73'),
        ('Lateral',		'74');
    
create table TBJogador(
	CPF char(11), foreign key (CPF) references TBMembro (CPF), primary key (CPF),
    altura float,
    peso float,
    codigoPosicao char(2), foreign key (codigoPosicao) references TBPosicao_Jogador (codigoPosicao)
    );

    insert into TBJogador values 
		#Clube de Regatas do Flamengo
		('58394857123', 1.75, 71.0, '72'), 	#serie A - Jogador
        ('74309853938', 1.92, 98.0, '71'), 	#serie A - Jogador
        ('48239573372', 1.67, 87.0, '72'), 	#serie B - Jogador
        ('29387261245', 1.76, 78.0, '70'), 	#serie B - Jogador
        ('49238429711', 1.73, 75.0, '72'), 	#serie C - Jogador
        ('75925973203', 1.87, 69.0, '74'), 	#serie C - Jogador
		#Sao Paulo Futebol Clube
        ('45720397522', 1.95, 101.5,'71'), 	#serie A - Jogador
        ('43934023475', 1.76, 78.0, '74'), 	#serie A - Jogador
        ('49865343453', 1.69, 79.0, '72'), 	#serie B - Jogador
        ('67499233024', 1.79, 86.5, '74'), 	#serie B - Jogador
        ('64364323392', 1.64, 76.0, '73'), 	#serie C - Jogador
        ('63457293523', 1.78, 77.0, '71'); 	#serie C - Jogador
        
    
create table TBAtuacao_Assessor(
	atuacao varchar(20),
    codigoAtuacao char(2), primary key (codigoAtuacao)
	);
    
    insert into TBAtuacao_Assessor values
		('Tecnico', 	'60'),
        ('Treinador', 	'61'),
        ('Massagista', 	'62'),
        ('Empresario', 	'63');
    
create table TBAssessor(
	CPF char(11), foreign key (CPF) references TBMembro (CPF), primary key (CPF),
    codigoAtuacao varchar(20), foreign key (codigoAtuacao) references TBAtuacao_Assessor (codigoAtuacao)
	);
	
    insert into TBAssessor values 
		#Clube de Regatas do Flamengo
        ('29387562930', '63'), 	#serie A - Assessor
        ('32842348352', '61'), 	#serie B - Assessor
        ('23876423935', '62'), 	#serie C - Assessor
        #Sao Paulo Futebol Clube
        ('09475349853', '60'), 	#serie A - Assessor
        ('34632938753', '63'), 	#serie B - Assessor
        ('96734064888', '61'); 	#serie C - Assessor
    
create table TBCelular_Equipe(
	CPF char(11), foreign key (CPF) references TBMembro (CPF), primary key (CPF),
    celular char(9),
    ddd char(2)
	);
    
    
    insert into TBCelular_Equipe values
		#Clube de Regatas do Flamengo
		('58394857123', '999452344', '21'), 	#serie A - Jogador
        ('74309853938', '999457323', '21'),		#serie A - Jogador
        ('48239573372', '998543532', '21'),		#serie B - Jogador
        ('29387261245', '999835233', '21'), 	#serie B - Jogador
        ('49238429711', '998844552', '21'),		#serie C - Jogador
        ('75925973203', '999338844', '21'), 	#serie C - Jogador
		('29387562930', '999452344', '21'),		#serie A - Assessor
        ('32842348352', '999452344', '21'), 	#serie B - Assessor
        ('23876423935', '999452344', '21'), 	#serie C - Assessor
        #Sao Paulo Futebol Clube
		('45720397522', '993423532', '11'), 	#serie A - Jogador
        ('43934023475', '994535232', '11'), 	#serie A - Jogador
        ('49865343453', '999342342', '11'), 	#serie B - Jogador
        ('67499233024', '998833345', '11'),		#serie B - Jogador
        ('64364323392', '999994221', '11'),		#serie C - Jogador
        ('63457293523', '998833445', '11'), 	#serie C - Jogador
        ('09475349853', '999834213', '11'), 	#serie A - Assessor
        ('34632938753', '999241335', '11'), 	#serie B - Assessor
        ('96734064888', '998938432', '11'); 	#serie C - Assessor
	

create table TBEmail_Equipe(
	CPF char(11), foreign key (CPF) references TBMembro (CPF), primary key (CPF),
    email varchar(70)
    );
    
    insert into TBEmail_Equipe values
		#Clube de Regatas do Flamengo
		('58394857123', 'aba@crf.com.br'), 	#serie A - Jogador
        ('74309853938', 'ams@crf.com.br'),	#serie A - Jogador
        ('48239573372', 'asd@crf.com.br'),	#serie B - Jogador
        ('29387261245', 'gds@crf.com.br'), 	#serie B - Jogador
        ('49238429711', 'rgd@crf.com.br'),	#serie C - Jogador
        ('75925973203', 'dgs@crf.com.br'), 	#serie C - Jogador
		('29387562930', 'gdsd@crf.com.br'),	#serie A - Assessor
        ('32842348352', 'gdd@crf.com.br'),	#serie B - Assessor
        ('23876423935', 'hfd@crf.com.br'), 	#serie C - Assessor
        #Sao Paulo Futebol Clube
		('45720397522', 'gdsd@spfc.com.br'), 	#serie A - Jogador
        ('43934023475', 'gdsd@spfc.com.br'), 	#serie A - Jogador
        ('49865343453', 'hfdd@spfc.com.br'), 	#serie B - Jogador
        ('67499233024', 'agds@spfc.com.br'),	#serie B - Jogador
        ('64364323392', 'gsds@spfc.com.br'),	#serie C - Jogador
        ('63457293523', 'djfk@spfc.com.br'), 	#serie C - Jogador
        ('09475349853', 'gsds@spfc.com.br'), 	#serie A - Assessor
        ('34632938753', 'ghdf@spfc.com.br'), 	#serie B - Assessor
        ('96734064888', 'htdf@spfc.com.br'); 	#serie C - Assessor
    
create table TBCategoria_Filiacao(
	categoriaFiliacao varchar(10),
    bonificacaoMensal int,
    codigoFiliacao char(3), primary key (codigoFiliacao)
	);
    
    insert into TBCategoria_Filiacao values
		('PREMIUM', 200, 	'421'),
        ('MID', 100, 		'422'),
        ('SMALL', 50, 		'423');
    
create table TBCategoria_Ingresso(
	categoriaIngresso varchar(20), primary key (categoriaIngresso),
    valorIngresso int
    );
    
	insert into TBCategoria_Ingresso values 
		('VIP', 		150),
        ('COBERTO',		70),
        ('DESCOBERTO', 	50);
    
create table TBTorcedor(
	nome varchar(70),
    CPFTorcedor char(11), primary key(CPFTorcedor),
    RG char(7),
    idade varchar(3),
    codigoCE char(2), foreign key (codigoCE) references TBCidadeEstado (codigoCE),
    rua varchar(70),
    numero varchar(6),
    bairro varchar(50),
    CEP char(8)
	);
    
    insert into TBTorcedor values
		#Clube de Regatas do Flamengo
        ('Roberto', 	'98756786534', '6534523', '36', '82', 'Rua Branca', '34', 'Praia da Costa', 	'47384564'), # Filiado - PREMIUM
        ('Bernardo', 	'53987523532', '7547457', '45', '81', 'Rua Azul', '43', 'Itaparica', 			'36343322'), # Filiado - MID
        ('Carlos', 		'64363432523', '7544346', '32', '83', 'Rua Vermelha', '56', 'Centro', 			'76534532'), # Filiado - SMALL
		#Sao Paulo Futebol Clube
        ('Joao', 		'64536473233', '4985273', '37', '82', 'Rua Lilas', '64', 'Mata da Praia', 		'63435322'), # Filiado - PREMIUM
        ('Renato', 		'66435423566', '7452757', '45', '81', 'Rua Rosa', '65', 'Soido', 				'46325573'), # Filiado - MID
        ('Eugenio', 	'74752935838', '7389365', '65', '85', 'Rua Turquesa', '23', 'Matinhos', 		'44634623'), # Filiado - SMALL
        #Comum
        ('Eduardo', 	'33423452341', '7453453', '23', '86', 'Rua Preta', '65', 'Asa Norte', 			'76343634'), # Comum - VIP
        ('Vitor', 		'46347345633', '4634522', '76', '87', 'Rua Verde', '67', 'Batel', 				'74654353'), # Comum - COBERTO
        ('Felipe', 		'63984725363', '6436342', '43', '82', 'Rua Amarela', '87', 'Sao Miguel', 		'34534536'), # Comum - DESCOBERTO
        ('Jose', 		'63763297632', '0038582', '34', '88', 'Rua Verde', '72', 'Centro', 				'74534524'), # Comum - VIP
        ('Maria', 		'93857572234', '5532835', '67', '89', 'Rua Roxo', '33', 'Agua Verde', 			'74387593'), # Comum - COBERTO
        ('Gilberto', 	'35293349634', '6343452', '42', '81', 'Rua Azul', '64', 'Asa Sul', 				'07985684'); # Comum - DESCOBERTO
        


create table TBFiliado(
	CPFTorcedor char(11), foreign key (CPFTorcedor) references TBTorcedor (CPFTorcedor), primary key (CPFTorcedor),
    codigoFiliacao char(3), foreign key (codigoFiliacao) references TBCategoria_Filiacao (codigoFiliacao),
    codigoClube char(14), foreign key (codigoClube) references TBClube (codigoClube)
    );

	insert into TBFiliado values
		#Clube de Regatas do Flamengo
        ('98756786534', '421', '45002300120043'), # Filiado - PREMIUM
        ('53987523532', '422', '45002300120043'), # Filiado - MID
        ('64363432523', '423', '45002300120043'), # Filiado - SMALL
        #Sao Paulo Futebol Clube
        ('64536473233', '421', '65003200450012'), # Filiado - PREMIUM
        ('66435423566', '422', '65003200450012'), # Filiado - MID
        ('74752935838', '423', '65003200450012'); # Filiado - SMALL
    
create table TBTorcedor_Comum(
	CPFTorcedor char(11), foreign key (CPFTorcedor) references TBTorcedor (CPFTorcedor), primary key (CPFTorcedor),
    categoriaIngresso varchar(20), foreign key (categoriaIngresso) references TBCategoria_Ingresso (categoriaIngresso)
	);

	insert into TBTorcedor_Comum values
        ('33423452341', 'VIP'), 		# Comum - VIP
        ('46347345633', 'COBERTO'), 	# Comum - COBERTO
        ('63984725363', 'DESCOBERTO'), 	# Comum - DESCOBERTO
        ('63763297632', 'VIP'), 		# Comum - VIP
        ('93857572234', 'COBERTO'), 	# Comum - COBERTO
        ('35293349634', 'DESCOBERTO'); 	# Comum - DESCOBERTO

create table TBCelular_Torcedor(
	CPFTorcedor char(11), foreign key (CPFTorcedor) references TBTorcedor (CPFTorcedor), primary key (CPFTorcedor),
    celular char(9),
    ddd char(2)
	);
    
    insert into TBCelular_Torcedor values
		#Clube de Regatas do Flamengo
        ('98756786534', '999454322', '21'), 	# Filiado - PREMIUM
        ('53987523532', '999423242', '11'), 	# Filiado - MID
        ('64363432523', '999342352', '41'), 	# Filiado - SMALL
        #Sao Paulo Futebol Clube
        ('64536473233', '998335255', '27'), 	# Filiado - PREMIUM
        ('66435423566', '998544553', '27'), 	# Filiado - MID
        ('74752935838', '999432425', '28'), 	# Filiado - SMALL
        #Comum
        ('33423452341', '998844553', '45'),		# Comum - VIP
        ('46347345633', '999323496', '32'),		# Comum - COBERTO
        ('63984725363', '998434532', '22'), 	# Comum - DESCOBERTO
        ('63763297632', '993428432', '42'), 	# Comum - VIP
        ('93857572234', '998833774', '21'), 	# Comum - COBERTO
        ('35293349634', '998833442', '11'); 	# Comum - DESCOBERTO
    
create table TBEmail_Torcedor(
	CPFTorcedor char(11), foreign key (CPFTorcedor) references TBTorcedor (CPFTorcedor), primary key (CPFTorcedor),
    email varchar(100)
	);
    
	insert into TBEmail_Torcedor values
		#Clube de Regatas do Flamengo
        ('98756786534', 'alo@hotmail.com'), 	# Filiado - PREMIUM
        ('53987523532', 'agds@gmail.com'), 		# Filiado - MID
        ('64363432523', 'adsa@ig.com'), 		# Filiado - SMALL
        #Sao Paulo Futebol Clube
        ('64536473233', 'gfs@outlook.com'), 	# Filiado - PREMIUM
        ('66435423566', 'oeef@gamil.com'), 		# Filiado - MID
        ('74752935838', 'kfds@hotmail.com'),	# Filiado - SMALL
        #Comum
        ('33423452341', 'gdsa@outlook.com'),	# Comum - VIP
        ('46347345633', 'agds@gmai;.com'),		# Comum - COBERTO
        ('63984725363', 'asgs@hotmail.com'),	# Comum - DESCOBERTO
        ('63763297632', 'qrsf@hotmail.com'),	# Comum - VIP
        ('93857572234', 'jfsc@gamil.com'), 		# Comum - COBERTO
        ('35293349634', 'rysf@gmail.com'); 		# Comum - DESCOBERTO
        
        
    
create table TBPartida_Torcedor(
	cod_Relacao char(3), primary key(cod_Relacao),
	codigoPartida char(2), foreign key (codigoPartida) references TBPartida (codigoPartida),
    CPFTorcedor char(11), foreign key (CPFTorcedor) references TBTorcedor (CPFTorcedor)
	);
        
        insert into TBPartida_Torcedor values
			#Partida 21
			('901', '21', '98756786534'), 	# Filiado - PREMIUM
            ('902', '21', '53987523532'),	# Filiado - MID
            ('903', '21', '74752935838'),	# Filiado - SMALL
            ('904', '21', '33423452341'),	# Comum
            ('905', '21', '46347345633'),	# Comum
            ('906', '21', '63984725363'),	# Comum
            #Partida 23
            ('907', '23', '53987523532'),	# Filiado
            ('908', '23', '66435423566'),	# Filiado
            ('909', '23', '74752935838'),	# Filiado
            ('910', '23', '63763297632'),	# Comum
            ('911', '23', '93857572234'),	# Comum
            ('912', '23', '35293349634'),	# Comum
            #Partida 25
            ('913', '25', '53987523532'),	# Filiado
            ('914', '25', '64363432523'),	# Filiado
            ('915', '25', '98756786534'),	# Filiado
            ('916', '25', '33423452341'),	# Comum
            ('917', '25', '63984725363'),	# Comum
            ('918', '25', '35293349634');	# Comum
	

        
/*		SELECT		*/


#	1.	Número total de jogadores cadastrados;
SELECT COUNT(TBJogador.CPF)
FROM TBJogador, TBMembro
WHERE TBJogador.CPF = TBMembro.CPF;


#	2.	Número de filiados de um único clube;
SELECT COUNT(TBFiliado.CPFTorcedor)
FROM TBFiliado
WHERE TBFiliado.codigoClube = '45002300120043';


#	3.	Valor total arrecadado por um estádio por meio de patrocinadores;
SELECT SUM(TBPatrocinadores.bonificacao)
FROM TBPatrocinadores, TBEstadio_Patrocinio
WHERE TBEstadio_Patrocinio.codigoEstadio = '12' 
	AND TBEstadio_Patrocinio.CNPJ_patrocinio = TBPatrocinadores.CNPJ;


#	4.	Todos os jogadores do clube da casa que não participaram de uma determinada partida;
SELECT TBMembro.nome
FROM TBJogador, TBMembro, TBTime, TBPartida, TBClube
WHERE TBJogador.CPF = TBMembro.CPF
	AND TBMembro.codigoTime = TBTime.codigoTime
    AND TBTime.codigoClube = TBClube.codigoClube
    AND TBPartida.codigoClubeCasa = TBClube.codigoClube
    AND TBPartida.codigoPartida = '25'
    AND TBTime.codigoClassificacao not in(
									SELECT TBPartida.codigoClassificacaoPartida
									FROM TBPartida
									WHERE TBPartida.codigoPartida = '25')
GROUP BY TBJogador.CPF;


#	5.	Os torcedores que não foram em uma partida da Série B;
SELECT TBPartida_Torcedor.CPFTorcedor
FROM TBPartida_Torcedor
WHERE TBPartida_Torcedor.codigoPartida not in (
										SELECT TBPartida.codigoPartida
										FROM TBPartida
										WHERE TBPartida.codigoClassificacaoPartida = '102'); 


#	6.	Os patrocinadores que não patrocinam um determinado estádio;
SELECT TBPatrocinadores.CNPJ
FROM TBPatrocinadores
WHERE TBPatrocinadores.CNPJ not in (
							SELECT TBEstadio_Patrocinio.CNPJ_patrocinio
							FROM TBEstadio_Patrocinio
							WHERE TBEstadio_Patrocinio.codigoEstadio = '10'); 


#	7.	Número de times do clube de fora que jogaram em uma das partidas;
SELECT COUNT(TBTime.codigoTime), TBClube.nomeClube
FROM TBTime, TBPartida, TBClube
WHERE  TBPartida.codigoClubeFora = TBClube.codigoClube
	AND TBClube.codigoClube = TBTime.codigoClube
	AND TBPartida.codigoPartida = '23'
GROUP BY TBClube.codigoClube;


#	8.	Os celulares de um time e seus respectivos nomes;
SELECT TBCelular_Equipe.celular, TBMembro.nome
FROM TBCelular_Equipe, TBMembro, TBTime
WHERE TBCelular_Equipe.CPF = TBMembro.CPF
	AND TBTime.codigoTime = TBMembro.codigoTime
    AND TBTime.codigoTime = '212'
GROUP BY TBCelular_Equipe.CPF, TBMembro.CPF;


#	9.	A altura de um jogador, seu nome e o nome de seu time;
SELECT TBJogador.altura, TBMembro.nome, TBTime.nome
FROM TBJogador, TBMembro, TBTime
	WHERE TBMembro.codigoTime = TBTime.codigoTime
		AND TBJogador.CPF = TBMembro.CPF
GROUP BY TBJogador.CPF, TBMembro.CPF, TBTime.codigoTime;


#	10.	UF de um clube, CPF de seus afiliados e suas respectivas categorias.
SELECT TBCidadeEstado.UF, TBFiliado.CPFTorcedor, TBCategoria_Filiacao.categoriaFiliacao
FROM TBClube, TBFiliado, TBCategoria_Filiacao, TBCidadeEstado
WHERE TBFiliado.codigoFiliacao = TBCategoria_Filiacao.codigoFiliacao
	AND TBFiliado.codigoClube = TBClube.codigoClube
    AND TBClube.codigoCE = TBCidadeEstado.codigoCE
GROUP BY TBCidadeEstado.codigoCE, TBFiliado.CPFTorcedor, TBCategoria_Filiacao.codigoFiliacao;