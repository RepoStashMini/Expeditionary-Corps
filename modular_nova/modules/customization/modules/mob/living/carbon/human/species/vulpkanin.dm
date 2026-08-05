/datum/species/vulpkanin
	name = "Vulpkanin"
	id = SPECIES_VULP
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID

	mutanttongue = /obj/item/organ/tongue/vulpkanin
	species_language_holder = /datum/language_holder/vulpkanin

	coldmod = 0.6
	heatmod = 1.3
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_MAMMAL
	meat = /obj/item/food/meat/slab/corgi
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant,
	)

/datum/species/vulpkanin/get_default_mutant_bodyparts()
	return list(
		FEATURE_TAIL = MUTPART_BLUEPRINT("Fox", is_randomizable = TRUE),
		FEATURE_SNOUT = MUTPART_BLUEPRINT("Mammal, Long", is_randomizable = TRUE),
		FEATURE_EARS = MUTPART_BLUEPRINT("Fox", is_randomizable = TRUE),
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = FALSE, is_feature = TRUE),
	)

/obj/item/organ/tongue/vulpkanin
	liked_foodtypes = RAW | MEAT
	disliked_foodtypes = CLOTH
	toxic_foodtypes = TOXIC


/datum/species/vulpkanin/randomize_features()
	var/list/features = ..()
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of mostly brightish, animal, matching colors
	switch(random)
		if(1)
			main_color = "#FFAA00"
			second_color = "#FFDD44"
		if(2)
			main_color = "#FF8833"
			second_color = "#FFAA33"
		if(3)
			main_color = "#FFCC22"
			second_color = "#FFDD88"
		if(4)
			main_color = "#FF8800"
			second_color = "#FFFFFF"
		if(5)
			main_color = "#999999"
			second_color = "#EEEEEE"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = second_color
	features[FEATURE_MUTANT_COLOR_THREE] = second_color
	return features

/datum/species/vulpkanin/get_random_body_markings(list/passed_features)
	var/name = pick("Fox", "Floof", "Floofer")
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/vulpkanin/get_species_description()
	return placeholder_description

/datum/species/vulpkanin/get_species_lore()
	return list(placeholder_lore)

/datum/species/vulpkanin/prepare_human_for_preview(mob/living/carbon/human/vulp)
	var/main_color = "#FF8800"
	var/second_color = "#FFFFFF"

	vulp.dna.features[FEATURE_MUTANT_COLOR] = main_color
	vulp.dna.features[FEATURE_MUTANT_COLOR_TWO] = second_color
	vulp.dna.features[FEATURE_MUTANT_COLOR_THREE] = second_color
	vulp.dna.mutant_bodyparts[FEATURE_SNOUT] = build_mutant_part("Mammal, Long", list(main_color, main_color, main_color))
	vulp.dna.mutant_bodyparts[FEATURE_TAIL] = build_mutant_part("Husky", list(second_color, main_color, main_color))
	vulp.dna.mutant_bodyparts[FEATURE_EARS] = build_mutant_part("Wolf", list(main_color, second_color, second_color))
	regenerate_organs(vulp, src, visual_only = TRUE)
	vulp.update_body(TRUE)

/datum/species/vulpkanin/get_physical_attributes()
	return "Вульпканины имеют плотный который мех защищает от холода, \
		а острые клыки и когти дают небольшое преимущество в рукопашных стычках."

/datum/species/vulpkanin/get_species_description()
	return "Хитрые, преданные стае и высокотехнологичные Вульпканины родом с засушливой планеты Ауриум. \
		Их общество прошло путь от разрозненных кочевых кланов до развитой звёздной цивилизации, \
		которая теперь активно сотрудничает с НаноТрейзен в сферах инженерии и логистики."

/datum/species/vulpkanin/get_species_lore()
	return list(
		"Родная планета Вульпканинов — Ауриум, мир бескрайних пустынь и каньонов, где выживание зависело от слаженной работы всей стаи.",

		"В отличие от многих других рас, Вульпканины вышли в космос самостоятельно, используя собственные технологии, \
		поэтому они общаются с людьми как равные партнёры, а не как дешёвая рабочая сила.",

		"Культура Вульпканинов глубоко укоренена в понятии «Стаи» (клана). Одиночество для них — худшее наказание, \
		поэтому на станциях они стараются держаться поближе к сородичам или верным друзьям.",

		"Чуткий слух Вульпканинов — это и дар, и проклятие. Они могут услышать шаги за углом, но близкий взрыв \
		или оглушающий крик способны полностью вывести их из строя на долгое время.",

		"Среди Вульпканинов высоко ценится прагматизм и техническая смекалка. Из них выходят превосходные \
		атмосферные техники, инженеры и квартирмейстеры, любящие копаться в механизмах.",

		"Многие Вульпканины сохранили привычку метить свою территорию или использовать язык тела — \
		виляние хвостом или прижатые уши могут сказать о них больше, чем любые слова.",

		"Отношения между Вульпами и Синдикатом неоднозначны: некоторые независимые стаи с Ауриума \
		охотно нанимаются к противникам НаноТрейзен, если это сулит выгоду для их семьи."
	)

/datum/species/akula/create_pref_unique_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "assistive-listening-systems",
		SPECIES_PERK_NAME = "Чуткие уши",
		SPECIES_PERK_DESC = "Большие ушные раковины делают вас в два раза более уязвимым к оглушению от взрывов, флешек и светошумовых гранат.",
	))
	return perks
