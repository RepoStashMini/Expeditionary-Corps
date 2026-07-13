//nova code//
//Pointman's riot shield. Fixable with 1 plasteel, crafting recipe for broken shield
/obj/item/shield/riot/pointman
	name = "pointman shield"
	desc = "A shield fit for those that want to sprint headfirst into the unknown. Its heavy, unwieldy nature makes its defensive performance suffer when in the off-hand; \
	wielding will provide best results at the cost of reduced mobility."
	icon_state = "riot"
	icon = 'modular_teotr/Icons/obj/riot.dmi'
//	worn_icon = 'modular_nova/master_files/icons/mob/clothing/back.dmi'
	worn_icon_state = "erisriot"
	lefthand_file = 'modular_teotr/Icons/mob/inhands/items/riot_left.dmi'
	righthand_file = 'modular_teotr/Icons/mob/inhands/items/riot_right.dmi'
	force = 10
	throwforce = 5
	throw_speed = 1
	throw_range = 1
	block_chance = 15
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("slams", "bashes")
	attack_verb_simple = list("slam", "bash")
	transparent = FALSE
	max_integrity = 200
	shield_break_leftover = /obj/item/pointman_broken
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 3, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5)

/obj/item/shield/riot/pointman/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
	force_unwielded=10, force_wielded=20, \
	wield_callback = CALLBACK(src, PROC_REF(shield_wield)), \
	unwield_callback = CALLBACK(src, PROC_REF(shield_unwield)), \
	)


/// handles buffing the shield's defensive ability and nerfing user mobility
/obj/item/shield/riot/pointman/proc/shield_wield()
	item_flags |= SLOWS_WHILE_IN_HAND
	block_chance *= 5 // 15 * 5 = 75
	slowdown = 0.6

/// nerfs the shield's defensive ability, buffs user mobility
/obj/item/shield/riot/pointman/proc/shield_unwield()
	item_flags &= ~SLOWS_WHILE_IN_HAND
	block_chance /= 5
	slowdown = 0

/obj/item/pointman_broken
	name = "broken pointman shield"
	desc = "Enough of it is still intact that you could probably just weld more bits on."
	icon_state = "riot_broken"
//	icon = 'modular_nova/modules/exp_corps/icons/riot.dmi'
	w_class = WEIGHT_CLASS_BULKY

/obj/item/pointman_broken/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/pointman_repair)
	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

//broken shield fixing
/datum/crafting_recipe/pointman_repair
	name = "pointman shield (repaired)"
	result = /obj/item/shield/riot/pointman
	reqs = list(/obj/item/pointman_broken = 1,
				/obj/item/stack/sheet/plasteel = 3,
				/obj/item/stack/sheet/rglass = 3)
	time = 5 SECONDS
	category = CAT_MISC
	tool_behaviors = list(TOOL_WELDER)
