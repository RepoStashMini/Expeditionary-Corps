/datum/preference/text/flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[EXAMINE_DNA_FLAVOR_TEXT] = value

/// `apply_to_human` does not fire with this, this is read directly in [/mob/living/silicon/proc/get_silicon_flavortext]
/// and given to silicon examine but *not* given to tgui—that just reads this datum
/datum/preference/text/silicon_flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "silicon_flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/silicon_flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE // To prevent the not-implemented runtime

/// `apply_to_human` does not fire with this, this is read directly in [/mob/living/silicon/proc/get_silicon_flavortext]
/// and given to silicon examine but *not* given to tgui—that just reads this datum

/datum/preference/text/ooc_notes
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ooc_notes"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/ooc_notes/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[EXAMINE_DNA_OOC_NOTES] = value

// RP RECORDS REJUVINATION - All of these are handled in datacore, so we dont apply it to the human.
/datum/preference/text/general
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "general_record"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/general/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/medical
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "medical_record"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/medical/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/security
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "security_record"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/security/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/exploitable
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "exploitable_info"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/exploitable/create_default_value()
	return EXPLOITABLE_DEFAULT_TEXT

/datum/preference/text/exploitable/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/text/background
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "background_info"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/background/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
