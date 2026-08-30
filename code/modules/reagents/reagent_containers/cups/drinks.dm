////////////////////////////////////////////////////////////////////////////////
/// Drinks.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/cup/glass
	name = "drink"
	desc = "yummy"
	icon = 'icons/obj/drinks/drinks.dmi'
	icon_state = "glass_empty"
	abstract_type = /obj/item/reagent_containers/cup/glass
	possible_transfer_amounts = list(5,10,15,20,25,30,50)
	resistance_flags = NONE

	isGlass = TRUE
	attack_verb_continuous = list("smashes", "bashes")
	attack_verb_simple = list("smash", "bash")

/obj/item/reagent_containers/cup/glass/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum, do_splash = TRUE)
	. = ..()
	if(!.) //if the bottle wasn't caught
		var/mob/thrower = throwingdatum?.get_thrower()
		if(!istype(thrower))
			return
		smash(hit_atom, thrower, throwingdatum)

/obj/item/reagent_containers/cup/glass/proc/smash(atom/target, mob/thrower, datum/thrownthing/throwingdatum, break_top = FALSE)
	if(!isGlass)
		return
	if(QDELING(src) || !target) //Invalid loc
		return
	if(bartender_check(target, thrower) && throwingdatum)
		return
	splash_reagents(QDELETED(target) ? target.drop_location() : target, thrower || throwingdatum?.get_thrower(), allow_closed_splash = TRUE)
	var/obj/item/broken_bottle/B = new (loc)
	B.mimic_broken(src, target, break_top)
	qdel(src)

/obj/item/reagent_containers/cup/glass/bullet_act(obj/projectile/proj)
	. = ..()
	if(QDELETED(src))
		return
	if(proj.damage > 0 && proj.damage_type == BRUTE)
		var/atom/T = get_turf(src)
		smash(T)


/obj/item/reagent_containers/cup/glass/trophy
	name = "pewter cup"
	desc = "Everyone gets a trophy."
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "pewter_cup"
	w_class = WEIGHT_CLASS_TINY
	force = 1
	throwforce = 1
	amount_per_transfer_from_this = 5
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT)
	has_variable_transfer_amount = FALSE
	volume = 5
	obj_flags = CONDUCTS_ELECTRICITY
	resistance_flags = FIRE_PROOF
	isGlass = FALSE

/obj/item/reagent_containers/cup/glass/trophy/gold_cup
	name = "gold cup"
	desc = "You're winner!"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "golden_cup"
	inhand_icon_state = "golden_cup"
	w_class = WEIGHT_CLASS_BULKY
	force = 14
	throwforce = 10
	amount_per_transfer_from_this = 20
	custom_materials = list(/datum/material/gold=HALF_SHEET_MATERIAL_AMOUNT)
	volume = 150

/obj/item/reagent_containers/cup/glass/trophy/gold_cup/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item) //closed handles

/obj/item/reagent_containers/cup/glass/trophy/silver_cup
	name = "silver cup"
	desc = "Best loser!"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "silver_cup"
	w_class = WEIGHT_CLASS_NORMAL
	force = 10
	throwforce = 8
	amount_per_transfer_from_this = 15
	custom_materials = list(/datum/material/silver=SMALL_MATERIAL_AMOUNT*8)
	volume = 100

/obj/item/reagent_containers/cup/glass/trophy/silver_cup/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item) //closed handle

/obj/item/reagent_containers/cup/glass/trophy/bronze_cup
	name = "bronze cup"
	desc = "At least you ranked!"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "bronze_cup"
	w_class = WEIGHT_CLASS_SMALL
	force = 5
	throwforce = 4
	amount_per_transfer_from_this = 10
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT * 4)
	volume = 25

///////////////////////////////////////////////Drinks
//Notes by Darem: Drinks are simply containers that start preloaded. Unlike condiments, the contents can be ingested directly
// rather then having to add it to something else first. They should only contain liquids. They have a default container size of 50.
// Formatting is the same as food.

/obj/item/reagent_containers/cup/glass/coffee
	name = "robust coffee"
	desc = "Careful, the beverage you're about to enjoy is extremely hot."
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "coffee"
	base_icon_state = "coffee"
	list_reagents = list(/datum/reagent/consumable/coffee = 30)
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	drink_type = BREAKFAST

	/// Is our lid currently removed?
	var/lid_open = FALSE

