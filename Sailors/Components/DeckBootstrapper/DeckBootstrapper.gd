extends Node

#==== Prefabs ====#

var p_choose_card
var p_do_card
var p_keep_card




#==== Bootstrap ====#

func initialize():
	initialize_prefabs()
	initialize_folders()
	queue_free()


func initialize_prefabs(): #TODO factory
	p_choose_card = load("res://Cards/CardTypes/ChooseCard/ChooseCardData.tscn")
	p_do_card = load("res://Cards/CardTypes/DoCard/DoCardData.tscn")
	p_keep_card = load("res://Cards/CardTypes/KeepCard/KeepCardData.tscn")


func initialize_folders():
	var directory = Directory.new()
	
	if not directory.dir_exists("user://Cards/"):
		directory.make_dir_recursive("user://Cards/")
	
	if not directory.dir_exists("user://Decks/"):
		directory.make_dir_recursive("user://Decks/")
	directory.open("user://Decks/")
	directory.list_dir_begin(true, true)
	if directory.get_next() == "":
		load_initial_decks()



func load_initial_decks():
	var deck_prefab = load("res://Cards/Decks/Deck.tscn").instance()
	deck_prefab.initialize_deck()
	load_standard_deck(deck_prefab)
	
	
	deck_prefab = load("res://Cards/Decks/Deck.tscn").instance()
	deck_prefab.initialize_deck()
	load_beer_deck(deck_prefab)





#==== Logic ====#

