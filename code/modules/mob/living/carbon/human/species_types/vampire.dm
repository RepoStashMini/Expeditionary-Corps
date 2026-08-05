
///how many vampires exist in each house
#define VAMPIRES_PER_HOUSE 5
///maximum a vampire will drain, they will drain less if they hit their cap
#define VAMP_DRAIN_AMOUNT 50

/datum/species/human/vampire
	name = "Вампир"
	id = SPECIES_VAMPIRE
	examine_limb_id = SPECIES_HUMAN
	inherent_traits = list(
		TRAIT_BLOOD_CLANS,
		TRAIT_USES_SKINTONES,
		TRAIT_NO_MIRROR_REFLECTION,
	)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN | MIRROR_PRIDE | WABBAJACK | ERT_SPAWN
	exotic_bloodtype = BLOOD_TYPE_VAMPIRE
	blood_deficiency_drain_rate = BLOOD_DEFICIENCY_MODIFIER // vampires already passively lose blood, so this just makes them lose it slightly more quickly when they have blood deficiency.
	mutantheart = /obj/item/organ/heart/vampire
	mutanttongue = /obj/item/organ/tongue/vampire
	///some starter text sent to the vampire initially, because vampires have shit to do to stay alive
	var/info_text = "You are a <span class='danger'>Vampire</span>. You will slowly but constantly lose blood if outside of a coffin. If inside a coffin, you will slowly heal. You may gain more blood by grabbing a live victim and using your drain ability."

/datum/species/human/vampire/check_roundstart_eligible()
	if(check_holidays(HALLOWEEN))
		return TRUE
	return ..()

/datum/species/human/vampire/on_species_gain(mob/living/carbon/human/new_vampire, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	to_chat(new_vampire, "[info_text]")
	new_vampire.skin_tone = "albino"
	RegisterSignal(new_vampire, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(new_vampire, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))
	RegisterSignal(new_vampire, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	if(new_vampire.hud_used)
		on_hud_created(new_vampire)

/datum/species/human/vampire/on_species_loss(mob/living/carbon/human/old_vampire, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(old_vampire, list(
		COMSIG_ATOM_ATTACKBY,
		COMSIG_MOB_HUD_CREATED,
		COMSIG_LIVING_LIFE,
	))
	old_vampire.hud_used?.remove_screen_object(HUD_MOB_BLOOD_LEVEL)

/datum/species/human/vampire/proc/on_life(mob/living/carbon/human/vampire, seconds_per_tick)
	SIGNAL_HANDLER
	if(istype(vampire.loc, /obj/structure/closet/crate/coffin))
		var/need_mob_update = FALSE
		need_mob_update += vampire.heal_overall_damage(brute = 2 * seconds_per_tick, burn = 2 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
		need_mob_update += vampire.adjust_tox_loss(-2 * seconds_per_tick, updating_health = FALSE,)
		need_mob_update += vampire.adjust_oxy_loss(-2 * seconds_per_tick, updating_health = FALSE,)
		if(need_mob_update)
			vampire.updatehealth()
		return
	vampire.adjust_blood_volume(-0.125 * seconds_per_tick)
	if(vampire.get_blood_volume(apply_modifiers = TRUE) <= BLOOD_VOLUME_SURVIVE)
		to_chat(vampire, span_danger("You ran out of blood!"))
		vampire.investigate_log("has been dusted by a lack of blood (vampire).", INVESTIGATE_DEATHS)
		vampire.dust()
	var/area/A = get_area(vampire)
	if(istype(A, /area/station/service/chapel))
		to_chat(vampire, span_warning("You don't belong here!"))
		vampire.adjust_fire_loss(10 * seconds_per_tick)
		vampire.adjust_fire_stacks(3 * seconds_per_tick)
		vampire.ignite_mob()

///Gives the blood HUD to the vampire so they always know how much blood they have.
/datum/species/human/vampire/proc/on_hud_created(mob/source)
	SIGNAL_HANDLER
	source.hud_used.add_screen_object(/atom/movable/screen/blood_level, HUD_MOB_BLOOD_LEVEL, HUD_GROUP_INFO, update_screen = TRUE)

/datum/species/human/vampire/proc/on_attackby(mob/living/source, obj/item/attacking_item, mob/living/attacker, list/modifiers, list/attack_modifiers)
	SIGNAL_HANDLER

	if(istype(attacking_item, /obj/item/nullrod/whip))
		MODIFY_ATTACK_FORCE_MULTIPLIER(attack_modifiers, 2)

/datum/species/human/vampire/get_physical_attributes()
	return "Вампиры поражены Жаждой, которую они вынуждены утолять, высасывая кровь из других живых существ. При этом они не нуждаются в обычном дыхании или пище. \
		Они мгновенно превращаются в прах, если у них полностью закончится кровь или если они вступят на святую землю. Однако гробы стабилизируют и исцеляют их, а ещё они умеют превращаться в летучих мышей!"

/datum/species/human/vampire/get_species_description()
	return "Первоклассный Вампир! Они слетаются на Космическую Станцию Тринадцать каждый год, чтобы нагнать жути на экипаж! «Бли-и-иг!!»"

/datum/species/human/vampire/get_species_lore()
	return list(
		"Вампиры — нечестивые существа, благословенные и одновременно проклятые Жаждой. \
		Жажда заставляет их пировать кровью ради поддержания жизни, а взамен дарует множество бонусов. \
		Из-за этого Вампиры разделились на два клана: один принимает свои силы как благословение, а другой отвергает их.",
	)

/datum/species/human/vampire/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bed",
			SPECIES_PERK_NAME = "Раздумья в гробу",
			SPECIES_PERK_DESC = "Вампиры могут временно отсрочить Жажду и исцелить свои раны, отдыхая в гробу. Так вот ПОЧЕМУ они это делают!",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "book-dead",
			SPECIES_PERK_NAME = "Вампирские кланы",
			SPECIES_PERK_DESC = "Вампиры принадлежат к одному из двух кланов — Привитые (Inoculated) и Изгои (Outcast). Изгои \
				игнорируют большинство вампирских традиций, в то время как Привитые получают уникальные имена и лорное описание.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "cross",
			SPECIES_PERK_NAME = "Против Бога и природы",
			SPECIES_PERK_DESC = "Почти все высшие силы испытывают отвращение к самому факту существования \
				Вампиров, поэтому визит в Церковь для них — это буквально самоубийство. Не делайте этого!",
		),
	)

	return to_add

// Vampire blood is special, so it needs to be handled with its own entry.
/datum/species/human/vampire/create_pref_blood_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "tint",
		SPECIES_PERK_NAME = "Жажда",
		SPECIES_PERK_DESC = "Вместо потребности в еде Вампиры страдают от Жажды. \
			Жажды чего? Крови! Их язык позволяет им хватать существ и пить \
			их кровь, и они погибнут, если она полностью иссякнет. К слову, \
			абсолютно неважно, чью именно кровь вы пьёте — при поглощении она \
			в любом случае будет преобразована в вашу собственную группу крови.",
	))

	return to_add

