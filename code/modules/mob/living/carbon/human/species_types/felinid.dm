//Subtype of human
/datum/species/human/felinid
	name = "Фелениды"
	id = SPECIES_FELINE
	examine_limb_id = SPECIES_HUMAN
	mutantbrain = /obj/item/organ/brain/felinid
	mutanttongue = /obj/item/organ/tongue/cat
	mutantears = /obj/item/organ/ears // NOVA EDIT CHANGE - these mutantpart vars annoyingly confict with our own mutant_bodyparts system and should never be used for visual organs - ORIGINAL /obj/item/organ/ears/cat
	mutanteyes = /obj/item/organ/eyes/felinid
	mutant_organs = list(
		/obj/item/organ/tail/cat = "Cat",
	)
	inherent_traits = list(
		TRAIT_CATLIKE_GRACE,
		TRAIT_HATED_BY_DOGS,
		TRAIT_USES_SKINTONES,
		TRAIT_WATER_HATER,
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	species_language_holder = /datum/language_holder/felinid
	payday_modifier = 1.0
	family_heirlooms = list(/obj/item/toy/cattoy)
	/// When false, this is a felinid created by mass-purrbation
	var/original_felinid = TRUE
	/// Yummy!
	species_cookie = /obj/item/food/nugget

/datum/species/human/felinid/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons = TRUE, replace_missing = TRUE)
	if(!pref_load) //Hah! They got forcefully purrbation'd. Force default felinid parts on them if they have no mutant parts in those areas!
		if(isnull(human_who_gained_species.dna.mutant_bodyparts[FEATURE_TAIL])) // NOVA EDIT CHANGE - ORIGINAL: if(human_who_gained_species.dna.features[FEATURE_TAIL_CAT] == SPRITE_ACCESSORY_NONE)
			human_who_gained_species.dna.mutant_bodyparts[FEATURE_TAIL] = build_mutant_part("Cat", list(human_who_gained_species.hair_color)) // NOVA EDIT CHANGE - ORIGINAL: human_who_gained_species.dna.features[FEATURE_TAIL_CAT] = get_consistent_feature_entry(SSaccessories.feature_list[FEATURE_TAIL_CAT])
		if(isnull(human_who_gained_species.dna.mutant_bodyparts[FEATURE_EARS])) // NOVA EDIT CHANGE - ORIGINAL: if(human_who_gained_species.dna.features[FEATURE_EARS] == SPRITE_ACCESSORY_NONE)
			human_who_gained_species.dna.mutant_bodyparts[FEATURE_EARS] = build_mutant_part("Cat", list(human_who_gained_species.hair_color)) // NOVA EDIT CHANGE - ORIGINAL: human_who_gained_species.dna.features[FEATURE_EARS] = get_consistent_feature_entry(SSaccessories.feature_list[FEATURE_EARS])

	// Swapping out feline ears for normal ol' human ears if they have invisible cat ears.
	if(isnull(human_who_gained_species.dna.mutant_bodyparts[FEATURE_EARS])) // NOVA EDIT CHANGE - ORIGINAL: if(human_who_gained_species.dna.features[FEATURE_EARS] == SPRITE_ACCESSORY_NONE)
		mutantears = /obj/item/organ/ears
	return ..()

/datum/species/human/felinid/get_hiss_sound(mob/living/carbon/human/felinid)
	return 'sound/mobs/humanoids/felinid/felinid_hiss.ogg'

/proc/mass_purrbation()
	for(var/mob in GLOB.human_list)
		purrbation_apply(mob)
		CHECK_TICK

/proc/mass_remove_purrbation()
	for(var/mob in GLOB.human_list)
		purrbation_remove(mob)
		CHECK_TICK

/proc/purrbation_toggle(mob/living/carbon/human/target_human, silent = FALSE)
	if(!ishuman(target_human))
		return
	if(!istype(target_human.get_organ_slot(ORGAN_SLOT_EARS), /obj/item/organ/ears/cat))
		purrbation_apply(target_human, silent = silent)
		. = TRUE
	else
		purrbation_remove(target_human, silent = silent)
		. = FALSE