/obj/item/reagent_containers/cup/glass/coffee/no_lid
	icon_state = "coffee_empty"
	list_reagents = null
	lid_open = TRUE

/obj/item/reagent_containers/cup/glass/coffee/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to toggle cup lid.")
	return

/obj/item/reagent_containers/cup/glass/coffee/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "[lid_open ? "Add" : "Remove"] Lid"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/reagent_containers/cup/glass/coffee/click_alt(mob/user)
	lid_open = !lid_open
	update_icon_state()
	return CLICK_ACTION_SUCCESS

/obj/item/reagent_containers/cup/glass/coffee/update_icon_state()
	if(lid_open)
		icon_state = reagents.total_volume ? "[base_icon_state]_full" : "[base_icon_state]_empty"
	else
		icon_state = base_icon_state
	return ..()

/obj/item/reagent_containers/cup/glass/ice
	name = "ice cup"
	desc = "Careful, cold ice, do not chew."
	custom_price = PAYCHECK_LOWER * 0.6
	icon_state = "icecup"
	list_reagents = list(/datum/reagent/consumable/ice = 30)
	isGlass = FALSE

/obj/item/reagent_containers/cup/glass/ice/prison
	name = "dirty ice cup"
	desc = "Either Nanotrasen's water supply is contaminated, or this machine actually vends lemon, chocolate, and cherry snow cones."
	list_reagents = list(/datum/reagent/consumable/ice = 25, /datum/reagent/consumable/liquidgibs = 5)

/obj/item/reagent_containers/cup/glass/mug // parent type is literally just so empty mug sprites are a thing
	name = "mug"
	desc = "A drink served in a classy mug."
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "coffeecup"
	inhand_icon_state = "coffee"

	fill_icon_thresholds = list(30, 40, 50)
	fill_icon_state = "coffeecup"
/*
/obj/item/reagent_containers/cup/glass/mug/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item)

/obj/item/reagent_containers/cup/glass/mug/update_icon_state()
	icon_state = "[base_icon_state][reagents.total_volume ? null : "_empty"]"
	return ..()
*/
/obj/item/reagent_containers/cup/glass/mug/tea
	name = "Duke Purple tea"
	desc = "An insult to Duke Purple is an insult to the Space Queen! Any proper gentleman will fight you, if you sully this tea."
	icon_state = "coffeecup"
	list_reagents = list(/datum/reagent/consumable/tea = 30)

/obj/item/reagent_containers/cup/glass/mug/coco
	name = "Dutch hot coco"
	desc = "Made in Space South America."
	icon_state = "coffeecup"
	list_reagents = list(/datum/reagent/consumable/hot_coco = 15, /datum/reagent/consumable/sugar = 5)
	drink_type = SUGAR
	resistance_flags = FREEZE_PROOF
	custom_price = PAYCHECK_CREW * 1.2

/obj/item/reagent_containers/cup/glass/mug/nanotrasen
	name = "\improper Nanotrasen mug"
	desc = "A mug to display your corporate pride."
	icon_state = "coffeecup_NT"

/obj/item/reagent_containers/cup/glass/mug/nanotrasen/Initialize(mapload)
	. = ..()
	if(prob(10))
		name = "\improper Old Nanotrasen mug"
		desc += "This is an old red mug with the Nanotrasen logo before the rebranding. Very rare!"
		icon_state = "coffeecup_NT_old"

/obj/item/reagent_containers/cup/glass/mug/nanotrasen_old
	name = "\improper Old Nanotrasen mug"
	desc = "This is an old red mug with the Nanotrasen logo before the rebranding. Very rare!"
	icon_state = "coffeecup_NT_old"

/obj/item/reagent_containers/cup/glass/mug/black
	name = "black coffee cup"
	desc = "A sleek black coffee cup."
	icon_state = "coffeecup_black"

/obj/item/reagent_containers/cup/glass/mug/green
	name = "green coffee cup"
	desc = "A pale green and pink coffee cup."
	icon_state = "coffeecup_green"