func load_standard_deck(deck_prefab):
	deck_prefab.s_name = "Standard Deck"
	var card_type_list = []
	
	var choose_card_prefab = p_choose_card.instance()
	var choose_card_prefab_data = [
		[ 	"Enche o copo", 
			"Penalti" ],
			
		[	"Bebe 2 penaltis e manda alguem beber 3 penaltis", 
			"Bebe um penalti e manda alguém beber de penalti" ],
			
		[ 	"Bebe 2 por cada gordo presente", 
			"Bebe 3 por cada anão"],
			
		[ 	"Canta a fuzleira", 
			"Bebe 5"],
			
		[ 	"Manda 1 bongada", 
			"Manda 1 shot de bagaço"],
			
		[ 	"Faz um cacete", 
			"Manda um shot de uma bebida branca"],
			
		[ 	"Canta a fuzleira", 
			"Bebe 5"],
			
		[ 	"Limpa o lixo da mesa", 
			"Manda um penalti"],
			
		[ 	"Faz uma serenata a alguém à tua escolha", 
			"Bebe um penalti"],
			
		[ 	"Obriga o piu a beber mais de 2 minis", 
			"Obriga alguem a mandar o copo de penalti"],
			
		[ 	"Bebe 1", 
			"Bebe 2"],
			
		[ 	"Faz um cacetinho", 
			"Manda um pénalti"],
			
		[ 	"Bebe 1", 
			"Bebe 3 e manda alguém beber 3"]
	]

	for label in choose_card_prefab_data:
		choose_card_prefab.s_option_a = label[0]
		choose_card_prefab.s_option_b = label[1]
		card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
		save_card(choose_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 0, card_type_list)
	card_type_list = []
	
	
	var do_card_prefab = p_do_card.instance()
	var do_card_prefab_data = [
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
	
	for label in do_card_prefab_data:
		do_card_prefab.s_what_to_do = label
		card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
		save_card(do_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 1, card_type_list)
	card_type_list = []
	
	
	var keep_card_prefab = load("res://Cards/CardTypes/KeepCard/KeepCardData.tscn").instance()
	var keep_card_prefab_data = [
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
	
	for label in keep_card_prefab_data:
		keep_card_prefab.s_what_to_do = label
		card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
		save_card(keep_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 2, card_type_list)
	card_type_list = []
	
	save_deck(deck_prefab)

#TODO finish decks
func load_easy_deck():
	pass


func load_hard_deck():
	pass


func load_beer_deck(deck_prefab):
	deck_prefab.s_name = "Beer Deck"
	var card_type_list = []
	
	var choose_card_prefab = p_choose_card.instance()
	var choose_card_prefab_data = [
		[ 	"Vai buscar cucas", 
			"Manda essa merda de penalti" ],
			
		[	"Bebe 3 goles", 
			"Bebe 6 golinhos" ],
			
		[ 	"Bebe 2 por cada gordo presente", 
			"Bebe 3 por cada anão"],
			
		[ 	"Faz um cacete", 
			"Manda um shot de uma bebida branca"],
			
		[ 	"Limpa o lixo da mesa", 
			"Manda um penalti"],
			
		[ 	"Faz uma serenata a alguém à tua escolha", 
			"Bebe um penalti"],
			
		[ 	"Convence o barrado a beber um gole", 
			"Convence o marufas a beber um gole"],
			
		[ 	"Bebe 1", 
			"Bebe 2"],
			
		[ 	"Faz um cacetinho", 
			"Bebe 5 goles"],
			
		[ 	"Bebe 1", 
			"Bebe 3 e manda alguém beber 3"]
	]

	for label in choose_card_prefab_data:
		choose_card_prefab.s_option_a = label[0]
		choose_card_prefab.s_option_b = label[1]
		card_type_list.append([choose_card_prefab.get_card_hash_id(), 1])
		save_card(choose_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 0, card_type_list)
	card_type_list = []
	
	
	var do_card_prefab = p_do_card.instance()
	var do_card_prefab_data = [
		"Bebe 1 gole.",
		"Bebe 2 goles.",
		"Manda meia garrafa.",
		"Puxa um brinde.",
		"Faz uma cascata a começar em ti. Todos os jogadores que tiverem o copo vazio, enchem tudo.",
		"Estas imune às regras do jogo durante um turno. Bebe 3 goles para ativar este efeito.",
		"Bebe 3 e força alguém a beber 3.",
		"Enche o copo e bebe 2 goles.",
		"Se tiveres o copo a menos de metade, bebe de penalti o que falta. Se não, bebe 2 goles.",
		"Manda um shot de rolha.",
		"Todos os homens bebem.",
		"Cria uma regra nova.",
		"Mete uma bebida diferente da que tens na garrafa.",
		"Tu e os 2 jogadores ao teu lado bebem 3 goles.",
		"O último jogador a pôr a mão na mesa manda meia garrafa.",
		"Diz um tema. Toda a gente diz algo relacionado a esse tema, até alguém falhar. Esse jogador bebe 1 gole por cada volta à mesa.",
		"O jogador mais novo e o jogador mais velho bebem 2 goles.",
		"Escolhe uma palavra. Todos os jogadores estão proibídos de a dizer até ao fim do jogo.",
		"Até tirares uma carta do baralho, tens de estar em pé.",
		"Toda a gente conta uma piada seca. Até rodar a mesa, quem se rir tem de beber 3 goles.",
		"Força o jogador com menos bebida na garrafa a mandar uma pescoçada.",
		"Faz um senhor Bob.",
		"És o capitão. Manda beber quem tu quiseres.",
		"Bebe o que quiseres da tua garrafa. Toda a gente tem de fazer o mesmo.",
		"Se o Xias estiver, tens de ser arremessado por ele. Se fores o Xias, lamento, são as regras.",
		"Bebe 2 goles por cada gajo de 014 presente."
	]
	
	for label in do_card_prefab_data:
		do_card_prefab.s_what_to_do = label
		card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
		save_card(do_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 1, card_type_list)
	card_type_list = []
	
	
	var keep_card_prefab = load("res://Cards/CardTypes/KeepCard/KeepCardData.tscn").instance()
	var keep_card_prefab_data = [
		"Bebe tudo o que tens no copo e anula um efeito",
		"Ao guardares a carta, escolhe um parceiro. Sempre que beberes, ele bebe. Ao jogares esta carta, ele bebe 3 goles do copo.",
		"Guarda o numero de goles que acumulares até jogares esta carta. Manda beber esse número de goles (max 10)",
		"Toda a gente troca de copo para a direita.",
		"Quem te mandar fazer algo, também tem de fazer.",
		"Quando alguém rodar um cacete, és chapa dux.",
		"Quando for preciso ir buscar bebidas, escolhe quem vai.",
		"Quando alguém for a casa de banho, mina a bebida dele.",
		"Podes minar a bebida de alguem.",
		"Cancela a vez de jogar de uma pessoa, joga tu com a carta dele.",
		"Podes ativar isto em alguem que tenha um copo vazio, ele é o barista ate ao fim do jogo.",
	]
	
	for label in keep_card_prefab_data:
		keep_card_prefab.s_what_to_do = label
		card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
		save_card(keep_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 2, card_type_list)
	card_type_list = []
	
	save_deck(deck_prefab)
 




#==== Data Persistence ====#


func save_card(card_prefab):
	var card_path = "user://Cards/" + card_prefab.get_card_hash_id()
	var was_successful = false
	var card_save_file = File.new()
	if not card_save_file.file_exists(card_path):
		card_save_file.open(card_path, File.WRITE)
		card_save_file.store_line(to_json(card_prefab.get_card_as_dictionary()))
		was_successful = true
		#print("saved card at ", card_path)
#	else:
		#print("An equal card already exists.")
		
		
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
		#print("deck with same name already exists, overriding")
		deck_save_file.open(deck_path, File.WRITE)
		deck_save_file.store_line(to_json(deck.get_deck_as_dictionary()))
