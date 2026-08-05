/datum/species/lizard
	// Reptilian humanoids with scaled skin and tails.
	name = "\improper Unath"
	plural_form = "Unathi"
	id = SPECIES_LIZARD
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	body_markings = list()
	mutant_organs = list()
	payday_modifier = 1.0
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_REPTILE
	/* NOVA EDIT REMOVAL START - Customization
	body_markings = list(
		/datum/bodypart_overlay/simple/body_marking/lizard = SPRITE_ACCESSORY_NONE,
	)
	*/ // NOVA EDIT REMOVAL END
	mutant_organs = list(
		/obj/item/organ/horns = SPRITE_ACCESSORY_NONE,
		/obj/item/organ/frills = SPRITE_ACCESSORY_NONE,
		/obj/item/organ/snout = "Round",
		/obj/item/organ/spines = SPRITE_ACCESSORY_NONE,
		/obj/item/organ/tail/lizard = "Smooth",
	)
	mutanttongue = /obj/item/organ/tongue/lizard
	mutanteyes = /obj/item/organ/eyes/lizard
	mutantbrain = /obj/item/organ/brain/lizard

	coldmod = 1.5
	heatmod = 0.67
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	species_cookie = /obj/item/food/meat/slab
	meat = /obj/item/food/meat/slab/human/mutant/lizard
	skinned_type = /obj/item/stack/sheet/animalhide/carbon/lizard
	exotic_bloodtype = BLOOD_TYPE_LIZARD
	inert_mutation = /datum/mutation/firebreath
	death_sound = 'sound/mobs/humanoids/lizard/deathsound.ogg'
	species_language_holder = /datum/language_holder/lizard
	digitigrade_customization = DIGITIGRADE_OPTIONAL

	// Lizards are coldblooded and can stand a greater temperature range than humans
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_LAVALAND_SAFE
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 10)

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/lizard,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/lizard,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/lizard,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/lizard,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/lizard,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/lizard,
	)

/datum/species/lizard/get_default_mutant_bodyparts() // nova
	return list(
		FEATURE_TAIL = MUTPART_BLUEPRINT("Smooth", is_randomizable = TRUE),
		FEATURE_SNOUT = MUTPART_BLUEPRINT("Sharp + Light", is_randomizable = TRUE),
		FEATURE_SPINES = MUTPART_BLUEPRINT("Long + Membrane", is_randomizable = TRUE),
		FEATURE_FRILLS = MUTPART_BLUEPRINT("Short", is_randomizable = TRUE),
		FEATURE_HORNS = MUTPART_BLUEPRINT("Curled", is_randomizable = TRUE),
		FEATURE_MARKING_GENERIC = MUTPART_BLUEPRINT("Light Belly", is_randomizable = TRUE),
		FEATURE_LEGS = MUTPART_BLUEPRINT(DIGITIGRADE_LEGS, is_randomizable = FALSE, is_feature = TRUE),
		FEATURE_WINGS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
	)

/// Lizards are cold blooded and do not stabilize body temperature naturally
/datum/species/lizard/body_temperature_core(mob/living/carbon/human/humi, seconds_per_tick)
	return

//NOVA EDIT REMOVAL BEGIN
/*
/datum/species/lizard/randomize_features()
	var/list/features = ..()
	features[FEATURE_LIZARD_MARKINGS] = pick(SSaccessories.feature_list[FEATURE_LIZARD_MARKINGS])
	return features
*/
//NOVA EDIT REMOVAL END

/datum/species/lizard/get_scream_sound(mob/living/carbon/human/lizard)
	return pick(
		'sound/mobs/humanoids/lizard/lizard_scream_1.ogg',
		'sound/mobs/humanoids/lizard/lizard_scream_2.ogg',
		'sound/mobs/humanoids/lizard/lizard_scream_3.ogg',
	)

/datum/species/lizard/get_cough_sound(mob/living/carbon/human/lizard)
	if(lizard.physique == FEMALE)
		return pick(
			'sound/mobs/humanoids/human/cough/female_cough1.ogg',
			'sound/mobs/humanoids/human/cough/female_cough2.ogg',
			'sound/mobs/humanoids/human/cough/female_cough3.ogg',
			'sound/mobs/humanoids/human/cough/female_cough4.ogg',
			'sound/mobs/humanoids/human/cough/female_cough5.ogg',
			'sound/mobs/humanoids/human/cough/female_cough6.ogg',
		)
	return pick(
		'sound/mobs/humanoids/human/cough/male_cough1.ogg',
		'sound/mobs/humanoids/human/cough/male_cough2.ogg',
		'sound/mobs/humanoids/human/cough/male_cough3.ogg',
		'sound/mobs/humanoids/human/cough/male_cough4.ogg',
		'sound/mobs/humanoids/human/cough/male_cough5.ogg',
		'sound/mobs/humanoids/human/cough/male_cough6.ogg',
	)


