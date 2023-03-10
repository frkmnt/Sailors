extends Node

#==== Prefabs ====#
var p_deck_prefab
var p_choose_card
var p_do_card
var p_keep_card




#==== Bootstrap ====#

func initialize():
	initialize_prefabs()
	initialize_folders()
	queue_free()


func initialize_prefabs(): #TODO factory
	p_deck_prefab = load("res://Models/Decks/Deck.tscn")
	p_choose_card = load("res://Models/Cards/ChooseCard/ChooseCardData.tscn")
	p_do_card = load("res://Models/Cards/DoCard/DoCardData.tscn")
	p_keep_card = load("res://Models/Cards/KeepCard/KeepCardData.tscn")


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
	load_standard_deck()
	load_beer_deck()
	load_new_years_special_deck()





#==== Logic ====#

func load_standard_deck():
	var deck_prefab = p_deck_prefab.instance()
	deck_prefab.initialize_deck()
	deck_prefab.s_name = "Standard Deck"
	var card_type_list = []
	
	var choose_card_prefab = p_choose_card.instance()
	var choose_card_prefab_data = [
		[ 	"Fill your glass", 
			"Chug your drink" ],
			
		[	"Chug a drink and force someone to chug 2 drinks", 
			"You and another player both drink 3 times." ],
			
		[ 	"Roll a joint", 
			"Take a shot"],
			
		[ 	"Clean the playing area", 
			"Chug your drink"],
			
		[ 	"Serenade someone", 
			"Chug your drink"],
			
		[ 	"Drink once", 
			"Drink twice"],
			
		[ 	"Drink once", 
			"You and another player drink 3 times"]
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
		"Drink once.",
		"Drink twice.",
		"Finish your drink.",
		"Start a waterfall. All players with an empty glass refill their drinks.",
		"You are immune to the game's rules for the rest of the round. Drink 3 times to activate this effect.",
		"Drink 3 times and force someone to drink 3 times.",
		"Fill your cup and drink twice.",
		"If you have less than half your drink, chug it and refill. Otherwise, drink twice.",
		"Chug your drink.",
		"Create a new rule.",
		"Mix a new drink into your current one.",
		"You and the players next to you drink 3 times.",
		"The last player to place their hand on the table chugs their drink.",
		"Choose a topic. Each player has a turn saying a word related to it. If you fail, drink once for each round.",
		"The youngest and oldest players drink 3 times.",
		"Choose a word. All players are forbidden from saying it, under the penalty of drinking once each time.",
		"Until your next turn, stand up.",
		"Everyone tells a joke. Any players that laugh drink once.",
		"Force the player with the emptiest glass to finish the drink.",
		"You're the captain. Force any players to drink as much as you want.",
		"Drink as much as you want from your glass. Everyone does the same.",
		"Everyone chugs their drink.",
		"Everytime a sailor jumps ship, all the remaining sailors must stand and salute the fallen soldier.",
		"Sing a drinking song / sea shanty.",
	]
	
	for label in do_card_prefab_data:
		do_card_prefab.s_what_to_do = label
		card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
		save_card(do_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 1, card_type_list)
	card_type_list = []
	
	
	var keep_card_prefab = load("res://Models/Cards/KeepCard/KeepCardData.tscn").instance()
	var keep_card_prefab_data = [
		"Finish your glass and cancel an effect.",
		"Choose a partner when keeping this card. Everytime you drink, the player drinks the same amount.",
		"If you chug your drink, force a player to chug 2 drinks.",
		"Save the number of sips you take (max 10). When you play this card, force a player to drink that many times.",
		"If someone forces you to do something, that player does it as well.",
		"When anyone needs a refill, choose who goes in their place.",
		"When someone goes to the bathroom, spike their drink with a new drink.",
		"Spike a player's drink with a new drink.",
		"Cancel someone's turn. You use their card.",
		"Activate this when someone needs a refill. Choose a bartender to create any drink freely for that player. ",
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


func load_new_years_special_deck():
	var deck_prefab = p_deck_prefab.instance()
	deck_prefab.initialize_deck()
	deck_prefab.s_name = "Especial Ano Novo"
	var card_type_list = []
	
	var choose_card_prefab = p_choose_card.instance()
	var choose_card_prefab_data = [
		
		[	"Drink 3 times", 
			"Take 6 sips" ],
			
		[ 	"Roll a joint", 
			"Take a shot"],
			
		[ 	"Clean the playing area", 
			"Chug your drink"],
			
		[ 	"Drink once", 
			"Drink twice"],
			
		[ 	"Drink once", 
			"You and another player drink 3 times"],
			
		[ 	"Drink a shot", 
			"Chug half your drink"],
			
		[ 	"Choose a player. You both chug your drinks.", 
			"Drink 4 times."],
			
		[ 	"Fill your glass with booze.", 
			"Fill your glass with juice."]
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
		"Enche o copo da casa com branca.",
		"Por cada 10 minutos que faltarem/passarem da meia noite, bebe 1 gole.",
		"Conta o número de bebidas diferentes em jogo. Toda a gente bebe esse número de goles.",
		"Enrola uma blunt.",
		"Se ainda não passar da meia noite, a cada minuto tens de dizer quanto tempo falta para a meia noite. Se falhares, bebes.",
		"Bebe 1 gole.",
		"Bebe 2 goles.",
		"Puxa um brinde.",
		"Faz uma cascata a começar em ti.",
		"Estas imune às regras do jogo durante um turno. Bebe 3 goles para ativar este efeito.",
		"Bebe 3 e força alguém a beber 3.",
		"Enche o copo e bebe 2 goles.",
		"Se tiveres o copo a menos de metade, bebe de penalti o que falta. Se não, bebe 2 goles.",
		"Manda um shot de rolha.",
		"Cria uma regra nova.",
		"Mete uma bebida diferente da que tens no copo.",
		"Tu e os 2 jogadores ao teu lado bebem 3 goles.",
		"O último jogador a pôr a mão na mesa manda metade da bebida.",
		"Diz um tema. Toda a gente diz algo relacionado a esse tema, até alguém falhar. Esse jogador bebe 1 gole por cada volta à mesa.",
		"O jogador mais novo e o jogador mais velho bebem 2 goles.",
		"Escolhe uma palavra. Todos os jogadores estão proibídos de a dizer até ao fim do jogo.",
		"Até tirares uma carta do baralho, tens de estar em pé.",
		"Toda a gente conta uma piada seca. Até rodar a mesa, quem se rir tem de beber 3 goles.",
		"Força o jogador com menos bebida na garrafa a mandar uma pescoçada.",
		"Faz um senhor Bob.",
		"És o capitão. Manda beber quem tu quiseres.",
		"Bebe o que quiseres da tua garrafa. Toda a gente tem de fazer o mesmo.",
		"Bebe 2 goles por cada gajo de 014 presente.",
		"Bebe 2 goles por cada gajo de 015 presente."
	]
	
	for label in do_card_prefab_data:
		do_card_prefab.s_what_to_do = label
		card_type_list.append([do_card_prefab.get_card_hash_id(), 1])
		save_card(do_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 1, card_type_list)
	card_type_list = []
	
	
	var keep_card_prefab = load("res://Models/Cards/KeepCard/KeepCardData.tscn").instance()
	var keep_card_prefab_data = [
		"Bebe tudo o que tens no copo e anula um efeito",
		"Ao guardares a carta, escolhe um parceiro. Sempre que beberes, ele bebe. Ao jogares esta carta, bebem ambos 3 goles do copo.",
		"Guarda o numero de goles que acumulares até jogares esta carta. Manda beber esse número de goles (max 10)",
		"Quem te mandar fazer algo, também tem de fazer.",
		"Quando alguém rodar um cacete, és chapa dux.",
		"Quando for preciso ir buscar bebidas, escolhe quem vai.",
		"Quando alguém for a casa de banho, mina a bebida dele.",
		"Podes minar a bebida de alguem.",
		"Cancela a vez de jogar de uma pessoa, joga tu com a carta dele.",
		"Podes ativar isto em alguem que tenha um copo vazio, ele é o barista até à meia noite.",
		"Anula o efeito de alguém. Bebe um shot."
	]
	
	for label in keep_card_prefab_data:
		keep_card_prefab.s_what_to_do = label
		card_type_list.append([keep_card_prefab.get_card_hash_id(), 1])
		save_card(keep_card_prefab)
	
	deck_prefab = add_type_cards_to_deck(deck_prefab, 2, card_type_list)
	card_type_list = []
	
	save_deck(deck_prefab)


func load_beer_deck():
	var deck_prefab = p_deck_prefab.instance()
	deck_prefab.initialize_deck()
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
	
	
	var keep_card_prefab = load("res://Models/Cards/KeepCard/KeepCardData.tscn").instance()
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
