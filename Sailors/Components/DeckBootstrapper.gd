extends Node


#==== Bootstrap ====#

func initialize():
	initialize_folders()


func initialize_folders():
	var directory = Directory.new()
	
	if not directory.dir_exists("user://Decks/"):
		directory.make_dir_recursive("user://Decks/")
	
	if not directory.dir_exists("user://Cards/"):
		directory.make_dir_recursive("user://Cards/")
		load_initial_decks()


func load_initial_decks():
	var deck_prefab = load("res://Cards/Decks/Deck.tscn").instance()
	deck_prefab.initialize_deck()
	
	load_standard_deck(deck_prefab)





#==== Logic ====#

func load_standard_deck(deck_prefab):
	deck_prefab.s_name = "Deck_1"
	var card_type_list = []
	
	var choose_card_prefab = load("res://Cards/CardTypes/ChooseCard/ChooseCardData.tscn").instance()
	
	choose_card_prefab.s_option_a = "Enche o copo"
	choose_card_prefab.s_option_b = "penalti"
	card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
	save_card(choose_card_prefab)
	
	choose_card_prefab.s_option_a = "Bebe 2 penaltis e manda alguem beber 3 penaltis"
	choose_card_prefab.s_option_b = "Bebe um penalti e manda alguém beber de penalti"
	card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
	save_card(choose_card_prefab)
	
	choose_card_prefab.s_option_a = "Bebe 2 por cada gordo presente"
	choose_card_prefab.s_option_b = "Bebe 3 por cada anão"
	card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
	save_card(choose_card_prefab)
	
	choose_card_prefab.s_option_a = "Canta a fuzleira"
	choose_card_prefab.s_option_b = "Bebe 5"
	card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
	save_card(choose_card_prefab)
	
	choose_card_prefab.s_option_a = "Manda 1 bongada"
	choose_card_prefab.s_option_b = "Manda 1 shot de bagaço"
	card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
	save_card(choose_card_prefab)
	
	choose_card_prefab.s_option_a = "Faz um cacete"
	choose_card_prefab.s_option_b = "Manda um shot de uma bebida branca"
	card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
	save_card(choose_card_prefab)
	
	choose_card_prefab.s_option_a = "Limpa o lixo da mesa"
	choose_card_prefab.s_option_b = "Manda um penalti"
	card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
	save_card(choose_card_prefab)
	
	choose_card_prefab.s_option_a = "Faz uma serenata a alguém à tua escolha"
	choose_card_prefab.s_option_b = "Bebe um penalti"
	card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
	save_card(choose_card_prefab)
	
	choose_card_prefab.s_option_a = "Obriga o piu a beber mais de 2 minis"
	choose_card_prefab.s_option_b = "Obriga alguem a mandar o copo de penalti"
	card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
	save_card(choose_card_prefab)
	
	choose_card_prefab.s_option_a = "Bebe 1"
	choose_card_prefab.s_option_b = "Bebe 2"
	card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
	save_card(choose_card_prefab)
	
	choose_card_prefab.s_option_a = "Faz um cacetinho"
	choose_card_prefab.s_option_b = "Manda um pénalti"
	card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
	save_card(choose_card_prefab)
	
	choose_card_prefab.s_option_a = "Bebe 1"
	choose_card_prefab.s_option_b = "Bebe 3 e manda alguém beber 3"
	card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
	save_card(choose_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 0, card_type_list)
	card_type_list = []
	
	
	var do_card_prefab = load("res://Cards/CardTypes/DoCard/DoCardData.tscn").instance()
	
	do_card_prefab.s_what_to_do = "Bebe 1 gole."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Bebe 2 goles."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Manda Pénalti."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Troca de copo com alguém."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Faz uma cascata a começar em ti. Todos os jogadores que tiverem o copo vazio, enchem tudo."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Estas imune às regras do jogo durante um turno. Bebe 3 goles para ativar este efeito."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Bebe 3 e força alguém a beber 3."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Roda todos os copos para a direita ou para a esquerda."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Enche o copo e bebe 2 goles."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Se tiveres o copo a menos de metade, bebe de penalti o que falta. Se não, bebe 2 goles."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Manda uma pescoçada."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Todos os homens bebem."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Cria uma regra nova."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Mete uma bebida diferente da que tens no copo."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Tu e os 2 jogadores ao teu lado bebem 3 goles."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "O último jogador a pôr a mão na mesa bebe o copo de penalti."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Diz um tema. Toda a gente diz algo relacionado a esse tema, até alguém falhar. Esse jogador bebe 1 gole por cada volta à mesa. "
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "O jogador mais novo e o jogador mais velho bebem 2 goles."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Escolhe uma palavra. Todos os jogadores estão proibídos de a dizer até ao fim do jogo."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Até tirares uma carta do baralho, tens de estar em pé."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Toda a gente conta uma piada seca. Até rodar a mesa, quem se rir tem de beber 3 goles."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Força o jogador com menos bebida no copo a mandar uma pescoçada."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Faz um senhor Bob."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Se o Tiago estiver, damos-lhe todos um abraço e ele bebe 1 gole. Se não estiver, bebe 3 e fica muito triste. Se chorares, só bebes 2."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Bebe de pénalti e manda uma chapada a alguém à tua escolha."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Tens de por a prima do piu de 4. Se não conseguires, bebe 3 goles."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "És o capitão. Manda beber quem tu quiseres."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Bebe o que quiseres do teu copo. Toda a gente tem de fazer o mesmo."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Toda a gente manda um penalti."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Se o mota vier, tem de beber 1 gole por cada jogador."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Se o Xias estiver, tens de ser arremessado por ele. Se fores o Xias, lamento, são as regras."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Se o bolacha não estiver em jogo leva um cachaço de toda a gente do jogo, senao saltamos todos de alegria e bebemos um golo."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "A partir de agora sempre que um soldade for abatido, toda a gente se levanta e faz um brinde ao melhor tom possivel."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Enche o copo de toda a gente ate cima e puxa uma imaculada ao melhor tom possivel."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Se a nazaré for puta bebe toda a gente 3 goles. Ps: a nazaré é puta."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Se alguma gaja nao estiver na cozinha o piu bebe o copo de penalti. Se nao estiverem gajas presentes o piu bebe so dois goles. Se o piu n#ao estiver manda tu o teu copo de penalty."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Se o burgos ja estiver a ser chato ele be 2 goles, senao bebe 3 goles. Se o burgos nao estiver bebe tu 5 goles."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	do_card_prefab.s_what_to_do = "Se houver muralhas, temos de tombar tudo esta ronda. Ah pois é, é o José."
	card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
	save_card(do_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 1, card_type_list)
	card_type_list = []
	
	
	var keep_card_prefab = load("res://Cards/CardTypes/KeepCard/KeepCardData.tscn").instance()
	
	keep_card_prefab.s_what_to_do = "Bebe tudo o que tens no copo e anula um efeito"
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	keep_card_prefab.s_what_to_do = "Ao guardares a carta, escolhe um parceiro. Sempre que beberes, ele bebe. Ao jogares esta carta, ele bebe 3 goles do copo."
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	keep_card_prefab.s_what_to_do = "Se beberes um penalti, manda alguem beber 2 penaltis"
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	keep_card_prefab.s_what_to_do = "Guarda o numero de goles que acumulares até jogares esta carta. Manda beber esse número de goles (max 10)"
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	keep_card_prefab.s_what_to_do = "Toda a gente troca de copo para a direita."
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	keep_card_prefab.s_what_to_do = "Quem te mandar fazer algo, também tem de fazer."
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	keep_card_prefab.s_what_to_do = "Quando alguem te mandar fazer alguma coisa, usa o copo de alguem para o fazer."
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	keep_card_prefab.s_what_to_do = "Quando alguém rodar um cacete, és chapa dux."
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	keep_card_prefab.s_what_to_do = "Quando for preciso ir buscar bebidas, escolhe quem vai."
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	keep_card_prefab.s_what_to_do = "Quando alguém for a casa de banho, mina a bebida dele."
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	keep_card_prefab.s_what_to_do = "Podes minar a bebida de alguem."
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	keep_card_prefab.s_what_to_do = "Cancela a vez de jogar de uma pessoa, joga tu com a carta dele."
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	keep_card_prefab.s_what_to_do = "Podes ativar isto em alguem que tenha um copo vazio, ele é o barista ate ao fim do jogo."
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	keep_card_prefab.s_what_to_do = "Se o bolacha der trigger, ativa esta carta e manda alguem beber de penalti."
	card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
	save_card(keep_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 2, card_type_list)
	card_type_list = []
	
	save_deck(deck_prefab)


