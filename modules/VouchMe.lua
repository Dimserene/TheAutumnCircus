
local vouchers = {
	"spectral_merchant", spectral_merchant = {
		name = "Spectral Merchant",
		text = {
			"{C:spectral}Spectral{} cards appear",
			"in the shop"
		},
		config = {
			extra = 4.8/4,
		},
		pos = { x = 0, y = 0 },
		loc_vars = function(_c, info_queue, card) 
            if not card.fake_card then info_queue[#info_queue+1] = {generate_ui = TheAutumnCircus.func.artcredit, key = 'autumn'} end
			return {vars = {  }} end,
		redeem = function(self, center)
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.spectral_rate = 4*self.config.extra
				return true end }))
		end,
	},
	"spectral_tycoon", spectral_tycoon = {
		name = "Spectral Tycoon",
		text = {
			"{C:spectral}Spectral{} cards appear",
			"{C:attention}#1#X{} more frequently",
			"in the shop"
		},
		config = {
			extra = 9.6/4,
			extra_disp = 2
		},
		pos = { x = 1, y = 0 },
		requires = {'v_thac_spectral_merchant'},
		loc_vars = function(_c, info_queue, card) 
            if not card.fake_card then info_queue[#info_queue+1] = {generate_ui = TheAutumnCircus.func.artcredit, key = 'autumn'} end
			return {vars = { _c.config.extra_disp }} end,
		redeem = function(self, center)
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.spectral_rate = 4*self.config.extra
				return true end }))
		end,
	},
	"stamp_savvy", stamp_savvy = {
		name = "Stamp Savvy",
		text = {
			"{C:attention}Jokers{} can appear","with special {C:attention}stamps{}",
		},
		config = {
		},
		pos = { x = 2, y = 0 },
		loc_vars = function(_c, info_queue, card) 
            if not card.fake_card then info_queue[#info_queue+1] = {generate_ui = TheAutumnCircus.func.artcredit, key = 'autumn'} end
			return {vars = {  }} end,
		redeem = function(self, center)
		end,
		load_check = function()
			return TheAutumnCircus.config.enabled_modules.jokerstamps
		end,
	},
	"stamp_coupon", stamp_coupon = {
		name = "Stamp Coupon",
		text = {
			"{C:attention}Jokers{} with special {C:attention}stamps{}",
			"cost up to {C:money}$2{} less",
		},
		config = {
		},
		pos = { x = 3, y = 0 },
		requires = {'v_thac_stamp_savvy'},
		loc_vars = function(_c, info_queue, card) 
            if not card.fake_card then info_queue[#info_queue+1] = {generate_ui = TheAutumnCircus.func.artcredit, key = 'autumn'} end
			return {vars = {  }} end,
		redeem = function(self, center)
		end,
		load_check = function()
			return TheAutumnCircus.config.enabled_modules.jokerstamps
		end,
	},
	"oddity_merchant", oddity_merchant = {
		name = "Oddity Merchant",
		text = {
			"{C:oddity}Oddities{} appear",
			"{C:attention}#1#X{} more frequently",
			"in the shop"
		},
		config = {
			extra = 9.6/4,
			extra_disp = 2
		},
		pos = { x = 4, y = 0 },
		loc_vars = function(_c, info_queue, card) 
            if not card.fake_card then info_queue[#info_queue+1] = {generate_ui = TheAutumnCircus.func.artcredit, key = 'autumn'} end
			return {vars = { _c.config.extra_disp }} end,
		redeem = function(self, center)
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.oddity_rate = OddityAPI.config.base_shop_rate*self.config.extra
				return true end }))
		end,
		load_check = function()
			return OddityAPI ~= nil
		end,
	},
	"oddity_tycoon", oddity_tycoon = {
		name = "Oddity Tycoon",
		text = {
			"{C:oddity}Oddities{} appear",
			"{C:attention}#1#X{} more frequently",
			"in the shop"
		},
		config = {
			extra = 19.2/4,
			extra_disp = 4
		},
		pos = { x = 5, y = 0 },
		requires = {'v_thac_oddity_merchant'},
		loc_vars = function(_c, info_queue, card) 
            if not card.fake_card then info_queue[#info_queue+1] = {generate_ui = TheAutumnCircus.func.artcredit, key = 'autumn'} end
			return {vars = { _c.config.extra_disp }} end,
		redeem = function(self, center)
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.oddity_rate = OddityAPI.config.base_shop_rate*self.config.extra
				return true end }))
		end,
		load_check = function()
			return OddityAPI ~= nil
		end,
	},
	"wheel_of_wheel_of_fortune", wheel_of_wheel_of_fortune = {
		name = "Wheel of Wheel of Fortune",
		text = {
			"{C:green}#1# in #2#{} chance to create",
			"{C:attention}The Wheel of Fortune{}",
			"when {C:attention}Blind{} is selected",
			"{C:inactive}(Must have room)"
		},
		config = {
			extra = {
				odds = 4
			},
		},
		pos = { x = 6, y = 0 },
		loc_vars = function(self, info_queue, card)
            if not card.fake_card then info_queue[#info_queue+1] = {generate_ui = TheAutumnCircus.func.artcredit, key = 'autumn'} end
			info_queue[#info_queue+1] = G.P_CENTERS['c_wheel_of_fortune']
			return {vars = {
				G.GAME.probabilities.normal,
				card.ability.extra.odds,
			}}
		end,
		redeem = function(self)
			G.GAME.wheel_of_wheel_of_fortune = true
		end,
	},
	"ceaseless_wheel", ceaseless_wheel = {
		name = "Ceaseless Wheel",
		text = {
			"{C:green}#1# in #2#{} chance to create {C:attention}The Wheel of Fortune{}",
			"whenever {C:attention}The Wheel of Fortune{} is used or sold",
			"{C:attention}The Wheel of Fortune{} cards created by this",
			"Voucher or by {C:attention}Wheel of Wheel of Fortune{} have",
			"a {C:green}#1# in #2#{} chance to be {C:dark_edition}Negative{}",
			"{C:inactive}(Must have room if not creating a {C:dark_edition}Negative{C:inactive} card)",
			"{C:inactive}(If a {C:dark_edition}Negative {C:attention}The Wheel of Fortune{C:inactive} is used or sold,",
			"{C:inactive}card creation probability is forced to be {C:green}1 in 4{C:inactive})"
		},
		boxes = { 2, 3, 3 },
		config = {
			extra = {
				odds = 4,
			},
		},
		pos = { x = 7, y = 0 },
		requires = {'v_thac_wheel_of_wheel_of_fortune'},
		loc_vars = function(self, info_queue, card)
            if not card.fake_card then info_queue[#info_queue+1] = {generate_ui = TheAutumnCircus.func.artcredit, key = 'autumn'} end
			info_queue[#info_queue+1] = G.P_CENTERS['v_thac_wheel_of_wheel_of_fortune']
			return {vars = {
				G.GAME.probabilities.normal,
				card.ability.extra.odds,
			}}
		end,
		redeem = function(self)
			G.GAME.ceaseless_wheel = true
		end,
	},
	"plus_four", plus_four = {
		name = "+4",
		text = {
			"{C:mult}+#1#{} Mult",
		},
		config = {
			extra = {
				mult = 4
			},
		},
		pos = { x = 8, y = 0 },
		loc_vars = function(_c, info_queue, card) 
            if not card.fake_card then info_queue[#info_queue+1] = {generate_ui = TheAutumnCircus.func.artcredit, key = 'autumn'} end
			return {vars = { card.ability.extra.mult }}
		end,
		calculate = function(self, card, context)
			if context.joker_main then return {mult = card.ability.extra.mult} end
		end,
	},
	"x_four", x_four = {
		name = "X4",
		text = {
			"{X:mult,C:white}X#1#{} Mult",
		},
		config = {
			extra = {
				Xmult = 4
			}
		},
		pos = { x = 9, y = 0 },
		requires = {'v_thac_plus_four'},
		loc_vars = function(_c, info_queue, card) 
            if not card.fake_card then info_queue[#info_queue+1] = {generate_ui = TheAutumnCircus.func.artcredit, key = 'autumn'} end
			return {vars = { card.ability.extra.Xmult }}
		end,
		calculate = function(self, card, context)
			if context.joker_main then return {xmult = card.ability.extra.Xmult} end
		end,
	},
}
SMODS.Atlas{
	key = "VouchMe",
	path = "VouchMe.png",
	px = 71,
	py = 95,
}

--vouchers
for _, k in ipairs(vouchers) do
	local v = vouchers[k]
	TheAutumnCircus.data.buffer_insert("Vouchers", v, {key = k, atlas = "VouchMe"})
end