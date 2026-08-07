/datum/species/lizard
	body_markings = list()
	mutant_organs = list()
	payday_modifier = 1.0

/datum/species/lizard/get_default_mutant_bodyparts()
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

/datum/species/lizard/ashwalker/get_default_mutant_bodyparts()
	var/list/default_parts = ..()
	default_parts[FEATURE_SPINES] = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = TRUE)
	return default_parts

/datum/species/lizard/silverscale/get_default_mutant_bodyparts()
	var/list/default_parts = ..()
	default_parts[FEATURE_SPINES] = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = TRUE)
	return default_parts

/datum/species/lizard/randomize_features()
	var/list/features = ..()
	if(istype(src, /datum/species/lizard/silverscale)) // don't randomize silvercale colors
		return features

	var/main_color = "#[random_color()]"
	var/second_color
	var/third_color
	var/random = rand(1,3)
	switch(random)
		if(1) //First random case - all is the same
			second_color = main_color
			third_color = main_color
		if(2) //Second case, derrivatory shades, except there's no helpers for that and I dont feel like writing them
			second_color = main_color
			third_color = main_color
		if(3) //Third case, more randomisation
			second_color = "#[random_color()]"
			third_color = "#[random_color()]"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = second_color
	features[FEATURE_MUTANT_COLOR_THREE] = third_color
	return features

/datum/species/lizard/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#009999")
	lizard.dna.features[FEATURE_MUTANT_COLOR] = lizard_color
	lizard.dna.mutant_bodyparts[FEATURE_TAIL] = build_mutant_part("Light Tiger", list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts[FEATURE_SNOUT] = build_mutant_part("Sharp + Light", list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts[FEATURE_HORNS] = build_mutant_part("Simple", list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts[FEATURE_FRILLS] = build_mutant_part("Aquatic", list(lizard_color, lizard_color, lizard_color))
	lizard.dna.features[FEATURE_LEGS] = NORMAL_LEGS
	regenerate_organs(lizard, src, visual_only = TRUE)
	lizard.update_body(TRUE)

/datum/species/lizard/ashwalker
	always_customizable = TRUE
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
	)

/datum/species/lizard/ashwalker/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#990000")
	. = ..(lizard, lizard_color)


/datum/species/lizard/silverscale/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#eeeeee")
	lizard.set_eye_color("#0000a0")
	. = ..(lizard, lizard_color)
