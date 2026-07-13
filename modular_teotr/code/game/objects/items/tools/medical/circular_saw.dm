//nova code//
//New and improved, no longer a downgrade!
/obj/item/circular_saw/field_medic
	name = "bone saw"
	desc = "An ancient medical instrument used for surgery and amputations, still being used in the 26th century. Well, what are you waiting for? Let's go practice medicine."
	force = 20
	icon_state = "bonesaw"
	icon = 'modular_teotr/Icons/obj/medical/bonesaw.dmi'
	lefthand_file = 'modular_teotr/Icons/mob/inhands/weapons/bonesaw_l.dmi'
	righthand_file = 'modular_teotr/Icons/mob/inhands/weapons/bonesaw_r.dmi'
	inhand_icon_state = "bonesaw"
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	toolspeed = 2
	throw_range = 3
	attack_verb_continuous = list("saws", "slashes")
	attack_verb_simple = list("saw", "slash")
	w_class = WEIGHT_CLASS_SMALL

/obj/item/circular_saw/field_medic/lowforce
	force = 9

/obj/item/circular_saw/field_medic/attack(mob/living/amputee, mob/living/user)
	if(!iscarbon(amputee) || user.combat_mode)
		return ..()

	if(user.zone_selected == BODY_ZONE_CHEST)
		return ..()

	var/mob/living/carbon/patient = amputee

	if(HAS_TRAIT(patient, TRAIT_NODISMEMBER))
		to_chat(user, span_warning("The patient's limbs look too sturdy to amputate."))
		return

	var/candidate_name
	var/obj/item/organ/tail_snip_candidate
	var/obj/item/bodypart/limb_snip_candidate

	if(user.zone_selected == BODY_ZONE_PRECISE_GROIN)
		tail_snip_candidate = patient.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
		if(!tail_snip_candidate)
			to_chat(user, span_warning("[patient] does not have a tail."))
			return
		candidate_name = tail_snip_candidate.name

	else
		limb_snip_candidate = patient.get_bodypart(check_zone(user.zone_selected))
		if(!limb_snip_candidate)
			to_chat(user, span_warning("[patient] is already missing that limb, what more do you want?"))
			return
		candidate_name = limb_snip_candidate.name

	var/amputation_speed_mod = 1

	patient.visible_message(span_danger("[user] begins sawing off [patient]'s [candidate_name] with [src]!"), span_userdanger("[user] begins sawing off your [candidate_name] with [src]!"))
	playsound(get_turf(patient), 'sound/items/weapons/bladeslice.ogg', 250, TRUE)
	if(patient.stat >= UNCONSCIOUS || HAS_TRAIT(patient, TRAIT_INCAPACITATED)) //if you're incapacitated (due to paralysis, a stun, being in staminacrit, etc.), critted, unconscious, or dead, it's much easier to properly line up a snip
		amputation_speed_mod *= 0.5
	if(patient.stat != DEAD && patient.has_status_effect(/datum/status_effect/jitter)) //jittering will make it harder to secure the shears, even if you can't otherwise move
		amputation_speed_mod *= 1.5 //15*0.5*1.5=11.25, so staminacritting someone who's jittering (from, say, a stun baton) won't give you enough time to snip their head off, but staminacritting someone who isn't jittering will
	if(HAS_MIND_TRAIT(user, TRAIT_MORBID))
		amputation_speed_mod *= 0.7 //its morbin time

	if(do_after(user,  toolspeed * 15 SECONDS * amputation_speed_mod, target = patient))
		playsound(get_turf(patient), 'sound/items/weapons/bladeslice.ogg', 250, TRUE)
		if(user.zone_selected == BODY_ZONE_PRECISE_GROIN) //OwO
			tail_snip_candidate.Remove(patient)
			tail_snip_candidate.forceMove(get_turf(patient))
		else
			limb_snip_candidate.dismember()
		user.visible_message(span_danger("[src] violently cuts through, amputating [patient]'s [candidate_name]."), span_notice("You amputate [patient]'s [candidate_name] with [src]."))
		user.log_message("[user] has amputated [patient]'s [candidate_name] with [src]", LOG_GAME)
		patient.log_message("[patient]'s [candidate_name] has been amputated by [user] with [src]", LOG_GAME)

	if(HAS_MIND_TRAIT(user, TRAIT_MORBID)) //Freak
		user.add_mood_event("morbid_dismemberment", /datum/mood_event/morbid_dismemberment)

/obj/item/circular_saw/field_medic/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] is cutting [user.p_them()]self with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	var/timer = 1 SECONDS
	for(var/obj/item/bodypart/thing in user.bodyparts)
		if(thing.body_part == CHEST)
			continue
		addtimer(CALLBACK(thing, TYPE_PROC_REF(/obj/item/bodypart/, dismember)), timer)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), user, 'sound/items/weapons/bladeslice.ogg', 70), timer)
		timer += 1 SECONDS
	sleep(timer)
	return BRUTELOSS