/obj/item/reagent_containers/cup/glass/mug/heart
	name = "heart coffee cup"
	desc = "A white coffee cup, it prominently features a red heart."
	icon_state = "coffeecup_heart"

/obj/item/reagent_containers/cup/glass/mug/scg
	name = "\improper SCG coffee cup"
	desc = "A blue coffee cup emblazoned with the crest of the Sol Central Government."
	icon_state = "coffeecup_SCG"

/obj/item/reagent_containers/cup/glass/mug/corp
	name = "\improper EXO coffee cup"
	desc = "A tasteful coffee cup in Expeditionary Corps Organisation corporate colours."
	icon_state = "coffeecup_corp"

/obj/item/reagent_containers/cup/glass/mug/one
	name = "#1 coffee cup"
	desc = "A white coffee cup, prominently featuring a #1."
	icon_state = "coffeecup_one"

/obj/item/reagent_containers/cup/glass/mug/punitelli
	name = "#1 monkey coffee cup"
	desc = "A white coffee cup, prominently featuring a \"#1 monkey\" decal."
	icon_state = "coffeecup_punitelli"

/obj/item/reagent_containers/cup/glass/mug/punitelli
	name = "#1 monkey coffee cup"
	desc = "A white coffee cup, prominently featuring a \"#1 monkey\" decal."
	icon_state = "coffeecup_punitelli"

/obj/item/reagent_containers/cup/glass/mug/rainbow
	name = "rainbow coffee cup"
	desc = "A rainbow coffee cup. The colors are almost as blinding as a welder."
	icon_state = "coffeecup_rainbow"

/obj/item/reagent_containers/cup/glass/mug/metal
	name = "metal coffee cup"
	desc = "A metal coffee cup. You're not sure which metal."
	icon_state = "coffeecup_metal"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT)

/obj/item/reagent_containers/cup/glass/mug/stg
	name = "\improper ICCG coffee cup"
	desc = "A coffee cup adorned with the flag of the Gilgamesh Colonial Confederation, for when you need some espionage charges to go with your morning coffee."
	icon_state = "coffeecup_STC"

/obj/item/reagent_containers/cup/glass/mug/pawn
	name = "pawn coffee cup"
	desc = "A black coffee cup adorned with the image of a red chess pawn."
	icon_state = "coffeecup_pawn"

/obj/item/reagent_containers/cup/glass/mug/diona
	name = "diona nymph coffee cup"
	desc = "A green coffee cup featuring the image of a diona nymph."
	icon_state = "coffeecup_diona"

/obj/item/reagent_containers/cup/glass/mug/dais
	name = "\improper DAIS coffee cup"
	desc = "A coffee cup imprinted with the stylish logo of Deimos Advanced Information Systems."
	icon_state = "coffeecup_dais"

/obj/item/reagent_containers/cup/glass/coffee_cup
	name = "coffee cup"
	desc = "A heat-formed plastic coffee cup. Can theoretically be used for other hot drinks, if you're feeling adventurous."
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "coffee_cup_e"
	base_icon_state = "coffee_cup"
	possible_transfer_amounts = list(10)
	volume = 30
	isGlass = FALSE

/obj/item/reagent_containers/cup/glass/coffee_cup/update_icon_state()
	icon_state = reagents.total_volume ? base_icon_state : "[base_icon_state]_e"
	return ..()

/obj/item/reagent_containers/cup/glass/dry_ramen
	name = "cup ramen"
	desc = "Just add 5ml of water, self heats! A taste that reminds you of your school years. Now new with salty flavour!"
	icon_state = "ramen"
	list_reagents = list(/datum/reagent/consumable/dry_ramen = 15, /datum/reagent/consumable/salt = 3)
	drink_type = GRAIN
	isGlass = FALSE
	custom_price = PAYCHECK_CREW * 0.9