func load_easy_deck():
	pass


func load_hard_deck():
	pass


func load_beer_deck():
	pass
 




#==== Data Persistence ====#


func save_card(card_prefab):
	var card_path = "user://Cards/" + card_prefab.get_card_hash_id()
	var was_successful = false
	var card_save_file = File.new()
	if not card_save_file.file_exists(card_path):
		card_save_file.open(card_path, File.WRITE)
		card_save_file.store_line(to_json(card_prefab.get_card_as_dictionary()))
		was_successful = true
		print("saved card at ", card_path)
	else:
		print("An equal card already exists.")
		
	return was_successful



func add_type_cards_to_deck(deck_prefab, card_type, card_id_list):
	deck_prefab.add_card_list(card_type, card_id_list)
	return deck_prefab



func save_deck(deck):
	var deck_save_file = File.new()
	var deck_path = "user://Decks/" + deck.s_name
	
	if not deck_save_file.file_exists(deck_path):
		deck_save_file.open(deck_path, File.WRITE)
		deck_save_file.store_line(to_json(deck.get_deck_as_dictionary()))
	else:
		print("deck with same name already exists, overriding")
		deck_save_file.open(deck_path, File.WRITE)
		deck_save_file.store_line(to_json(deck.get_deck_as_dictionary()))
