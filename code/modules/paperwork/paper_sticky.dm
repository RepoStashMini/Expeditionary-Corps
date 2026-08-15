/obj/item/sticky_pad
	name = "sticky note pad"
	desc = "A pad of densely packed sticky notes."
	color = COLOR_YELLOW
	icon = 'icons/obj/service/stickynotes.dmi'
	icon_state = "pad_full"
	inhand_icon_state = "paper"
	w_class = WEIGHT_CLASS_SMALL

	var/papers = 50
	var/written_text
	var/written_by
	var/paper_type = /obj/item/paper/sticky

/obj/item/sticky_pad/Initialize(mapload)
	. = ..()
	// Подъём блокнота перетягиванием на себя, как у коробки бумаги
	interaction_flags_item &= ~INTERACT_ITEM_ATTACK_HAND_PICKUP
	AddElement(/datum/element/drag_pickup)

/obj/item/sticky_pad/update_icon_state()
	if(papers <= 15)
		icon_state = "pad_empty"
	else if(papers <= 50)
		icon_state = "pad_used"
	else
		icon_state = "pad_full"
	if(written_text)
		icon_state = "[icon_state]_writing"
	return ..()

/obj/item/sticky_pad/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/pen))
		if(is_banned_from(user.ckey, "Graffiti"))
			to_chat(user, span_warning("You are banned from leaving persistent information across rounds."))
			return ITEM_INTERACT_SUCCESS

		var/writing_space = MAX_MESSAGE_LEN - length(written_text)
		if(writing_space <= 0)
			to_chat(user, span_warning("There is no room left on [src]."))
			return ITEM_INTERACT_SUCCESS

		var/text_input = tgui_input_text(user, "What would you like to write?", "Sticky Pad")
		if(!text_input || tool.loc != user)
			return ITEM_INTERACT_BLOCKING

		text_input = copytext(text_input, 1, writing_space + 1)

		user.visible_message(span_notice("[user] jots a note down on [src]."))
		written_by = user.ckey
		if(written_text)
			written_text = "[written_text] [text_input]"
		else
			written_text = text_input
		update_appearance()
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/sticky_pad/examine(mob/user)
	. = ..()
	if(papers)
		. += "It has [papers] sticky note[papers > 1 ? "s" : ""] left."
		. += "You can drag it onto yourself to pick it up."
	else
		. += "It doesn't contain anything."

/obj/item/sticky_pad/attack_hand(mob/user, list/modifiers)
	if(isliving(user))
		var/mob/living/living_mob = user
		if(!(living_mob.mobility_flags & MOBILITY_PICKUP))
			return
	user.changeNext_move(CLICK_CD_RAPID)

	if(papers > 0)
		var/obj/item/paper/sticky/paper = new paper_type(get_turf(src))

		paper.text = written_text
		paper.color = color
		paper.update_appearance()

		written_text = null
		user.put_in_hands(paper)
		to_chat(user, span_notice("You pull [paper] off [src]."))
		papers--
		if(papers <= 0)
			qdel(src)
		else
			update_appearance()
		return TRUE
	else
		to_chat(user, span_warning("[src] is empty!"))
	add_fingerprint(user)
	return TRUE

/obj/item/sticky_pad/random/Initialize(mapload)
	. = ..()
	color = pick(COLOR_YELLOW, COLOR_LIME, COLOR_CYAN, COLOR_ORANGE, COLOR_PINK)


// --- КОД САМОГО ЛИСТОЧКА СТИКЕРА ---

/obj/item/paper/sticky
	name = "sticky note"
	desc = "Note to self: buy more sticky notes."
	icon = 'icons/obj/service/stickynotes.dmi'
	color = COLOR_YELLOW
	slot_flags = NONE

/obj/item/paper/sticky/update_icon_state()
	if(icon_state != "scrap")
		icon_state = text ? "paper_words" : "paper"
	return ..()

// ИСПРАВЛЕНО: При возврате в руки возвращаем стандартный слой и план, чтобы не ломать инвентарь куклы
/obj/item/paper/sticky/attack_hand(mob/living/user, list/modifiers)
	if(anchored)
		anchored = FALSE
		layer = initial(layer)
		plane = initial(plane)
	return ..()

/obj/item/paper/sticky/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(!in_range(user, target) || icon_state == "scrap")
		return NONE

	if(istype(target, /obj/machinery/door))
		return NONE

	var/turf/target_turf = get_turf(target)
	if(!target_turf)
		return NONE

	if(user.transferItemToLoc(src, target_turf))
		anchored = TRUE

		// ИСПРАВЛЕНО: Принудительно поднимаем слой стикера, чтобы он ложился поверх чашек, часов, шкафов и столов
		layer = 3.9

		if(modifiers)
			if(modifiers[ICON_X])
				pixel_x = text2num(modifiers[ICON_X]) - 16
			if(modifiers[ICON_Y])
				pixel_y = text2num(modifiers[modifiers[ICON_Y] ? ICON_Y : "icon-y"]) - 16

		update_appearance()
		return ITEM_INTERACT_SUCCESS

	return NONE