/obj/item/reagent_containers/cup/glass/waterbottle
	name = "bottle of water"
	desc = "A bottle of water filled at an old Earth bottling facility."
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "smallbottle"
	inhand_icon_state = null
	list_reagents = list(/datum/reagent/water = 49.5, /datum/reagent/fluorine = 0.5)//see desc, don't think about it too hard
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	volume = 50
	amount_per_transfer_from_this = 10
	fill_icon_thresholds = list(0, 10, 25, 50, 75, 80, 90)
	isGlass = FALSE
	// The 2 bottles have separate cap overlay icons because if the bottle falls over while bottle flipping the cap stays fucked on the moved overlay
	var/cap_icon = 'icons/obj/drinks/drink_effects.dmi'
	var/cap_icon_state = "bottle_cap_small"
	var/start_capped = TRUE
	var/cap_lost = FALSE
	var/mutable_appearance/cap_overlay
	var/flip_chance = 10
	custom_price = PAYCHECK_LOWER * 0.8
	reagent_container_liquid_sound = SFX_PLASTIC_BOTTLE_LIQUID_SLOSH

/obj/item/reagent_containers/cup/glass/waterbottle/Initialize(mapload)
	cap_overlay = mutable_appearance(cap_icon, cap_icon_state)
	. = ..()
	if(start_capped)
		// this is not done via initial_reagent_flags because it represents state
		update_container_flags(SEALED_CONTAINER | TRANSPARENT)
		update_appearance()

/obj/item/reagent_containers/cup/glass/waterbottle/update_overlays()
	. = ..()
	if(!is_open_container())
		. += cap_overlay

/obj/item/reagent_containers/cup/glass/waterbottle/examine(mob/user)
	. = ..()
	if(cap_lost)
		. += span_notice("The cap seems to be missing.")
	else if(!is_open_container())
		. += span_notice("The cap is firmly on to prevent spilling. Alt-click to remove the cap.")
	else
		. += span_notice("The cap has been taken off. Alt-click to put a cap on.")

/obj/item/reagent_containers/cup/glass/waterbottle/click_alt(mob/user)
	if(cap_lost)
		to_chat(user, span_warning("The cap seems to be missing! Where did it go?"))
		return CLICK_ACTION_BLOCKING

	var/fumbled = HAS_TRAIT(user, TRAIT_CLUMSY) && prob(5)
	if(!is_open_container() || fumbled)
		reset_container_flags()
		animate(src, transform = null, time = 2, loop = 0)
		if(fumbled)
			to_chat(user, span_warning("You fumble with [src]'s cap! The cap falls onto the ground and simply vanishes. Where the hell did it go?"))
			cap_lost = TRUE
		else
			to_chat(user, span_notice("You remove the cap from [src]."))
			playsound(loc, 'sound/items/handling/reagent_containers/plastic_bottle/bottle_cap_open.ogg', 50, TRUE)
	else
		update_container_flags(SEALED_CONTAINER | TRANSPARENT)
		to_chat(user, span_notice("You put the cap on [src]."))
		playsound(loc, 'sound/items/handling/reagent_containers/plastic_bottle/bottle_cap_close.ogg', 50, TRUE)
	update_appearance()
	return CLICK_ACTION_SUCCESS

// heehoo bottle flipping
/obj/item/reagent_containers/cup/glass/waterbottle/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(QDELETED(src))
		return
	if(is_open_container() || !reagents.total_volume)
		return
	if(prob(flip_chance)) // landed upright
		src.visible_message(span_notice("[src] lands upright!"))
		var/mob/living/thrower = throwingdatum?.get_thrower()
		if(istype(thrower))
			thrower.add_mood_event("bottle_flip", /datum/mood_event/bottle_flip)
	else // landed on its side
		animate(src, transform = matrix(prob(50)? 90 : -90, MATRIX_ROTATE), time = 3, loop = 0)

/obj/item/reagent_containers/cup/glass/waterbottle/pickup(mob/user)
	. = ..()
	animate(src, transform = null, time = 1, loop = 0)

/obj/item/reagent_containers/cup/glass/waterbottle/empty
	list_reagents = list()
	start_capped = FALSE

/obj/item/reagent_containers/cup/glass/waterbottle/large
	desc = "A fresh commercial-sized bottle of water."
	icon_state = "largebottle"
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3)
	list_reagents = list(/datum/reagent/water = 100)
	volume = 100
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100)
	cap_icon_state = "bottle_cap"

/obj/item/reagent_containers/cup/glass/waterbottle/large/empty
	list_reagents = list()
	start_capped = FALSE

