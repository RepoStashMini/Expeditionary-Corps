/// Maximum HSV value (brightness) allowed for shadekin colors. Range is 0-100.
#define SHADEKIN_MAX_BRIGHTNESS 35

/datum/species/shadekin
	name = "Shadekin"
	id = SPECIES_SHADEKIN
	mutanttongue = /obj/item/organ/tongue/shadekin
	mutantears = /obj/item/organ/ears/shadekin
	mutantbrain = /obj/item/organ/brain/shadekin
	mutanteyes = /obj/item/organ/eyes/shadekin
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	species_language_holder = /datum/language_holder/shadekin
	language_prefs_whitelist = list(/datum/language/marish/empathy = TRUE)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
		TRAIT_SLICK_SKIN,
		TRAIT_MUTANT_COLORS,
		TRAIT_NIGHT_VISION,
		TRAIT_NOBREATH,
	)
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/shadekin,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/shadekin,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/shadekin,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/shadekin,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/shadekin,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/shadekin,
	)

/datum/species/shadekin/get_default_mutant_bodyparts()
	return list(
		FEATURE_TAIL = MUTPART_BLUEPRINT("Shade", is_randomizable = TRUE),
		FEATURE_SNOUT = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_EARS = MUTPART_BLUEPRINT("Shade Ears", is_randomizable = TRUE),
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = TRUE, is_feature = TRUE),
	)

/datum/species/shadekin/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "lightbulb",
		SPECIES_PERK_NAME = "Тёмная регенерация",
		SPECIES_PERK_DESC = "Шэйдкины постепенно залечивают свои физические раны и повреждения, находясь в полной темноте.",
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "crutch",
		SPECIES_PERK_NAME = "Светобоязнь",
		SPECIES_PERK_DESC = "Яркий свет угнетает Шэйдкинов, из-за чего они передвигаются немного медленнее, находясь на освещённых плитках.",
	))

	return to_add


/// Clamps a hex color's brightness (HSV value) to SHADEKIN_MAX_BRIGHTNESS.
/datum/species/shadekin/proc/clamp_color_brightness(color)
	if(!color)
		return "#000000"
	var/list/hsv = rgb2num(color, COLORSPACE_HSV)
	if(hsv[3] > SHADEKIN_MAX_BRIGHTNESS)
		hsv[3] = SHADEKIN_MAX_BRIGHTNESS
		return rgb(hsv[1], hsv[2], hsv[3], space = COLORSPACE_HSV)
	return color

/// Clamps all mutant colors and bodypart colors on the target to max brightness.
/datum/species/shadekin/proc/clamp_primary_colors(mob/living/carbon/human/target)
	// Clamp the primary mutant color, which is what is used for the bodyparts
	target.dna.features[FEATURE_MUTANT_COLOR] = clamp_color_brightness(target.dna.features[FEATURE_MUTANT_COLOR])

	// Clamp primary mutant color on all mutant bodyparts (ears, tail, horns, etc.)
	for(var/part_key, part_entry in target.dna.mutant_bodyparts)
		var/datum/mutant_bodypart/part = part_entry
		if(!istype(part))
			continue
		part.set_primary_color(clamp_color_brightness(part.get_primary_color()))

	// Update draw_color on bodypart overlays so they reflect the clamped colors
	for(var/obj/item/bodypart/bodypart as anything in target.bodyparts)
		for(var/datum/bodypart_overlay/mutant/overlay in bodypart.bodypart_overlays)
			if(!overlay.feature_key)
				continue
			var/datum/mutant_bodypart/mutant_part = target.dna.mutant_bodyparts[overlay.feature_key]
			if(!istype(mutant_part))
				continue
			overlay.set_appearance_from_dna(target.dna, limb = bodypart)

/datum/species/shadekin/apply_supplementary_body_changes(mob/living/carbon/human/target, datum/preferences/preferences, visuals_only = FALSE)
	clamp_primary_colors(target)

/datum/species/shadekin/randomize_features()
	var/list/features = ..()
	var/main_color
	var/secondary_color
	var/tertiary_color
	var/random = rand(1, 4)
	switch(random)
		if(1)
			main_color = "#202020"
			secondary_color = "#303030"
			tertiary_color = "#2a2a2a"
		if(2)
			main_color = "#4a1225"
			secondary_color = "#521220"
			tertiary_color = "#3d1a2a"
		if(3)
			main_color = "#4a3a12"
			secondary_color = "#4a4218"
			tertiary_color = "#3d3820"
		if(4)
			main_color = "#3d1040"
			secondary_color = "#351250"
			tertiary_color = "#3a2035"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	features[FEATURE_MUTANT_COLOR_THREE] = tertiary_color
	return features

/datum/species/shadekin/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	if(!pref_load)
		clamp_primary_colors(human_who_gained_species)

