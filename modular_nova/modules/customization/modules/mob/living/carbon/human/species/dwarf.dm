/datum/species/dwarf
	name = "Dwarf"
	id = SPECIES_DWARF
	examine_limb_id = SPECIES_HUMAN
	inherent_traits = list(
		TRAIT_DWARF,TRAIT_SNOB,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_USES_SKINTONES,
	)
	mutanttongue = /obj/item/organ/tongue/dwarven
	skinned_type = /obj/item/stack/sheet/animalhide/carbon/human
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 1.0
	body_size_restricted = TRUE

/datum/species/dwarf/get_physical_attributes()
	return " "

/datum/species/dwarf/get_species_description()
	return "Дварфы — редкая эволюционная ветвь человечества, рождённая в суровых шахтёрских колониях миров высокой гравитации. \
		Из-за тяжелейших условий на их изолированных родинах, численность этой расы крайне мала, что делает их редкими гостями на объектах НаноТрейзен."

/datum/species/dwarf/get_species_lore()
	return list(
		"Генетически Дварфы являются людьми, но столетия жизни на планетах с сокрушительным притяжением уменьшили их рост.",

		"Культура Дварфов зародилась в глубоких подземных шахтах, где каждый ценился по его способности держать кирку и переносить тяжести. \
		Они презирают корпоративную бюрократию, предпочитая решать споры честным трудом или крепкой дракой в баре.",

		"Отношения Дварфов с алкоголем давно стали легендой. Их печень перерабатывает токсины настолько эффективно, \
		что обычное человеческое пиво для них не крепче воды. Чтобы просто захмелеть, им приходится пить промышленный этанол.",

		"Из-за своей малочисленности Дварфы редко покидают родные закрытые общины, но те немногие, кто решаются на контракт, \
		высоко ценятся НаноТрейзен за способность выдерживать травмы, которые просто раздавили бы обычного человека.",

		"Среди Дварфов невероятно развито чувство товарищества и верности своей рабочей бригаде. \
		Они никогда не бросают своих в беде, но если кто-то проявит трусость или предаст гильдию, его имя навсегда заносится в клановую книгу обид.",

		"Многие Дварфы гордятся своими густыми бородами, которые в условиях шахт служат естественным фильтром против крупной пыли, \
		а в космическую эпоху стали главным символом их культурной идентичности и гордости."
	)


/datum/species/dwarf/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_facial_haircolor("#a55310", update = FALSE)
	human.set_facial_hairstyle("Beard (Dwarf)")