// Admin spawn
/obj/item/reagent_containers/cup/glass/waterbottle/relic
	name = "mysterious bottle"
	desc = "A bottle quite similar to a water bottle, but with some words scribbled on with a marker. It seems to be radiating some kind of energy."
	flip_chance = 100 // FLIPP

/obj/item/reagent_containers/cup/glass/waterbottle/relic/Initialize(mapload)
	var/reagent_id = get_random_reagent_id()
	var/datum/reagent/random_reagent = new reagent_id
	list_reagents = list(random_reagent.type = 50)
	. = ..()
	desc += span_notice("The writing reads '[random_reagent.name]'.")
	update_appearance()


/obj/item/reagent_containers/cup/glass/sillycup
	name = "paper cup"
	desc = "A paper water cup."
	icon_state = "water_cup_e"
	possible_transfer_amounts = list(10)
	volume = 10
	isGlass = FALSE
	custom_materials = list(/datum/material/paper = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/reagent_containers/cup/glass/sillycup/update_icon_state()
	icon_state = reagents.total_volume ? "water_cup" : "water_cup_e"
	return ..()

/obj/item/reagent_containers/cup/glass/bottle/juice/smallcarton
	name = "small carton"
	desc = "A small carton, intended for holding drinks."
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "juicebox"
	volume = 15
	drink_type = NONE
	custom_materials = list(/datum/material/cardboard = SHEET_MATERIAL_AMOUNT)

/obj/item/reagent_containers/cup/glass/bottle/juice/smallcarton/Initialize(mapload, vol)
	. = ..()
	AddComponent( \
		/datum/component/takes_reagent_appearance, \
		on_icon_changed = CALLBACK(src, PROC_REF(on_cup_change)), \
		on_icon_reset = CALLBACK(src, PROC_REF(on_cup_reset)), \
		base_container_type = /obj/item/reagent_containers/cup/glass/bottle/juice/smallcarton, \
	)

/obj/item/reagent_containers/cup/glass/bottle/juice/smallcarton/smash(atom/target, mob/thrower, datum/thrownthing/throwingdatum, break_top)
	if(bartender_check(target, thrower) && throwingdatum)
		return
	splash_reagents(QDELETED(target) ? target.drop_location() : target, thrower || throwingdatum?.get_thrower(), allow_closed_splash = TRUE)
	var/obj/item/broken_bottle/bottle_shard = new(drop_location())
	bottle_shard.mimic_broken(src, target)
	qdel(src)

/obj/item/reagent_containers/cup/glass/colocup
	name = "colo cup"
	desc = "A cheap, mass produced style of cup, typically used at parties. They never seem to come out red, for some reason..."
	icon = 'icons/obj/drinks/colo.dmi'
	icon_state = "colocup"
	inhand_icon_state = "colocup"
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)
	possible_transfer_amounts = list(5, 10, 15, 20)
	volume = 20
	amount_per_transfer_from_this = 5
	isGlass = FALSE
	/// Allows the lean sprite to display upon crafting
	var/random_sprite = TRUE

/obj/item/reagent_containers/cup/glass/colocup/Initialize(mapload)
	. = ..()
	pixel_x = rand(-4,4)
	pixel_y = rand(-4,4)
	if(!random_sprite)
		return
	icon_state = "colocup[rand(0, 6)]"
	if(icon_state == "colocup6")
		desc = "A cheap, mass produced style of cup, typically used at parties. Woah, this one is in red! What the hell?"

/obj/item/reagent_containers/cup/glass/colocup/lean
	name = "lean"
	desc = "A cup of that purple drank, the stuff that makes you go WHEEZY BABY."
	icon_state = "lean"
	list_reagents = list(/datum/reagent/consumable/lean = 20)
	random_sprite = FALSE

//////////////////////////drinkingglass and shaker//
//Note by Darem: This code handles the mixing of drinks. New drinks go in three places: In Chemistry-Reagents.dm (for the drink
// itself), in Chemistry-Recipes.dm (for the reaction that changes the components into the drink), and here (for the drinking glass
// icon states.