/datum/species/shadekin/prepare_human_for_preview(mob/living/carbon/human/shadekin)
	var/main_color = "#222222"
	var/secondary_color = "#383838"
	var/tertiary_color = "#383838"
	shadekin.dna.features[FEATURE_MUTANT_COLOR] = main_color
	shadekin.dna.features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	shadekin.dna.features[FEATURE_MUTANT_COLOR_THREE] = tertiary_color
	shadekin.dna.mutant_bodyparts[FEATURE_EARS] = build_mutant_part("Shade Ears", list(main_color, secondary_color, tertiary_color))
	shadekin.dna.mutant_bodyparts[FEATURE_SNOUT] = build_mutant_part(SPRITE_ACCESSORY_NONE, list(main_color, secondary_color, tertiary_color))
	shadekin.dna.mutant_bodyparts[FEATURE_TAIL] = build_mutant_part("Shade", list(main_color, secondary_color, tertiary_color))
	shadekin.set_eye_color("#5ec7e4")
	regenerate_organs(shadekin, src, visual_only = TRUE)
	shadekin.update_body(TRUE)

/datum/species/shadekin/get_species_description()
	return list(
		"Шэйдкины впервые появились подобно клубкам пыли, собирающимся под кроватью коллективного сознания. / \
		«Добро пожаловать, сородич» — первые слова, ощутимые в море мыслей, направили их к первому ментальному единению. ",
		"Шэйдкины не дышат, а их тела восстанавливаются в темноте, хотя и остаются хрупкими.",
	)

/datum/species/shadekin/get_species_lore()
	return list(
		"До сих пор неясно, когда именно Шэйдкины впервые появились на свет, хотя предполагается, что это относительно недавнее явление. / \
		Они формируются в тёмных и заброшенных местах, где за ними никто не наблюдает — простое созерцание способно разрушить процесс их создания. / \
		Когда формирование завершается, Шэйдкин черпает способность двигать конечностями и общаться из окружающих разумов, \
		и в конце концов у него рождается первая собственная мысль — осознание того, что он жив.",

		"Шэйдкины — это овеществлённая кромешная тьма. Свет словно проходит сквозь их тела, утомляя их. Они не отбрасывают теней. / \
		Шэйдкинов трудно классифицировать по размеру и внешности, ведь среди них нет двух одинаковых — они склонны перенимать черты окружающих видов, \
		которые иначе были бы им несвойственны. Например, Шэйдкины, зародившиеся на Тизиране, часто имеют рожки или уши в виде оборок. / \
		Среднестатистический Шэйдкин немного ниже человека и обладает схожей продолжительностью жизни. Те из них, кто не использует чужие правила именования, \
		обычно называют себя в честь своего места в общине — например, по названию профессии или социальной функции.",

		"Шэйдкины способны размножаться половым путём, однако их разуму требуется разнообразное окружение для правильного развития, что делает их весьма самостоятельными. / \
		Несмотря на это, Шэйдкины легко находят своё место в жизни и становятся неотъемлемой частью местных сообществ. Они более экспрессивны, чем другие виды, \
		чтобы компенсировать отсутствие псионической связи. / Их язык, Мариш (Marish), является чисто эмпатическим — психопаты физически не способны говорить на нём. \
		Цвет глаз играет важнейшую роль в их биологии, так как он указывает на темперамент.",

		"Тем не менее, Шэйдкин никогда не бывает по-настоящему одинок, поскольку они массово зародились на коварной луне Неома (Neoma) из-за её вечной тьмы и изоляции. / \
		Хотя у них нет централизованного правительства, эта луна — ближайшее подобие родины для Шэйдкинов. Она лишена света из-за своей орбиты вокруг Люсины (Lusine) — \
		экстремально горячего мира, который удерживает поверхность Неомы на грани обитаемости. / Немногие пригодные для жизни зоны даже стали заметной туристической достопримечательностью. \
		Неома выполняет важнейшую функцию — хранит коллективные знания общества Шэйдкинов и их ковенов.",

		"Ковены — это группы Шэйдкинов, созданные для поддержания жизнедеятельности, ведения хроник своего существования и направления новорождённых по мере их развития. / \
		Они редко связаны с какой-то конкретной идеологией, скорее с концепциями и тем, что они за собой влекут. Внутри ковенов существуют Котерии (Coteries) — группы по интересам, \
		сосредоточенные на каком-то одном аспекте. / В этом отношении ковены сами по себе являются обществами, организованными в некоторой степени по племенному принципу. \
		Ковены существуют не только на Неоме, они разбросаны по всей вселенной, но у большинства из них есть архивы на луне, называемые «Майндтрастами» (Mindtrusts)."
	)


#undef SHADEKIN_MAX_BRIGHTNESS
