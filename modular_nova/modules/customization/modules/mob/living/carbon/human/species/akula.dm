/// How long the akula will stay wet for, AKA how long until they get a mood debuff
#define DRY_UP_TIME 10 MINUTES
/// How many wetstacks an Akula will get upon creation
#define WETSTACK_INITIAL 5
/// How many wetstacks an Akula needs to activate the TRAIT_SLIPPERY trait
#define WETSTACK_THRESHOLD 3

/datum/species/akula
	name = "Азулиан"
	plural_form = "Азулиане"
	id = SPECIES_AKULA
	offset_features = list(
		OFFSET_GLASSES = list(0, 1),
		OFFSET_EARS = list(0, 2),
		OFFSET_FACEMASK = list(0, 2),
		OFFSET_HEAD = list(0, 2),
		OFFSET_HAIR = list(0, 1),
	)
	mutantbrain = /obj/item/organ/brain/carp/akula
	mutantheart = /obj/item/organ/heart/carp/akula
	mutantlungs = /obj/item/organ/lungs/carp/akula
	mutanttongue = /obj/item/organ/tongue/carp/akula
//	mutanteyes = /obj/item/organ/eyes/akula
	meat = /obj/item/food/fishmeat/human
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
		TRAIT_SLICK_SKIN,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/aquatic,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/aquatic,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/aquatic,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/aquatic,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/aquatic,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/aquatic,
	)
	/// This variable stores the timer datum which appears if the mob becomes wet
	var/dry_up_timer = TIMER_ID_NULL

/datum/species/akula/get_default_mutant_bodyparts()
	return list(
		FEATURE_TAIL = MUTPART_BLUEPRINT("Shark", is_randomizable = TRUE),
		FEATURE_SNOUT = MUTPART_BLUEPRINT("Shark", is_randomizable = TRUE),
		FEATURE_HORNS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_EARS = MUTPART_BLUEPRINT("Hammerhead", is_randomizable = TRUE),
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = FALSE, is_feature = TRUE),
		FEATURE_WINGS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
	)

/datum/species/akula/get_physical_attributes()
	return "Акулы — амфибии с мощными челюстями и скользкой кожей, помогающей вырываться из захватов. \
		Их жабры требуют постоянной влаги для дыхания, а природа кочевников заставляет всегда быть в движении. \
		При этом они прирождённые пловцы, способные легко маневрировать даже в невесомости."


/datum/species/akula/get_species_description()
	return "Волевые и преданные монархии Акулы построили огромную космическую империю — Королевство Агуркррал. \
		Выбравшись из глубин родных океанов к звёздам, эти коллективисты и оппортунисты \
		создали сильное государство, способное на равных соперничать с Федерацией Сол."

/datum/species/akula/get_species_lore()
	return list(
		"История и культура Акул обязывают их вечно двигаться вперёд. Для них остановиться — значит погибнуть.",

		"Ещё в предыстории Акулы полностью разгромили враждебный вид, пытавшийся навсегда запереть их в океанах. \
		Этот триумф превратил их в экспансионистов, готовых терраформировать любые враждебные миры под свои нужды.",

		"Постоянное расширение разделило Королевство на два лагеря. Акулы разделены не по возрасту, а по расстоянию: \
		«Ближние» поколения растут в консервативных Старых Княжествах, а «Дальние» — во фронтирных Новых Княжествах.",

		"В Старых Княжествах ядра процветает аристократия, строго чтущая древние традиции и власть Короля. \
		Здесь ценится образование, выслуга лет для получения гражданства и помпезная общественная иерархия.",

		"Новые Княжества на окраинах контролируются вольными пограничными принцами-варлордами. \
		В этих краях амбиции важнее происхождения, а города-казино и пиратские порты могут вырасти за одну ночь.",

		"Поколения Акул недолюбливают друг друга. Окраинные считают кузенов из ядра задыхающимися от скуки в своих дворцах. \
		Аристократы же уверены, что бунтари с фронтира сошли с ума и растеряли истинный акуланский дух.",

		"Несмотря на разногласия, все граждане Агуркррала равны перед законом, а смертная казнь на их территориях запрещена. \
		Акулы бережно относятся к экологии своих водных миров, поддерживая чистоту биосферы для будущих поколений.",
	)