/obj/item/reagent_containers/cup/glass/shaker
	name = "shaker"
	desc = "A metal shaker to mix drinks in."
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "shaker"
	custom_materials = list(/datum/material/iron= HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	amount_per_transfer_from_this = 10
	volume = 100
	isGlass = FALSE
	interaction_flags_click = NEED_HANDS|FORBID_TELEKINESIS_REACH
	/// Whether or not poured drinks should use custom names and descriptions
	var/using_custom_drinks = FALSE
	/// Name custom drinks will have
	var/custom_drink_name = "Custom drink"
	/// Description custom drinks will have
	var/custom_drink_desc = "Mixed by your favourite bartender!"

/obj/item/reagent_containers/cup/glass/shaker/Initialize(mapload)
	. = ..()
	if(prob(10))
		name = "\improper Nanotrasen 20th Anniversary Shaker"
		desc += " It has an emblazoned Nanotrasen logo on it."
		icon_state = "shaker_n"

/obj/item/reagent_containers/cup/glass/shaker/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "[using_custom_drinks ? "Disable" : "Enable"] custom drinks"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/reagent_containers/cup/glass/shaker/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to [using_custom_drinks ? "disable" : "enable"] custom drink naming")
	if(using_custom_drinks)
		. += span_notice("Drinks poured from this shaker will have the following name: [custom_drink_name]")
		. += span_notice("Drinks poured from this shaker will have the following description: [custom_drink_desc]")

/obj/item/reagent_containers/cup/glass/shaker/click_alt(mob/user)
	if(using_custom_drinks)
		using_custom_drinks = FALSE
		disable_custom_drinks()
		balloon_alert(user, "custom drinks disabled")
		return CLICK_ACTION_BLOCKING

	var/new_name = reject_bad_text(tgui_input_text(user, "Drink name", "Set drink name", custom_drink_name, 45, FALSE), 64)
	if(!new_name)
		balloon_alert(user, "invalid drink name!")
		using_custom_drinks = FALSE
		return CLICK_ACTION_BLOCKING

	if(!user.can_perform_action(src, NEED_HANDS|FORBID_TELEKINESIS_REACH))
		return CLICK_ACTION_BLOCKING

	var/new_desc = reject_bad_text(tgui_input_text(user, "Drink description", "Set drink description", custom_drink_desc, 64, TRUE), 128)
	if(!new_desc)
		balloon_alert(user, "invalid drink description!")
		using_custom_drinks = FALSE
		return CLICK_ACTION_BLOCKING

	if(!user.can_perform_action(src, NEED_HANDS|FORBID_TELEKINESIS_REACH))
		return CLICK_ACTION_BLOCKING

	using_custom_drinks = TRUE
	custom_drink_name = new_name
	custom_drink_desc = new_desc

	enable_custom_drinks()
	balloon_alert(user, "now pouring custom drinks")
	return CLICK_ACTION_SUCCESS

/obj/item/reagent_containers/cup/glass/shaker/proc/enable_custom_drinks()
	RegisterSignal(src, COMSIG_REAGENTS_CUP_TRANSFER_TO, PROC_REF(handle_transfer))

/obj/item/reagent_containers/cup/glass/shaker/proc/disable_custom_drinks()
	UnregisterSignal(src, COMSIG_REAGENTS_CUP_TRANSFER_TO)

/obj/item/reagent_containers/cup/glass/shaker/proc/handle_transfer(atom/origin, atom/target)
	SIGNAL_HANDLER
	// Should only work on drinking/shot glasses
	if(!istype(target, /obj/item/reagent_containers/cup/glass/drinkingglass))
		return

	var/obj/item/reagent_containers/cup/glass/drinkingglass/target_glass = target
	target_glass.name = custom_drink_name
	target_glass.desc = custom_drink_desc
	ADD_TRAIT(target_glass, TRAIT_WAS_RENAMED, SHAKER_LABEL_TRAIT)

/obj/item/reagent_containers/cup/glass/flask
	name = "flask"
	desc = "Every good spaceman knows it's a good idea to bring along a couple of pints of whiskey wherever they go."
	custom_price = PAYCHECK_COMMAND * 2
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "flask"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*2.5)
	volume = 60
	isGlass = FALSE

