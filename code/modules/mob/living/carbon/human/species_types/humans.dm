/datum/species/human
	name = "\improper Человек"
	id = SPECIES_HUMAN
	inherent_traits = list(
		TRAIT_USES_SKINTONES,
	)
	skinned_type = /obj/item/stack/sheet/animalhide/carbon/human
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 1.1

/datum/species/human/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#bb9966", update = FALSE) // brown
	human.set_hairstyle("Business Hair", update = TRUE)

/datum/species/human/get_scream_sound(mob/living/carbon/human/human)
	if(human.physique == MALE)
		if(prob(1))
			return 'sound/mobs/humanoids/human/scream/wilhelm_scream.ogg'
		return pick(
			'sound/mobs/humanoids/human/scream/malescream_1.ogg',
			'sound/mobs/humanoids/human/scream/malescream_2.ogg',
			'sound/mobs/humanoids/human/scream/malescream_3.ogg',
			'sound/mobs/humanoids/human/scream/malescream_4.ogg',
			'sound/mobs/humanoids/human/scream/malescream_5.ogg',
			'sound/mobs/humanoids/human/scream/malescream_6.ogg',
		)

	return pick(
		'sound/mobs/humanoids/human/scream/femalescream_1.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_2.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_3.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_4.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_5.ogg',
	)

/datum/species/human/get_cough_sound(mob/living/carbon/human/human)
	if(human.gender == FEMALE) // NOVA EDIT CHANGE - ORIGINAL: if(human.physique == FEMALE)
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

/datum/species/human/get_cry_sound(mob/living/carbon/human/human)
	if(human.gender == FEMALE) // NOVA EDIT CHANGE - ORIGINAL: if(human.physique == FEMALE)
		return pick(
			'sound/mobs/humanoids/human/cry/female_cry1.ogg',
			'sound/mobs/humanoids/human/cry/female_cry2.ogg',
		)
	return pick(
		'sound/mobs/humanoids/human/cry/male_cry1.ogg',
		'sound/mobs/humanoids/human/cry/male_cry2.ogg',
		'sound/mobs/humanoids/human/cry/male_cry3.ogg',
	)


/datum/species/human/get_sneeze_sound(mob/living/carbon/human/human)
	if(human.physique == FEMALE)
		return 'sound/mobs/humanoids/human/sneeze/female_sneeze1.ogg'
	return 'sound/mobs/humanoids/human/sneeze/male_sneeze1.ogg'

/datum/species/human/get_laugh_sound(mob/living/carbon/human/human)
	if(human.physique == FEMALE)
		return 'sound/mobs/humanoids/human/laugh/womanlaugh.ogg'
	return pick(
		'sound/mobs/humanoids/human/laugh/manlaugh1.ogg',
		'sound/mobs/humanoids/human/laugh/manlaugh2.ogg',
	)

/datum/species/human/get_sigh_sound(mob/living/carbon/human/human)
	if(human.physique == FEMALE)
		return SFX_FEMALE_SIGH
	return SFX_MALE_SIGH

/datum/species/human/get_sniff_sound(mob/living/carbon/human/human)
	if(human.physique == FEMALE)
		return 'sound/mobs/humanoids/human/sniff/female_sniff.ogg'
	return 'sound/mobs/humanoids/human/sniff/male_sniff.ogg'

/datum/species/human/get_snore_sound(mob/living/carbon/human/human)
	if(human.physique == FEMALE)
		return SFX_SNORE_FEMALE
	return SFX_SNORE_MALE

/datum/species/human/get_hiss_sound(mob/living/carbon/human/human)
	return 'sound/mobs/humanoids/human/hiss/human_hiss.ogg'

/datum/species/human/get_species_description()
	return "Люди — доминирующий вид в известной галактике. \
		Их род распространился от древней Земли до самых дальних рубежей неизведанного космоса."

/datum/species/human/get_species_description()
	return "Люди — доминирующий вид в известной галактике. \
		Их род распространился от древней Земли до самых дальних рубежей неизведанного космоса."

/datum/species/human/get_species_description()
	return "Люди — доминирующий вид в известной галактике. \
		Их род распространился от древней Земли до самых дальних рубежей неизведанного космоса."

/datum/species/human/get_species_lore()
	return list(
		"Эти потомки приматов, происходящие с преимущественно безвредной Земли, \
		уже давно переросли свой родной дом и статус «умеренно миролюбивых». \
		Космическая эра вывела людей далеко за пределы их солнечной системы на просторы огромной галактики.",

		"В традиционной для себя манере люди совершили этот почти рекордный рывок от тверди земной к последнему рубежу, \
		буквально плюнув в лицо другим расам, с которыми им теперь приходится делить сцену. \
		Сюда же относятся и Унати — если кто и был оскорблён этими выскочками, так это точно их чешуйчатый род.",

		"Человечеству так и не удалось сохранить былое величие под единым знаменем. В процессе разрушительной Великой войны, \
		всепоглощающей коррупции и людских пороков Солнечная Федерация сейчас сжалась практически до границ самой Солнечной системы. \
		Былые окраины раскололись, и теперь угасающее ядро окружают многочисленные мелкие суверенные государства и независимые звёздные системы.",

		"Человеческий дух оппортунизма и предпринимательства продолжает существовать в своей пиковой форме: \
		в лице гиперкорпораций. Действуя вне влияния Солнечной Федерации, как в буквальном, так и в переносном смысле, \
		гиперкорпорации попросту скупают нужные им голоса в сенате и основывают территории далеко за пределами её досягаемости. \
		На территориях гиперкорпораций политика компании — это закон, что придаёт совершенно новый смысл фразе «терминация сотрудника»."
	)




/datum/species/human/create_pref_unique_perks()
	var/list/to_add = list()

	if(CONFIG_GET(number/default_laws) == 0 || CONFIG_GET(flag/silicon_asimov_superiority_override)) // Default lawset is set to Asimov
		to_add += list(list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "robot",
			SPECIES_PERK_NAME = "Превосходство Азимова",
			SPECIES_PERK_DESC = "ИИ и его киборги по умолчанию подчиняются исключительно людям. \
				Как человеку, синтетики обязаны беспрекословно защищать вас и подчиняться вашим приказам.",
		))

	var/human_authority_setting = CONFIG_GET(string/human_authority)

	if(human_authority_setting == HUMAN_AUTHORITY_NON_HUMAN_WHITELIST || human_authority_setting == HUMAN_AUTHORITY_ENFORCED)
		to_add += list(list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bullhorn",
			SPECIES_PERK_NAME = "Цепочка командования",
			SPECIES_PERK_DESC = "НаноТрейзен признаёт право занимать командные должности, такие как Капитан, только за людьми.",
		))


	return to_add