// There isn't a "Minor Undead" biotype, so we have to explain it in an override (see: dullahans)
/datum/species/human/vampire/create_pref_biotypes_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "skull",
		SPECIES_PERK_NAME = "Низшая нежить",
		SPECIES_PERK_DESC = "[name] относятся к низшей нежити. \
			Низшая нежить пользуется некоторыми преимуществами мертвецов — например, \
			отсутствием необходимости дышать или есть, но не получает большинства \
			иммунитетов к окружающей среде, которые есть у полноценной нежити.",
	))

	return to_add


/obj/item/organ/tongue/vampire
	name = "vampire teeth"
	desc = "The only thing with which it's acceptable to say \"I will suck you dry!\""
	icon_state = "tongue_vampire"
	actions_types = list(/datum/action/item_action/organ_action/vampire)
	organ_traits = list(
		TRAIT_DRINKS_BLOOD,
		// future todo : tie nobreath and nohunger to a vampire organ set bonus
		TRAIT_NOBREATH,
		TRAIT_NOHUNGER,
	)
	COOLDOWN_DECLARE(drain_cooldown)

/obj/item/organ/tongue/vampire/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	RegisterSignal(receiver, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(stab_bloodbag))

/obj/item/organ/tongue/vampire/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(organ_owner, COMSIG_ATOM_ITEM_INTERACTION)