/datum/species/akula/create_pref_unique_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_TOOTH,
		SPECIES_PERK_NAME = "Мощный укус",
		SPECIES_PERK_DESC = "Вместо того чтобы наносить удары кулаками, вы используете свои острые зубы, нанося укусами повышенный урон."
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_PERSON_WALKING,
		SPECIES_PERK_NAME = "Космическая ходьба",
		SPECIES_PERK_DESC = "Вы можете свободно передвигаться в условиях нулевой гравитации, прямо как ваши предки."
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_HAND,
		SPECIES_PERK_NAME = "Скользкая кожа",
		SPECIES_PERK_DESC = "Когда вы достаточно промокли, вы получаете бонусный шанс вырваться из чужих захватов."
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_SHIRT,
		SPECIES_PERK_NAME = "Гидрокостюм",
		SPECIES_PERK_DESC = "Вы появляетесь в одежде, которая будет постоянно поддерживать вас в мокром состоянии, если её не снять."
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_LUNGS,
		SPECIES_PERK_NAME = "Жабры",
		SPECIES_PERK_DESC = "Если вы высохнете, вы потеряете способность дышать кислородом!",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_ARROW_DOWN,
		SPECIES_PERK_NAME = "ДНК кочевника",
		SPECIES_PERK_DESC = "Вы никогда не хотите подолгу оставаться на одном месте."
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_PERSON_FALLING,
		SPECIES_PERK_NAME = "Скользкие стопы",
		SPECIES_PERK_DESC = "Когда вы достаточно промокли, любое поскальзывание (даже на обычном мокром полу) заставит вас буквально улететь.",
	))
	return perks


/datum/species/akula/randomize_features(mob/living/carbon/human/human_mob)
	var/list/features = ..()
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of sharkish colors, with a whiter secondary and tertiary
	switch(random)
		if(1)
			main_color = "#668899"
			second_color = "#BBCCDD"
		if(2)
			main_color = "#334455"
			second_color = "#DDDDEE"
		if(3)
			main_color = "#445566"
			second_color = "#DDDDEE"
		if(4)
			main_color = "#666655"
			second_color = "#DDDDEE"
		if(5)
			main_color = "#444444"
			second_color = "#DDDDEE"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = second_color
	features[FEATURE_MUTANT_COLOR_THREE] = second_color
	return features

/datum/species/akula/prepare_human_for_preview(mob/living/carbon/human/akula)
	var/main_color = "#668899"
	var/secondary_color = "#BBCCDD"
	var/second_color = "#4FDCF3"

	akula.set_haircolor("#0C45B3", update = FALSE) // pink
	akula.set_hairstyle("Comet", update = TRUE)

	akula.dna.features[FEATURE_MUTANT_COLOR] = main_color
	akula.dna.features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	akula.dna.features[FEATURE_MUTANT_COLOR_THREE] = second_color
	akula.dna.mutant_bodyparts[FEATURE_SNOUT] = build_mutant_part("Otie", list(main_color, secondary_color, second_color))
	akula.dna.mutant_bodyparts[FEATURE_TAIL] = build_mutant_part("Data shark", list(main_color, secondary_color, second_color))
	akula.dna.mutant_bodyparts[FEATURE_EARS] = build_mutant_part("Hare", list(main_color, second_color, second_color))
	akula.dna.features[FEATURE_LEGS] = NORMAL_LEGS
	regenerate_organs(akula, src, visual_only = TRUE)
	akula.update_body(TRUE)

/datum/species/akula/get_random_body_markings(list/passed_features)
	var/datum/body_marking_set/body_marking_set = GLOB.body_marking_sets["Akula"]
	var/list/markings = list()
	if(body_marking_set)
		markings = assemble_body_markings_from_set(body_marking_set, passed_features, src)
	return markings

/datum/species/akula/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)
	//should not call parent
	if(job?.akula_outfit)
		equipping.equipOutfit(job.akula_outfit, visuals_only)

///Organ overwrites

// set bonus
/datum/status_effect/organ_set_bonus/carp/akula
	id = "organ_set_bonus_carp_akula"
	limb_texture = null // no carpskin

//Eyes
/obj/item/organ/eyes/akula
	// Eyes over hair as bandaid for the low amounts of head matching hair
	eyes_layer = HAIR_LAYER-0.1

//Brain
/obj/item/organ/brain/carp/akula
	name = "azulean brain"

