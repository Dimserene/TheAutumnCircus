local config = {
	enabled_modules = {
		retrievehands = true,
		deckthebalatro = true,
		suitedunimpresseddispleasedoverlord = false,
		dankranks = false, --not real
		skinmeadeck = true,
		enhancable = true,
		vouchme = true,
		moreconsumables = true,
		basicoddities = true,
		blindtoallbutthevideo = true,
		tagimit = true, --soon(tm)
		jokerstamps = true,
		lookslikethejokers = true,
		editiontomeetya = true,
	},
	enabled_jokers = {
		wacky_joker = true,
		crass_joker = true,
		bracket = true,
		court_joker = true,
		regal_joker = true,
		royal = true,
		gift_from_the_void = true,
		lord_of_the_meek = true,
		mirage_joker = true,
		confluence = true,
		placeholder_joker = true,
	},
	enabled_consumables = {
		--tarot
		universe = true,
		void = true,
		happy_squirrel = true,
		artist = true,
		veteran = true,
		juggler = false,
		drunkard = true,
		joker = false,
		page_of_cups = false,
		page_of_wands = false,
		page_of_coins = false,
		page_of_swords = false,
		
		--planets
		comet = true,
		meteor = true,
		satellite = true,
		moon = true,
		station = true,
		dysnomia = true,
		planet_s = true,
		planet_h = true,
		planet_c = true,
		planet_d = true,
		nice_planet = true,
		blaze_planet = true,
		twice_nice_planet = true,
		skeet_planet = true,
		little_dog_planet = true,
		big_dog_planet = true,
		little_cat_planet = true,
		big_cat_planet = true,
		blaze_house_planet = true,
		flushblaze_planet = true,
		spectrumblaze_planet = false,
		castle_flush_planet = true,
		castle_spectrum_planet = false,
		skeet_flush_planet = true,
		skeet_spectrum_planet = false,
		blaze_five_planet = true,
		flushblaze_house_planet = true,
		spectrumblaze_house_planet = false,
		flushblaze_five_planet = true,
		spectrumblaze_five_planet = false,
		castle_stone_planet = true,
		castle_gold_planet = true,
		castle_steel_planet = true,
		castle_glass_planet = true,
		
		--spectrals
		chance = true,
		offering = true,
		tribute = true,
		sacrifice = true,
		scry = true,
		phantom = true,
		-- following require jokerstamps and respective stamp if applicable
			mischief = true,
			comedy = true,
			tragedy = true,
			whimsy = true,
			entropy = true,
			wonder = true,
			macabre = true,
			duplicity = true,
		
		--oddities
		-- following requires oddityapi
		one_jollar = false,
		two_jollar = false,
		five_jollar = false,
		ten_jollar = false,
		twenty_jollar = false,
		pot_of_joker = false,
		green_chip = false,
		yellow_chip = false,
		red_blue_chip = false,
		purple_chip = false,
		power_chip = false,
		silica_packet = false,
		jimbobread_man = false,
		jimbobread_man_half = false,
		narwhal_horn = false,
		cultist_potion = false,
		fire_potion = false,
		snecko_potion = false,
		energy_potion = false,
		vote_sticker = false,
		cpu_memory = false,
		estradiol = false,
		faded_voucher = false,
	},
	enabled_vouchers = {
		spectral_merchant = true,
		spectral_tycoon = true,
		-- following requires jokerstamps
		stamp_savvy = true,
		stamp_coupon = true,
		-- following requires oddityapi
		oddity_merchant = true,
		oddity_tycoon = true,
	},
	enabled_seals = {
	},
	enabled_stamps = {
		jimbo = true,
		todd = true,
		steven = true,
		chaos = true,
		andy = true,
		mr_bones = true,
		vampire = false,
		sock_and_buskin = true,
		hiker = false,
		gros_michel = false,
	},
	enabled_enhancements = {
		loop = false,
		grass = true,
		dirt = true,
		bounty = true,
	},
	enabled_editions = {
		gilded = true,
	},
	enabled_decks = {
		collectors_deck = true,
		arcane_deck = true,
		alpha_deck = true,
		beta_deck = true,
		omega_deck = true,
	},
	enabled_suits = {
		Cups = false,
		Wands = false,
		Coins = false,
		Swords = false,
		Light = false,
		Mind = false,
		Rage = false,
		Time = false,
		Breath = false,
		Life = false,
		Void = false,
		Heart = false,
		Hope = false,
		Space = false,
		Blood = false,
		Doom = false,
		Pickaxes = false,
	},
	enabled_deckskins = {
		diamond_pickaxe = false,
	},
	enabled_blinds = {
		fehu = true,
		uruz = true,
		thorn = true,
		ansuz = true,
		raido = true,
		kaun = true,
		gyfu = true,
		wynn = true,
		hagalaz = true,
		naudiz = true,
		isaz = true,
		jera = true,
		eihaz = true,
		pertho = true,
		algiz = true,
		sowilo = true,
		tiwaz = true,
		berkanan = true,
		ehwaz = true,
		mannaz = true,
		laguz = true,
		ingwaz = true,
		dagaz = true,
		othala = true,
	},
	enabled_hands = {
		nice = true,
		blaze = true,
		twice_nice = true,
		skeet = true,
		little_dog = true,
		big_dog = true,
		little_cat = true,
		big_cat = true,
		castle = true,
		blaze_house = true,
		flushblaze = true,
		spectrumblaze = false,
		castle_flush = true,
		castle_spectrum = false,
		skeet_flush = true,
		skeet_spectrum = false,
		blaze_five = true,
		flushblaze_house = true,
		spectrumblaze_house = false,
		flushblaze_five = true,
		spectrumblaze_five = false,
		castle_stone = true,
		castle_gold = true,
		castle_steel = true,
		castle_glass = true,
	},
	enabled_tags = {
		gilded = true,
	},
	mechanics = {
		minor_arcana_flush_effects = true,
	},
	starting_deck = {
		allowed_suits = {
			['Hearts'] = true,
			['Clubs'] = true,
			['Diamonds'] = true,
			['Spades'] = true,
			['thac_Cups'] = false,
			['thac_Wands'] = false,
			['thac_Coins'] = false,
			['thac_Swords'] = false,
			['thac_Light'] = false,
			['thac_Mind'] = false,
			['thac_Rage'] = false,
			['thac_Time'] = false,
			['thac_Breath'] = false,
			['thac_Life'] = false,
			['thac_Void'] = false,
			['thac_Heart'] = false,
			['thac_Hope'] = false,
			['thac_Space'] = false,
			['thac_Blood'] = false,
			['thac_Doom'] = false,
			['thac_Pickaxes'] = false,
		},
		allowed_ranks = {
			['0'] = false,
			['1'] = false,
			['2'] = true,
			['3'] = true,
			['4'] = true,
			['5'] = true,
			['6'] = true,
			['7'] = true,
			['8'] = true,
			['9'] = true,
			['10'] = true,
			['Jack'] = true,
			['Queen'] = true,
			['King'] = true,
			['Ace'] = true,
			['11'] = false,
			['12'] = false,
			['13'] = false,
			['14'] = false,
			['15'] = false,
			['16'] = false,
			['17'] = false,
			['18'] = false,
			['19'] = false,
			['20'] = false,
			['Cavalier'] = false,
			['Bishop'] = false,
			['Rook'] = false,
			['21'] = false,
			['22'] = false,
			['23'] = false,
			['24'] = false,
			['25'] = false,
			['26'] = false,
			['27'] = false,
			['28'] = false,
			['29'] = false,
			['30'] = false,
			['Viscount'] = false,
			['Marquess'] = false,
			['Duke'] = false,
			['Thorn'] = false,
			['Oracle'] = false,
		},
	},
	
	
	testing_kit = false,
	test_hands = false,
}

return config