/obj/item/reagent_containers/cup/glass/flask/gold
	name = "captain's flask"
	desc = "A gold flask belonging to the captain."
	icon_state = "flask_gold"
	custom_materials = list(/datum/material/gold=SMALL_MATERIAL_AMOUNT*5)

/obj/item/reagent_containers/cup/glass/flask/det
	name = "detective's flask"
	desc = "The detective's only true friend."
	icon_state = "detflask"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 30)

/obj/item/reagent_containers/cup/glass/flask/det/minor
	list_reagents = list(/datum/reagent/consumable/applejuice = 30)

/obj/item/reagent_containers/cup/glass/flask/barflask
	name = "flask"
	desc = "For those who can't be bothered to hang out at the bar to drink."
	icon_state = "barflask"

/obj/item/reagent_containers/cup/glass/flask/shiny
	name = "shiny flask"
	desc = "A shiny metal flask. It appears to have a Greek symbol inscribed on it."
	icon_state = "shinyflask"

/obj/item/reagent_containers/cup/glass/mug/britcup
	name = "cup"
	desc = "A cup with the British flag emblazoned on it."
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "coffeecup_brit"
	volume = 30

/obj/item/reagent_containers/cup/glass/flask/vacuumflask
	name = "vacuum flask"
	desc = "Keeping your drinks at the perfect temperature since 1892."
	icon_state = "vacuumflask"
	volume = 60
	var/obj/item/reagent_containers/cup/glass/flask/flask_cup/cup = /obj/item/reagent_containers/cup/glass/flask/flask_cup

/obj/item/reagent_containers/cup/glass/flask/vacuumflask/Initialize(mapload)
	. = ..()
	if(ispath(cup))
		cup = new cup(src)

	// Flask is sealed when initialized with a cup.
	reagents.flags &= ~OPENCONTAINER

/obj/item/reagent_containers/cup/glass/flask/vacuumflask/attack_self(mob/user, list/modifiers)
	if(cup)
		to_chat(user, span_notice("You remove the [src]'s cap."))

		// Move the cup out of the flask contents and put it into the user's hands
		cup.forceMove(user.loc)
		user.put_in_hands(cup)

		reagents.flags |= OPENCONTAINER // The container becomes open when the cap is removed
		cup = null
		update_appearance()
		return
	return ..()

// TG Style Alt-click handling to screw the cap back on
/obj/item/reagent_containers/cup/glass/flask/vacuumflask/click_alt(mob/user)
	// Check if the user is holding the correct cup in their active hand
	var/obj/item/W = user.get_active_held_item()

	if(!istype(W, /obj/item/reagent_containers/cup/glass/flask/flask_cup))
		to_chat(user, span_warning("You need to hold the flask cup in your active hand to put it back on!"))
		return CLICK_ACTION_BLOCKING

	if(cup)
		to_chat(user, span_warning("The [src] already has a cap."))
		return CLICK_ACTION_BLOCKING

	// Check volume constraints before merging liquids (since screwing it on dumps the cup's liquid into the flask)
	if(W.reagents.total_volume + reagents.total_volume > volume)
		to_chat(user, span_warning("There's too much fluid in both the cap and the [src]!"))
		return CLICK_ACTION_BLOCKING

	to_chat(user, span_notice("You screw the cap back onto the [src]."))

	if(user.transferItemToLoc(W, src))
		reagents.flags &= ~OPENCONTAINER // The container is now sealed
		cup = W
		// Dump all contents of the cap back into the flask
		cup.reagents.trans_to(src, cup.reagents.total_volume)
		update_appearance()
		return CLICK_ACTION_SUCCESS

	return CLICK_ACTION_BLOCKING

/obj/item/reagent_containers/cup/glass/flask/vacuumflask/update_icon_state()
	. = ..()
	icon_state = cup ? initial(icon_state) : "[initial(icon_state)]-nobrim"

// --- FLASK CUP (THE CAP) ---

/obj/item/reagent_containers/cup/glass/flask/flask_cup
	name = "vacuum flask cup"
	desc = "The cup that appears in your hands after you unscrew the cap of the flask and turn it over. Magic!"
	icon_state = "vacuumflask-brim"
	volume = 10

