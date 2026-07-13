
/obj/item/clothing/proc/change_smell(smell = SMELL_DEFAULT)
	smell_state = smell

/obj/item/clothing
	var/ironed_state = WRINKLES_DEFAULT
	var/smell_state = SMELL_DEFAULT

/obj/item/clothing/examine(mob/user)
	switch(ironed_state)
		if(WRINKLES_WRINKLY)
			to_chat(user, span_warning("It's wrinkly."))
		if(WRINKLES_NONE)
			to_chat(user, span_notice("It's completely wrinkle-free!"))

	switch(smell_state)
		if(SMELL_CLEAN)
			to_chat(user, span_notice("It smells clean!"))
		if(SMELL_STINKY)
			to_chat(user, span_warning("It's quite stinky!"))


/obj/machinery/washing_machine/item_interaction(mob/living/user, obj/item/item, list/modifiers)
	if(user.combat_mode)
		return NONE
	if (!state_open)
		to_chat(user, span_warning("Open the door first!"))
		return ITEM_INTERACT_BLOCKING
	if(bloody_mess)
		to_chat(user, span_warning("[src] must be cleaned up first!"))
		return ITEM_INTERACT_BLOCKING
	if(contents.len >= max_wash_capacity)
		to_chat(user, span_warning("The washing machine is full!"))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(item, src))
		to_chat(user, span_warning("\The [item] is stuck to your hand, you cannot put it in the washing machine!"))
		return ITEM_INTERACT_BLOCKING
	if(detergent)
		color_source = item
	if(!detergent && istype(item, /obj/item/reagent_containers/applicator/pill/detergent))
		detergent = item
	return ITEM_INTERACT_SUCCESS