/obj/item/organ/brain/carp/akula/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bubble_icon_override, "fish", BUBBLE_ICON_PRIORITY_ORGAN)
	RemoveElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp/akula)

//Heart
/obj/item/organ/heart/carp/akula
	name = "azulean heart"
	organ_traits = list()

/obj/item/organ/heart/carp/akula/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp/akula)

//Tongue
/obj/item/organ/tongue/carp/akula
	name = "azulean jaws"
	liked_foodtypes = SEAFOOD | RAW
	disliked_foodtypes = CLOTH | DAIRY
	toxic_foodtypes = TOXIC

/obj/item/organ/tongue/carp/akula/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp/akula)

/obj/item/organ/tongue/carp/akula/on_mob_insert(mob/living/carbon/tongue_owner, special, movement_flags)
	. = ..()
	if(!ishuman(tongue_owner))
		return
	var/mob/living/carbon/human/human_receiver = tongue_owner
	if(!human_receiver.can_mutate())
		return
	var/datum/species/rec_species = human_receiver.dna.species
	rec_species.update_no_equip_flags(tongue_owner, initial(rec_species.no_equip_flags))

//Lungs
/obj/item/organ/lungs/carp/akula
	name = "azulean lungs"
	safe_oxygen_min = /obj/item/organ/lungs::safe_oxygen_min
	safe_oxygen_max = /obj/item/organ/lungs::safe_oxygen_max

/obj/item/organ/lungs/carp/akula/Initialize(mapload)
	organ_traits -= TRAIT_NO_BREATHLESS_DAMAGE
	. = ..()
	RemoveElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp/akula)


// Wet_stacks handling
// more about grab_resists in `code\modules\mob\living\living.dm` at li 1119
// more about slide_distance in `code\game\turfs\open\_open.dm` at li 233
/// Lets register the signal which calls when we are above 10 wet_stacks
/datum/species/akula/on_species_gain(mob/living/carbon/akula, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	RegisterSignal(akula, COMSIG_MOB_TRIGGER_WET_SKIN, PROC_REF(wetted), akula)
	// lets give 15 wet_stacks on initial
	akula.set_wet_stacks(WETSTACK_INITIAL, remove_fire_stacks = FALSE)

/// Remove the signal on species loss
/datum/species/akula/on_species_loss(mob/living/carbon/akula, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(akula, COMSIG_MOB_TRIGGER_WET_SKIN)

/// This proc is called when a mob with TRAIT_SLICK_SKIN gains over 10 wet_stacks
/datum/species/akula/proc/wetted(mob/living/carbon/akula)
	SIGNAL_HANDLER
	// Apply the slippery trait if it's not there yet
	if(!HAS_TRAIT(akula, TRAIT_SLIPPERY))
		ADD_TRAIT(akula, TRAIT_SLIPPERY, SPECIES_TRAIT)

	// Relieve the negative moodlet
	akula.clear_mood_event("dry_skin")
	// The timer which will initiate above 10 wet_stacks, and call dried() once the timer runs out
	dry_up_timer = addtimer(CALLBACK(src, PROC_REF(dried), akula), DRY_UP_TIME, TIMER_UNIQUE | TIMER_STOPPABLE | TIMER_DELETE_ME)

/// This proc is called after a mob with the TRAIT_SLIPPERY has its related timer run out
/datum/species/akula/proc/dried(mob/living/carbon/akula)
	// A moodlet which will not go away until the user gets wet
	akula?.add_mood_event("dry_skin", /datum/mood_event/dry_skin)

/// A simple overwrite which calls parent to listen to wet_stacks
/datum/status_effect/fire_handler/wet_stacks/tick(delta_time)
	. = ..()
	if(!owner)
		return
	if(HAS_TRAIT(owner, TRAIT_SLICK_SKIN) && stacks >= WETSTACK_THRESHOLD)
		SEND_SIGNAL(owner, COMSIG_MOB_TRIGGER_WET_SKIN)

	if(HAS_TRAIT(owner, TRAIT_SLIPPERY) && stacks <= 0.5) // Removed just before we hit 0 and delete the /status_effect/
		REMOVE_TRAIT(owner, TRAIT_SLIPPERY, SPECIES_TRAIT)

#undef DRY_UP_TIME
#undef WETSTACK_INITIAL
#undef WETSTACK_THRESHOLD