/proc/purrbation_apply(mob/living/carbon/human/soon_to_be_felinid, silent = FALSE)
	if(!ishuman(soon_to_be_felinid) || isfelinid(soon_to_be_felinid))
		return
	if(ishumanbasic(soon_to_be_felinid))
		soon_to_be_felinid.set_species(/datum/species/human/felinid)
		var/datum/species/human/felinid/cat_species = soon_to_be_felinid.dna.species
		cat_species.original_felinid = FALSE
	else
		// This removes the spines if they exist
		var/obj/item/organ/spines/current_spines = soon_to_be_felinid.get_organ_slot(ORGAN_SLOT_EXTERNAL_SPINES)
		if(current_spines)
			current_spines.Remove(soon_to_be_felinid, special = TRUE)
			qdel(current_spines)

		// Without this line the tails would be invisible. This is because cat tail and ears default to None.
		// Humans get converted directly to felinids, and the key is handled in on_species_gain.
		// Now when we get mob.dna.features[feature_key], it returns None, which is why the tail is invisible.
		// stored_feature_id is only set once (the first time an organ is inserted), so this should be safe.
		var/obj/item/organ/ears/cat/kitty_ears = new
		kitty_ears.Insert(soon_to_be_felinid, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		if(should_visual_organ_apply_to(/obj/item/organ/tail/cat, soon_to_be_felinid)) //only give them a tail if they actually have sprites for it / are a compatible subspecies.
			var/obj/item/organ/tail/cat/kitty_tail = new
			kitty_tail.Insert(soon_to_be_felinid, special = TRUE, movement_flags = DELETE_IF_REPLACED)

	if(!silent)
		to_chat(soon_to_be_felinid, span_boldnotice("Something is nya~t right."))
		playsound(get_turf(soon_to_be_felinid), 'sound/effects/meow1.ogg', 50, TRUE, -1)

/proc/purrbation_remove(mob/living/carbon/human/purrbated_human, silent = FALSE)
	if(isfelinid(purrbated_human))
		var/datum/species/human/felinid/cat_species = purrbated_human.dna.species
		if(cat_species.original_felinid)
			return // Don't display the to_chat message
		purrbated_human.set_species(/datum/species/human)
	else if(ishuman(purrbated_human) && !ishumanbasic(purrbated_human))
		var/datum/species/target_species = purrbated_human.dna.species

		// From the previous check we know they're not a felinid, therefore removing cat ears and tail is safe
		var/obj/item/organ/tail/old_tail = purrbated_human.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
		if(istype(old_tail, /obj/item/organ/tail/cat))
			old_tail.Remove(purrbated_human, special = TRUE)
			qdel(old_tail)
			// Locate does not work on assoc lists, so we do it by hand
			for(var/external_organ in target_species.mutant_organs)
				if(!should_visual_organ_apply_to(external_organ, purrbated_human))
					continue
				if(ispath(external_organ, /obj/item/organ/tail))
					var/obj/item/organ/tail/new_tail = new external_organ()
					new_tail.Insert(purrbated_human, special = TRUE, movement_flags = DELETE_IF_REPLACED)
				// Don't forget the spines we removed earlier
				else if(ispath(external_organ, /obj/item/organ/spines))
					var/obj/item/organ/spines/new_spines = new external_organ()
					new_spines.Insert(purrbated_human, special = TRUE, movement_flags = DELETE_IF_REPLACED)

		var/obj/item/organ/ears/old_ears = purrbated_human.get_organ_slot(ORGAN_SLOT_EARS)
		if(istype(old_ears, /obj/item/organ/ears/cat))
			var/obj/item/organ/new_ears = new target_species.mutantears()
			new_ears.Insert(purrbated_human, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	if(!silent)
		to_chat(purrbated_human, span_boldnotice("You are no longer a cat."))

/datum/species/human/felinid/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.set_haircolor("#4A3728", update = FALSE)
	human_for_preview.set_hairstyle("Long Emo", update = TRUE)

	/* // NOVA EDIT REMOVAL START - Making the species menu icons work better - ORIGINAL:
	var/obj/item/organ/ears/cat/cat_ears = human_for_preview.get_organ_by_type(/obj/item/organ/ears/cat)
	if (cat_ears)
		cat_ears.color = human_for_preview.hair_color
		human_for_preview.update_hair()
	*/ // NOVA EDIT REMOVAL END
	// NOVA EDIT ADDITION START
	human_for_preview.dna.mutant_bodyparts[FEATURE_TAIL] = build_mutant_part("Cat", list(human_for_preview.hair_color))
	human_for_preview.dna.mutant_bodyparts[FEATURE_EARS] = build_mutant_part("Big", list(human_for_preview.hair_color))
	regenerate_organs(human_for_preview, src, visual_only = TRUE)
	// NOVA EDIT ADDITION END

/datum/species/human/felinid/get_physical_attributes()
	return "Фелиниды практически во всём похожи на людей. Главные их отличия — способность зализывать свои раны \
		и повышенная чувствительность к шуму, которая зачастую только вредит им. Кроме того, они весьма не прочь полакомиться апельсинами."

/datum/species/human/felinid/get_species_description()
	return "Фелиниды — один из множества видов заказных генетических модификаций, \
		появившихся благодаря полному освоению человечеством генной инженерии. По сути своей \
		они представляют собой специализированный подвид Бустеров, ставший одним из самых \
		распространенных в галактике. Мяу?"

/datum/species/human/felinid/get_species_lore()
	return list(
		"Биоинженерия во всей своей кошачьей красе: Фелиниды являются главным примером превосходства человечества над генетическим кодом. \
			Будучи одним из многих вариантов «Анималидов», Фелиниды стали самыми популярными и распространенными, а также одним из \
			главных камней преткновения в вопросах генетических модификаций.",

		"Бодимоддеры с энтузиазмом скрещивали ДНК человека и кошки в поисках священной триады: ушей, глаз и хвоста. \
			Эти черты пользовались огромным спросом, а сопутствующие побочные эффекты в виде вокальных и нейрохимических изменений считались лишь мелким неудобством.",

		"К несчастью для Фелинидов, эти неудобства оказались далеко не мелкими. Отвергнутые многими как недочеловеки и монстры, Фелиниды (и другие Анималиды) \
			отправились на поиски лучшей жизни в дальние колонии, сплотившись в общины себе подобных. \
			В результате в глубоком человеческом космосе сейчас наблюдается высокая популяция Анималидов.",

		"Со временем, однако, ситуация начала меняться. По мере того как Фелиниды становились неотъемлемой частью рабочей силы фронтира \
			и экипажей мегакорпораций, у большей части человечества выработалась умеренная терпимость к ним. Их перестали воспринимать \
			 как сиюминутную угрозу чистоте человеческого вида, начав относиться к ним как к привычному, пусть и специфическому элементу космического общества."
	)



// Felinids are subtypes of humans.
// This shouldn't call parent or we'll get a buncha human related perks (though it doesn't have a reason to).
/datum/species/human/felinid/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "grin-tongue",
			SPECIES_PERK_NAME = "Вылизывание",
			SPECIES_PERK_DESC = "Фелиниды могут зализывать свои или чужие раны, чтобы уменьшить кровотечение.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = FA_ICON_PERSON_FALLING,
			SPECIES_PERK_NAME = "Кошачья грация",
			SPECIES_PERK_DESC = "Кошачьи инстинкты позволяют Фелинидам приземляться на ноги. \
				Вместо падения навзничь вы получите лишь краткое замедление. \
				Однако ваши ноги всё ещё человеческие, поэтому само падение нанесёт дополнительный урон.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "assistive-listening-systems",
			SPECIES_PERK_NAME = "Чуткий слух",
			SPECIES_PERK_DESC = "Фелиниды более чувствительны к громким звукам, таким как взрывы светошумовых гранат.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "shower",
			SPECIES_PERK_NAME = "Гидрофобия",
			SPECIES_PERK_DESC = "Фелиниды очень не любят промокать до ниточки под водой или душем.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_ANGRY,
			SPECIES_PERK_NAME = "Оборонительная реакция «Бей или беги»",
			SPECIES_PERK_DESC = "Фелиниды, ставшие ментально нестабильными (и страдающие от голода), демонстрируют \
				экстремальную реакцию «бей или беги» против агрессоров. Иногда они кусают людей. Жестоко.",
		),
	)
	return to_add