/obj/item/organ/tongue/vampire/proc/stab_bloodbag(mob/living/source, mob/living/user,  obj/item/used_item, list/modifiers)
	SIGNAL_HANDLER

	if(user != source)
		return NONE
	if(!istype(used_item, /obj/item/reagent_containers/blood))
		return NONE
	if(used_item.reagents?.total_volume <= 0)
		to_chat(user, span_warning("[src] is empty!"))
		return ITEM_INTERACT_BLOCKING

	user.visible_message(
		span_notice("[user] stabs [used_item] with [user.p_their()] sharp teeth and drains its contents!"),
		span_notice("You stab [used_item] with your sharp teeth and drain its contents!"),
		span_hear("You hear a stabbing sound! ... Followed by slurping?"),
		COMBAT_MESSAGE_RANGE,
	)
	INVOKE_ASYNC(src, PROC_REF(async_stab_bloodbag), user, used_item)
	return ITEM_INTERACT_BLOCKING

/obj/item/organ/tongue/vampire/proc/async_stab_bloodbag(mob/living/carbon/user, obj/item/reagent_containers/blood/bloodbag, time = 0.5 SECONDS)
	if(!do_after(user, time, bloodbag))
		return

	to_chat(user, span_notice("You swallow a gulp of [src]."))
	playsound(bloodbag, 'sound/items/drink.ogg', 50, TRUE) //slurp
	bloodbag.reagents.trans_to(user, bloodbag.reagents.maximum_volume * 0.05, transferred_by = user, methods = INGEST)
	if(bloodbag.reagents.total_volume > 0)
		async_stab_bloodbag(user, bloodbag, 1 SECONDS)

/datum/action/item_action/organ_action/vampire
	name = "Drain Victim"
	desc = "Leech blood from any carbon victim you are passively grabbing."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "drain_victim"
	background_icon_state = "bg_vampire"

/datum/action/item_action/organ_action/vampire/do_effect(trigger_flags)
	if(!iscarbon(owner))
		return FALSE

	var/mob/living/carbon/user = owner
	var/obj/item/organ/tongue/vampire/licker_drinker = target
	if(!COOLDOWN_FINISHED(licker_drinker, drain_cooldown))
		to_chat(user, span_warning("You just drained blood, wait a few seconds!"))
		return FALSE

	if(!iscarbon(user.pulling))
		return FALSE

	var/mob/living/carbon/victim = user.pulling
	if(user.get_blood_volume() >= BLOOD_VOLUME_MAXIMUM)
		to_chat(user, span_warning("You're already full!"))
		return FALSE
	if(victim.stat == DEAD)
		to_chat(user, span_warning("You need a living victim!"))
		return FALSE
	var/blood_name = LOWER_TEXT(user.get_bloodtype()?.get_blood_name())
	if(!victim.get_blood_volume() || victim.get_blood_reagent() != user.get_blood_reagent())
		if (blood_name)
			to_chat(user, span_warning("[victim] doesn't have [blood_name]!"))
		else
			to_chat(user, span_warning("[victim] doesn't have anything inside of them you could stomach!"))
		return FALSE
	COOLDOWN_START(licker_drinker, drain_cooldown, 3 SECONDS)
	if(victim.can_block_magic(MAGIC_RESISTANCE_HOLY, charge_cost = 0))
		victim.show_message(span_warning("[user] tries to bite you, but stops before touching you!"))
		to_chat(user, span_warning("[victim] is blessed! You stop just in time to avoid catching fire."))
		return FALSE
	if(victim.has_reagent(/datum/reagent/consumable/garlic))
		victim.show_message(span_warning("[user] tries to bite you, but recoils in disgust!"))
		to_chat(user, span_warning("[victim] reeks of garlic! you can't bring yourself to drain such tainted blood."))
		return FALSE
	if(!do_after(user, 3 SECONDS, target = victim, hidden = TRUE))
		return FALSE

	victim.show_message(span_danger("[user] is draining your blood!"))
	to_chat(user, span_notice("You drain some blood!"))
	playsound(user, 'sound/items/drink.ogg', 30, TRUE, -2)

	// Since we adjust the user first, we need to take the victim's blood volume into account.
	var/amount_drained = min(VAMP_DRAIN_AMOUNT, victim.get_blood_volume())

	// Takes into account how much blood the vampire can take.
	amount_drained = user.adjust_blood_volume(amount_drained)

	victim.adjust_blood_volume(-amount_drained)

	if(!victim.get_blood_volume())
		to_chat(user, span_notice("You finish off [victim]'s [blood_name] supply."))
	return TRUE

/obj/item/organ/heart/vampire
	name = "vampire heart"
	icon_state = "heart_vampire"
	desc = "Some guy stabbed his brother 6,000 years ago so now you have this."

#undef VAMPIRES_PER_HOUSE
#undef VAMP_DRAIN_AMOUNT
