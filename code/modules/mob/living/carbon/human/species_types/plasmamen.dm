/datum/species/plasmaman
	name = "\improper plasmaman"
	plural_form = "plasmamans"
	id = SPECIES_PLASMAMAN
	sexes = FALSE
	meat = /obj/item/stack/sheet/mineral/plasma
	// plasmemes get hard to wound since they only need a severe bone wound to dismember, but unlike skellies, they can't pop their bones back into place
	inherent_traits = list(
		TRAIT_GENELESS,
		TRAIT_HARDLY_WOUNDED,
		TRAIT_NOBLOOD,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_PLASMA_TRANSFORM,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_UNHUSKABLE,
	)

	inherent_biotypes = MOB_HUMANOID|MOB_MINERAL|MOB_SKELETAL
	mutantlungs = /obj/item/organ/lungs/plasmaman
	smoker_lungs = /obj/item/organ/lungs/plasmaman/plasmaman_smoker
	mutanttongue = /obj/item/organ/tongue/bone/plasmaman
	mutantliver = /obj/item/organ/liver/bone/plasmaman
	mutantstomach = /obj/item/organ/stomach/bone/plasmaman
	mutantappendix = null
	mutantheart = null
	heatmod = 1.5
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | ERT_SPAWN
	species_cookie = /obj/item/reagent_containers/condiment/milk
	outfit_important_for_life = /datum/outfit/plasmaman
	species_language_holder = /datum/language_holder/skeleton

	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/plasmaman,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/plasmaman,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/plasmaman,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/plasmaman,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/plasmaman,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/plasmaman,
	)

	// Body temperature for Plasmen is much lower human as they can handle colder environments
	bodytemp_normal = (BODYTEMP_NORMAL - 40)
	// The minimum amount they stabilize per tick is reduced making hot areas harder to deal with
	bodytemp_autorecovery_min = 2
	// They are hurt at hot temps faster as it is harder to hold their form
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 20) // about 40C
	// This effects how fast body temp stabilizes, also if cold resit is lost on the mob
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 50) // about -50c

	outfit_override_registry = list(
		/datum/outfit/ninja = /datum/outfit/ninja/plasmaman,
		/datum/outfit/syndicate = /datum/outfit/syndicate/plasmaman,
		/datum/outfit/syndicate/full = /datum/outfit/syndicate/full/plasmaman,
		/datum/outfit/syndicate/leader = /datum/outfit/syndicate/leader/plasmaman,
		/datum/outfit/syndicate/reinforcement = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/reinforcement/cybersun = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/reinforcement/donk = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/reinforcement/gorlex = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/reinforcement/interdyne = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/reinforcement/mi13 = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/reinforcement/waffle = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/support = /datum/outfit/syndicate/support/plasmaman,
		/datum/outfit/syndicate/full/loneop = /datum/outfit/syndicate/full/plasmaman/loneop,
	)

/datum/species/plasmaman/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)
	if(job?.plasmaman_outfit)
		equipping.equipOutfit(job.plasmaman_outfit, visuals_only)
	else
		give_important_for_life(equipping)

/datum/species/plasmaman/get_scream_sound(mob/living/carbon/human)
	return pick(
		'sound/mobs/humanoids/plasmaman/plasmeme_scream_1.ogg',
		'sound/mobs/humanoids/plasmaman/plasmeme_scream_2.ogg',
		'sound/mobs/humanoids/plasmaman/plasmeme_scream_3.ogg',
	)

/datum/species/plasmaman/get_physical_attributes()
	return "Плазмомены в буквальном смысле живут и дышат плазмой. Они самовозгораются при малейшем контакте с кислородом, \
		и помимо всех вытекающих из этого трудностей, они крайне уязвимы к любому физическому урону из-за своей хрупкой структуры."

/datum/species/plasmaman/get_species_description()
	return "Обнаруженные на ледяной луне Фрейя, Плазмомены состоят из колониальных \
		грибковых организмов, которые вместе образуют разумное существо. В человеческом космосе \
		они обычно прикрепляются к скелетам, чтобы придать им более привычный людям вид."

/datum/species/plasmaman/get_species_lore()
	return list(
		"Крайне запутанный вид: Плазмомены — это буквально «грибы среди нас». \
		То, что кажется единым живым существом, на самом деле является колонией из миллионов микроорганизмов, \
		облепивших найденный (или предоставленный) человеческий скелет.",

		"Изначально они были обнаружены НаноТрейзен, когда один из исследователей случайно упал в открытый резервуар с жидкой плазмой. \
		Ранее незамеченная грибковая колония полностью захватила тело, создав первого «истинного» Плазмолюда. С тех пор этот процесс \
		был поставлен на поток благодаря щедрым пожертвованиям трупов заключённых, и Плазмомены начали массово внедряться на объекты НТ для усиления рабочей силы.",

		"Будучи новичками на галактической арене, Плазмомены представляют собой чистый лист. \
		Их внешний вид, который обычно называют «упыриным», внушает немало опасений их коллегам по экипажу. \
		Возможно, всё дело в концепции «пылающего фиолетового скелета».",

		"Микроорганизмы, из которых состоят Плазмомены, нуждаются в богатой плазмой атмосфере, в которой они эволюционировали. \
		Их псевдонервная система работает за счёт внешних электрических импульсов, которые мгновенно воспламеняют их состоящие из плазмы тела при наличии кислорода."
	)

/datum/species/plasmaman/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "user-shield",
			SPECIES_PERK_NAME = "Защищённость",
			SPECIES_PERK_DESC = "Плазмолюды полностью невосприимчивы к радиации, ядам и большинству известных болезней.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bone",
			SPECIES_PERK_NAME = "Стойкость к ранениям",
			SPECIES_PERK_DESC = "Плазмолюды обладают повышенной устойчивостью к физическому урону, который нанёс бы глубокие раны другим расам.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "wind",
			SPECIES_PERK_NAME = "Плазменное исцеление",
			SPECIES_PERK_DESC = "Плазмолюды могут залечивать свои повреждения и раны, поглощая чистую плазму.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "hard-hat",
			SPECIES_PERK_NAME = "Защитный шлем",
			SPECIES_PERK_DESC = "Шлем Плазмолюда защищает глаза от вспышек сварки, а также имеет встроенный налобный фонарик.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fire",
			SPECIES_PERK_NAME = "Живой факел",
			SPECIES_PERK_DESC = "Плазмолюды мгновенно воспламеняются, как только их тело вступает в контакт с кислородом.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "briefcase-medical",
			SPECIES_PERK_NAME = "Сложная биология",
			SPECIES_PERK_DESC = "Для лечения Плазмолюдов требуются специализированные медицинские знания. \
				Не рассчитывайте на быстрое клонирование или реанимацию, если вам вообще повезёт вернуться к жизни.",
		),
	)

	return to_add