/datum/species/lizard/get_cry_sound(mob/living/carbon/human/lizard)
	if(lizard.physique == FEMALE)
		return pick(
			'sound/mobs/humanoids/human/cry/female_cry1.ogg',
			'sound/mobs/humanoids/human/cry/female_cry2.ogg',
		)
	return pick(
		'sound/mobs/humanoids/human/cry/male_cry1.ogg',
		'sound/mobs/humanoids/human/cry/male_cry2.ogg',
		'sound/mobs/humanoids/human/cry/male_cry3.ogg',
	)


/datum/species/lizard/get_sneeze_sound(mob/living/carbon/human/lizard)
	if(lizard.physique == FEMALE)
		return 'sound/mobs/humanoids/human/sneeze/female_sneeze1.ogg'
	return 'sound/mobs/humanoids/human/sneeze/male_sneeze1.ogg'

/datum/species/lizard/get_laugh_sound(mob/living/carbon/human/lizard)
	return 'sound/mobs/humanoids/lizard/lizard_laugh1.ogg'

/datum/species/lizard/get_sigh_sound(mob/living/carbon/human/lizard)
	if(lizard.physique == FEMALE)
		return SFX_FEMALE_SIGH
	return SFX_MALE_SIGH

/datum/species/lizard/get_sniff_sound(mob/living/carbon/human/lizard)
	if(lizard.physique == FEMALE)
		return 'sound/mobs/humanoids/human/sniff/female_sniff.ogg'
	return 'sound/mobs/humanoids/human/sniff/male_sniff.ogg'

/datum/species/lizard/get_snore_sound(mob/living/carbon/human/lizard)
	if(lizard.physique == FEMALE)
		return SFX_SNORE_FEMALE
	return SFX_SNORE_MALE

/datum/species/lizard/get_hiss_sound(mob/living/carbon/human/lizard)
	return 'sound/mobs/humanoids/lizard/lizard_hiss.ogg'

/datum/species/lizard/get_physical_attributes()
	return "Унати способны выдерживать немного более высокие температуры, чем большинство других рас, но они крайне уязвимы к холоду \
		и не могут регулировать температуру своего тела изнутри, из-за чего вакуум космоса для них смертельно опасен."

/datum/species/lizard/get_species_description()
	return "Милитаристские Унати родом с планеты Тизиран, в системе Ризкалон,. За века жизни среди звёзд они разрослись \
		до масштабов огромной космической империи, однако теперь им приходится соперничать со своими \
		более молодыми и технологически продвинутыми соседями — людьми."

/datum/species/lizard/get_species_lore()
	return list(
		"Лицо теорий заговора изменилось навсегда в тот день, когда человечество встретило Унати.",

		"Происходя из засушливого мира Тизиран, Унати бороздили просторы космоса ещё в те времена, когда человечество только открывало для себя, насколько крутыми могут быть поезда. \
		Однако, подобно космической басне о черепахе и зайце, Унати отвергли девиз своих предков «тише едешь — дальше будешь» в пользу почивания на лаврах, \
		из-за чего их полностью обогнали «лысые обезьяны» — в немалой степени из-за отсутствия у Унати доступа к плазме.",

		"История взаимоотношений между Унати и людьми привела ко многим конфликтам, в которых Унати оказывались проигравшей стороной, \
		а финалом стало взрывное переустройство их луны. Сегодня в отношениях между Унати и людьми наблюдается продолжение рекордного периода мира.",

		"Культура Унати по своей природе милитаристская, хотя влияние армии на неё \
		начинает слабеть по мере того, как колонии отдаляются от их родного мира — \
		некоторые далёкие колонии и вовсе оказываются поглощены культурными традициями других соседних рас.",

		"На своей родной планете Унати празднуют 16-летие зачислением на обязательную 5-летнюю военную службу. \
		Роли варьируются от боевых до гражданских и всего, что между ними. Как гласит старый слоган: «Твоё место будет найдено!»",
	)



// Override for the default temperature perks, so we can give our specific "cold blooded" perk.
/datum/species/lizard/create_pref_temperature_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = "thermometer-empty",
		SPECIES_PERK_NAME = "Хладнокровность",
		SPECIES_PERK_DESC = "Унати обладают более высокой устойчивостью к жарким температурам, но гораздо хуже \
			переносят холод. Кроме того, они не могут самостоятельно регулировать температуру своего тела — \
			они ровно настолько холодные или тёплые, насколько холодно или тепло вокруг них. Держитесь в тепле!",
	))

	return to_add

/datum/species/lizard/randomize_features()  // nova
	var/list/features = ..()
	if(istype(src, /datum/species/lizard/silverscale)) // don't randomize silvercale colors
		return features

	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of green or brown colors, with a darker secondary and tertiary
	switch(random)
		if(1)
			main_color = "#11CC00"
			second_color = "#118800"
		if(2)
			main_color = "#55CC11"
			second_color = "#55AA11"
		if(3)
			main_color = "#77AA11"
			second_color = "#668811"
		if(4)
			main_color = "#886622"
			second_color = "#774411"
		if(5)
			main_color = "#33BB11"
			second_color = "#339911"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = second_color
	features[FEATURE_MUTANT_COLOR_THREE] = second_color
	return features

