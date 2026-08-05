/datum/species/moth
	name = "\improper Моль"
	plural_form = "Моли"
	id = SPECIES_MOTH
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	/* NOVA EDIT REMOVAL START - Customization
	body_markings = list(
		/datum/bodypart_overlay/simple/body_marking/moth = SPRITE_ACCESSORY_NONE,
	)
	mutant_organs = list(
		/obj/item/organ/wings/moth = "Plain",
		/obj/item/organ/antennae = "Plain",
	)
	*/ // NOVA EDIT REMOVAL END
	meat = /obj/item/food/meat/slab/human/mutant/moth
	mutanttongue = /obj/item/organ/tongue/moth
	mutanteyes = /obj/item/organ/eyes/moth
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	species_cookie = /obj/item/food/muffin/moffin
	species_language_holder = /datum/language_holder/moth
	death_sound = 'sound/mobs/humanoids/moth/moth_death.ogg'
	payday_modifier = 1.0
	family_heirlooms = list(/obj/item/flashlight/lantern/heirloom_moth)

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/moth,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/moth,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/moth,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/moth,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/moth,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/moth,
	)

/datum/species/moth/randomize_features()
	var/list/features = ..()
	features[FEATURE_MOTH_MARKINGS] = pick(SSaccessories.feature_list[FEATURE_MOTH_MARKINGS])
	return features

/datum/species/moth/get_scream_sound(mob/living/carbon/human/moth)
	return 'sound/mobs/humanoids/moth/scream_moth.ogg'

/datum/species/moth/get_cough_sound(mob/living/carbon/human/moth)
	if(moth.physique == FEMALE)
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


/datum/species/moth/get_cry_sound(mob/living/carbon/human/moth)
	if(moth.physique == FEMALE)
		return pick(
			'sound/mobs/humanoids/human/cry/female_cry1.ogg',
			'sound/mobs/humanoids/human/cry/female_cry2.ogg',
		)
	return pick(
		'sound/mobs/humanoids/human/cry/male_cry1.ogg',
		'sound/mobs/humanoids/human/cry/male_cry2.ogg',
		'sound/mobs/humanoids/human/cry/male_cry3.ogg',
	)


/datum/species/moth/get_sneeze_sound(mob/living/carbon/human/moth)
	if(moth.physique == FEMALE)
		return 'sound/mobs/humanoids/human/sneeze/female_sneeze1.ogg'
	return 'sound/mobs/humanoids/human/sneeze/male_sneeze1.ogg'


/datum/species/moth/get_laugh_sound(mob/living/carbon/human/moth)
	return 'sound/mobs/humanoids/moth/moth_laugh1.ogg'

/datum/species/moth/get_sigh_sound(mob/living/carbon/human/moth)
	if(moth.physique == FEMALE)
		return SFX_FEMALE_SIGH
	return SFX_MALE_SIGH

/datum/species/moth/get_sniff_sound(mob/living/carbon/human/moth)
	if(moth.physique == FEMALE)
		return 'sound/mobs/humanoids/human/sniff/female_sniff.ogg'
	return 'sound/mobs/humanoids/human/sniff/male_sniff.ogg'

/datum/species/moth/get_physical_attributes()
	return "Моли обладают большими пушистыми крыльями, которые помогают им перемещаться по станции при отключённой гравитации, \
		отталкивая окружающий воздух. Из-за этого принципа работы крылья бесполезны в открытом космосе. Их глаза также крайне чувствительны к свету."

/datum/species/moth/get_species_description()
	return "Выходцы с планеты, которая была потеряна давным-давно, Моли путешествуют \
		по галактике как кочевой народ на борту колоссального флота кораблей в поисках новой родины."

/datum/species/moth/get_species_lore()
	return list(
		"Потеряв свой родной мир в веках, Моли живут на борту Великого Кочевого Флота. \
		Собранная из всего, что удалось найти, выменять, починить или украсть, эта армада представляет собой колоссальное лоскутное одеяло, \
		построенное на истории вежливого торможения путешественников и изъятия их пожитков. Время от времени моль решает покинуть флот — \
		обычно ради поисков богатства, которое можно отправить обратно домой.",

		"Кочевая жизнь порождает сплочённую культуру, в которой Моли высоко ценят своих друзей, семью и корабли. \
		По природе своей они очень общительны и лучше всего чувствуют себя в коллективе. Это сослужило им хорошую службу на галактической арене, \
		позволив сохранить дружелюбную и обаятельную репутацию даже перед лицом враждебных столкновений. \
		Похоже, галактика в конце концов приняла этих бывших пиратов.",

		"Удивительно, но совместная жизнь в гигантском флоте не стёрла различия в диалектах и культуре. \
		Эти различия только приветствуются и поощряются внутри флота ради разнообразия, которое они приносят."
	)


/datum/species/moth/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "feather-alt",
			SPECIES_PERK_NAME = "Драгоценные крылья",
			SPECIES_PERK_DESC = "Моли могут летать в невесомости при наличии давления воздуха и безопасно приземляться при падении с небольшой высоты благодаря своим крыльям.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "tshirt",
			SPECIES_PERK_NAME = "Диета из гардероба",
			SPECIES_PERK_DESC = "Моли могут питаться одеждой для насыщения и восстановления сил.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fire",
			SPECIES_PERK_NAME = "Воспламеняемые крылья",
			SPECIES_PERK_DESC = "Крылья Молей невероятно хрупкие — огонь может запросто и быстро их сжечь.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "sun",
			SPECIES_PERK_NAME = "Яркий свет",
			SPECIES_PERK_DESC = "Молям необходима дополнительная защита глаз от вспышек (например, от флешек офицеров СБ или при сварке). \
				Сварочные маски отлично для этого подойдут.",
		),
	)

	return to_add
