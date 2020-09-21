extends Node


#==== Components ====#

var c_main_menu_panel 


#==== Bootstrap ====#

func _ready():
	initialize_folders()
	initialize_main_menu()


func initialize_main_menu():
	c_main_menu_panel = get_child(0)
	c_main_menu_panel.initialize(self)


func initialize_folders():
	var directory = Directory.new()
	
	if not directory.dir_exists("user://Decks/"):
		directory.make_dir_recursive("user://Decks/")
	
	if not directory.dir_exists("user://Cards/"):
		directory.make_dir_recursive("user://Cards/")
		load_initial_cards()



func load_initial_cards():
	var deck_prefab = load("res://Cards/Decks/Deck.tscn").instance()
	deck_prefab.initialize_deck()
	deck_prefab.s_name = "Deck_1"
	var card_type_list = []
	
	
	var choose_card_prefab = load("res://Cards/CardTypes/ChooseCard/ChooseCardData.tscn").instance()
	var choose_card_prefab_labels = [
		{	"a":"Enche o copo", 
			"b":"penalti"},
		{	"a":"Bebe 2 penaltis e manda alguem beber 3 penaltis", 
			"b":"Bebe um penalti e manda alguém beber de penalti"},
		{ 	"a":"Bebe 2 por cada gordo presente", 
			"b":"Bebe 3 por cada anão"},
		{ 	"a":"Canta a fuzleira", 
			"b":"Bebe 5"},
		{ 	"a":"Manda 1 bongada", 
			"b":"Manda 1 shot de bagaço"},
		{ 	"a":"Faz um cacete", 
			"b":"Manda um shot de uma bebida branca"},
		{ 	"a":"Canta a fuzleira", 
			"b":"Bebe 5"},
		{ 	"a":"Limpa o lixo da mesa", 
			"b":"Manda um penalti"},
		{ 	"a":"Faz uma serenata a alguém à tua escolha", 
			"b":"Bebe um penalti"},
		{ 	"a":"Obriga o piu a beber mais de 2 minis", 
			"b":"Obriga alguem a mandar o copo de penalti"},
		{ 	"a":"Bebe 1", 
			"b":"Bebe 2"},
		{ 	"a":"Faz um cacetinho", 
			"b":"Manda um pénalti"},
		{ 	"a":"Bebe 1", 
			"b":"Bebe 3 e manda alguém beber 3"}]

	for label in choose_card_prefab_labels:
		choose_card_prefab.s_option_a = label.a
		choose_card_prefab.s_option_b = label.b
		card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
		save_card(choose_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 0, card_type_list)
	card_type_list = []
	
	
	var do_card_prefab = load("res://Cards/CardTypes/DoCard/DoCardData.tscn").instance()
	var do_card_prefab_labels = [
		"Bebe 1 gole.",
		"Bebe 2 goles.",
		"Manda Pénalti.",
		"Troca de copo com alguém.",
		"Faz uma cascata a começar em ti. Todos os jogadores que tiverem o copo vazio, enchem tudo.",
		"Estas imune às regras do jogo durante um turno. Bebe 3 goles para ativar este efeito.",
		"Bebe 3 e força alguém a beber 3.",
		"Roda todos os copos para a direita ou para a esquerda.",
		"Enche o copo e bebe 2 goles.",
		"Se tiveres o copo a menos de metade, bebe de penalti o que falta. Se não, bebe 2 goles.",
		"Manda uma pescoçada.",
		"Todos os homens bebem.",
		"Cria uma regra nova.",
		"Mete uma bebida diferente da que tens no copo.",
		"Tu e os 2 jogadores ao teu lado bebem 3 goles.",
		"O último jogador a pôr a mão na mesa bebe o copo de penalti.",
		"Diz um tema. Toda a gente diz algo relacionado a esse tema, até alguém falhar. Esse jogador bebe 1 gole por cada volta à mesa.",
		"O jogador mais novo e o jogador mais velho bebem 2 goles.",
		"Escolhe uma palavra. Todos os jogadores estão proibídos de a dizer até ao fim do jogo.",
		"Até tirares uma carta do baralho, tens de estar em pé.",
		"Toda a gente conta uma piada seca. Até rodar a mesa, quem se rir tem de beber 3 goles.",
		"Força o jogador com menos bebida no copo a mandar uma pescoçada.",
		"Faz um senhor Bob.",
		"Se o Tiago estiver, damos-lhe todos um abraço e ele bebe 1 gole. Se não estiver, bebe 3 e fica muito triste. Se chorares, só bebes 2.",
		"Bebe de pénalti e manda uma chapada a alguém à tua escolha.",
		"Tens de por a prima do piu de 4. Se não conseguires, bebe 3 goles.",
		"És o capitão. Manda beber quem tu quiseres.",
		"Bebe o que quiseres do teu copo. Toda a gente tem de fazer o mesmo.",
		"Toda a gente manda um penalti.",
		"Se o mota vier, tem de beber 1 gole por cada jogador.",
		"Se o Xias estiver, tens de ser arremessado por ele. Se fores o Xias, lamento, são as regras.",
		"Se o bolacha não estiver em jogo leva um cachaço de toda a gente do jogo, senao saltamos todos de alegria e bebemos um golo.",
		"A partir de agora sempre que um soldade for abatido, toda a gente se levanta e faz um brinde ao melhor tom possivel.",
		"Enche o copo de toda a gente ate cima e puxa uma imaculada ao melhor tom possivel.",
		"Se a nazaré for puta bebe toda a gente 3 goles. Ps: a nazaré é puta.",
		"Se alguma gaja nao estiver na cozinha o piu bebe o copo de penalti. Se nao estiverem gajas presentes o piu bebe so dois goles. Se o piu n#ao estiver manda tu o teu copo de penalty.",
		"Se o burgos ja estiver a ser chato ele be 2 goles, senao bebe 3 goles. Se o burgos nao estiver bebe tu 5 goles.",
		"Se houver muralhas, temos de tombar tudo esta ronda. Ah pois é, é o José."
	]
	
	for label in do_card_prefab_labels:
		do_card_prefab.s_what_to_do = label
		card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
		save_card(do_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 1, card_type_list)
	card_type_list = []
	
	
	var keep_card_prefab = load("res://Cards/CardTypes/KeepCard/KeepCardData.tscn").instance()
	var keep_card_prefab_labels = [
		"Bebe tudo o que tens no copo e anula um efeito",
		"Ao guardares a carta, escolhe um parceiro. Sempre que beberes, ele bebe. Ao jogares esta carta, ele bebe 3 goles do copo.",
		"Se beberes um penalti, manda alguem beber 2 penaltis",
		"Guarda o numero de goles que acumulares até jogares esta carta. Manda beber esse número de goles (max 10)",
		"Toda a gente troca de copo para a direita.",
		"Quem te mandar fazer algo, também tem de fazer.",
		"Quando alguem te mandar fazer alguma coisa, usa o copo de alguem para o fazer.",
		"Quando alguém rodar um cacete, és chapa dux.",
		"Quando for preciso ir buscar bebidas, escolhe quem vai.",
		"Quando alguém for a casa de banho, mina a bebida dele.",
		"Podes minar a bebida de alguem.",
		"Cancela a vez de jogar de uma pessoa, joga tu com a carta dele.",
		"Podes ativar isto em alguem que tenha um copo vazio, ele é o barista ate ao fim do jogo.",
		"Se o bolacha der trigger, ativa esta carta e manda alguem beber de penalti."
	]
	
	for label in keep_card_prefab_labels:
		keep_card_prefab.s_what_to_do = label
		card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
		save_card(keep_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 2, card_type_list)
	card_type_list = []
	
	
	save_deck(deck_prefab)


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






#==== Logic ====#

func load_game(player_names, deck):
	var game_info = load("res://Components/GameInfo.tscn").instance()
	game_info.initialize(player_names, deck)
	start_game(game_info)


func start_game(player_names):
	var game_info = load("res://Components/GameInfo.tscn").instance()
	var overseer = load("res://Components/Overseer.tscn").instance()
	game_info.a_players = player_names
	game_info.a_deck = get_deck_temp()
	overseer.initialize(game_info)
	add_child(overseer)
	c_main_menu_panel.queue_free()
	c_main_menu_panel.visible = false



func get_deck_temp():
	var deck = c_main_menu_panel.c_card_editor_panel.c_deck_viewer.d_deck["Deck_1"].get_deck_as_list()
	return deck
