/datum/species/abductor
	name = "Абдуктор"
	plural_form = "Абдукторы"
	id = SPECIES_ABDUCTOR
	sexes = FALSE
	inherent_traits = list(
		TRAIT_ABDUCTOR_HUD,
		TRAIT_CHUNKYFINGERS_IGNORE_BATON,
		TRAIT_NEVER_WOUNDED,
		TRAIT_NOBLOOD,
		TRAIT_NOBREATH,
		TRAIT_NODISMEMBER,
		TRAIT_NOHUNGER,
		TRAIT_NO_UNDERWEAR,
		TRAIT_VIRUSIMMUNE,
	)
	mutanttongue = /obj/item/organ/tongue/abductor
	mutantstomach = null
	mutantheart = null
	mutantlungs = null
	mutantbrain = /obj/item/organ/brain/abductor
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/abductor,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/abductor,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/abductor,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/abductor,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/abductor,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/abductor,
	)

/datum/species/abductor/get_physical_attributes()
	return "Абдукторам не нужно дышать или есть. У них нет крови, сердца, желудка или лёгких, \
		и они полностью невосприимчивы к человеческим вирусам. Их прочное телосложение защищает \
		кожу от ран и расчленения, но их массивные трехпалые руки сильно затрудняют использование человеческого оборудования."

/datum/species/abductor/get_species_description()
	return "Абдукторы, в просторечии известные как «Серые», представляют собой трехпалых \
		бледнокожих любознательных пришельцев, которые не способны нормально общаться с обычными членами экипажа."

/datum/species/abductor/get_species_lore()
	return list(
		"Об Абдукторах мало что известно. \
		Хотя они (как вид) славятся похищением других рас «низшего интеллекта» ради проведения экспериментов, \
		в редких случаях некоторые из них сотрудничают с теми самыми видами, которые похищают, по неизвестным причинам.",
	)


/datum/species/abductor/create_pref_traits_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_WIND,
		SPECIES_PERK_NAME = "Лёгкие не нужны",
		SPECIES_PERK_DESC = "Абдукторам не нужно дышать, хотя нахождение в открытом космосе всё ещё представляет опасность из-за давления.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SHIELD,
		SPECIES_PERK_NAME = "Стойкая кожа",
		SPECIES_PERK_DESC = "Серая кожа Абдукторов невероятно прочная и устойчивая. \
			Их невозможно ранить или расчленить обычными средствами.",
	))
	return perks

/datum/species/abductor/create_pref_unique_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SYRINGE,
		SPECIES_PERK_NAME = "Иммунитет к болезням",
		SPECIES_PERK_DESC = "Абдукторы полностью невосприимчивы ко всем вирусным инфекциям, встречающимся на станции.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK, // It may be a stretch to call nohunger a neutral perk but the Abductor's tongue describes it as much, so.
		SPECIES_PERK_ICON = FA_ICON_UTENSILS,
		SPECIES_PERK_NAME = "Голод к знаниям",
		SPECIES_PERK_DESC = "Абдукторы испытывают гораздо больший голод к знаниям, нежели к еде, и поэтому не нуждаются в пище. \
			Что весьма удачно, ведь их речевая матрица физически не позволяет им поглощать пищу.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_VOLUME_XMARK,
		SPECIES_PERK_NAME = "Суперлингвальная матрица",
		SPECIES_PERK_DESC = "Абдукторы физически не способны говорить обычным языком. \
			Вместо этого они общаются телепатически с другими Абдукторами, и этот процесс скрыт от всех остальных рас. \
			Отлично подходит для секретных разговоров, но не очень — для заказа выпивки в баре.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_HANDSHAKE_SLASH,
		SPECIES_PERK_NAME = "Трёхпалые руки",
		SPECIES_PERK_DESC = "Руки Абдукторов не предназначены для человеческого инвентаря. Использование оборудования станции даётся им с трудом.",
	))
	return perks