/datum/species/lizard/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#668811") // nova
	lizard.dna.features[FEATURE_MUTANT_COLOR] = lizard_color
	lizard.dna.mutant_bodyparts[FEATURE_TAIL] = build_mutant_part("Light Tiger", list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts[FEATURE_SNOUT] = build_mutant_part("Sharp + Light", list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts[FEATURE_HORNS] = build_mutant_part("Simple", list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts[FEATURE_FRILLS] = build_mutant_part("Aquatic", list(lizard_color, lizard_color, lizard_color))
	lizard.dna.features[FEATURE_LEGS] = NORMAL_LEGS
	regenerate_organs(lizard, src, visual_only = TRUE)
	lizard.update_body(TRUE)

/*
Lizard subspecies: ASHWALKERS
*/
/datum/species/lizard/ashwalker
	name = "Пеплоходец"
	id = SPECIES_LIZARD_ASH
	examine_limb_id = SPECIES_LIZARD
	always_customizable = TRUE  // nova
	mutantlungs = /obj/item/organ/lungs/lavaland
	mutantbrain = /obj/item/organ/brain/primitive
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_VIRUSIMMUNE,
		TRAIT_MUTANT_COLORS, // nova
	)
	// inherent_factions = list(FACTION_ASHWALKER) // NOVA EDIT REMOVAL: Moving to Ritual
	species_language_holder = /datum/language_holder/lizard/ash
	digitigrade_customization = DIGITIGRADE_FORCED
	examine_limb_id = SPECIES_LIZARD
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/lizard,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/lizard,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/lizard/ashwalker,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/lizard/ashwalker,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/lizard,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/lizard,
	)

/datum/species/lizard/ashwalker/get_physical_attributes()
	return "Пеплоходецы практически во всём идентичны Унати. \
		В отличие от них, они всегда пальцеходящие, способны дышать зачастую ядовитой атмосферой Лавалэнда и сопротивляться вирусам. Обычно они неграмотны."

/datum/species/lizard/ashwalker/get_default_mutant_bodyparts()  // nova
	var/list/default_parts = ..()
	default_parts[FEATURE_SPINES] = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = TRUE)
	return default_parts

/datum/species/lizard/ashwalker/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#990000") // nova
	. = ..(lizard, lizard_color)

/*
Lizard subspecies: SILVER SCALED
*/
/datum/species/lizard/silverscale
	name = "Серебряная чешуя"
	id = SPECIES_LIZARD_SILVER
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_REPTILE
	inherent_traits = list(
		TRAIT_HOLY,
		TRAIT_NOBREATH,
		TRAIT_PIERCEIMMUNE,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_WINE_TASTER,
	)
	mutantlungs = null
	damage_modifier = 10 //very light silvery scales soften blows
	species_language_holder = /datum/language_holder/lizard/silver
	mutanttongue = /obj/item/organ/tongue/lizard/silver
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN
	examine_limb_id = SPECIES_LIZARD
	///stored mutcolor for when we turn back off of a silverscale.
	var/old_mutcolor

/datum/species/lizard/silverscale/get_physical_attributes()
	return "Серебряные Чешуйки для Унати — то же самое, что ангелы для людей. \
		Почти во всём идентичные, они святы, не дышат, не заражаются вирусами, их шкуру невозможно пробить, они обожают вкус вина, \
		а их язык почему-то позволяет им превращаться в статую."

/datum/species/lizard/silverscale/on_species_gain(mob/living/carbon/human/new_silverscale, datum/species/old_species, pref_load, regenerate_icons)
	old_mutcolor = new_silverscale.dna.features[FEATURE_MUTANT_COLOR]
	new_silverscale.dna.features[FEATURE_MUTANT_COLOR] = "#eeeeee"
	new_silverscale.add_eye_color("#0000a0", EYE_COLOR_SPECIES_PRIORITY)
	. = ..()
	new_silverscale.add_filter("silver_glint", 2, list("type" = "outline", "color" = "#ffffff63", "size" = 2))

/datum/species/lizard/silverscale/on_species_loss(mob/living/carbon/human/was_silverscale, datum/species/new_species, pref_load)
	was_silverscale.dna.features[FEATURE_MUTANT_COLOR] = old_mutcolor
	was_silverscale.remove_eye_color(EYE_COLOR_SPECIES_PRIORITY)
	was_silverscale.remove_filter("silver_glint")
	return ..()

/datum/species/lizard/silverscale/get_default_mutant_bodyparts()  // nova
	var/list/default_parts = ..()
	default_parts[FEATURE_SPINES] = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = TRUE)
	return default_parts


/datum/species/lizard/silverscale/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#eeeeee") // nova
	lizard.set_eye_color("#0000a0")
	. = ..(lizard, lizard_color)
