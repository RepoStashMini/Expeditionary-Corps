/obj/item/reagent_containers/applicator/pill/detergent
	name = "detergent pod"
	desc = "Put in water to get space cleaner. Do not eat. Really."
	icon = 'modular_teotr/modules/ironing_clothes/icons/chemical_storage.dmi'
	icon_state = "detergent_pod"
	list_reagents = list(/datum/reagent/ammonia = 30)
	rename_with_volume = TRUE
	var/smell_clean_time = 10 MINUTES

/obj/item/storage/box/detergent
	name = "detergent pods bag"
	icon = 'modular_teotr/modules/ironing_clothes/icons/chemical_storage.dmi'
	desc = "A bag full of juicy, yummy detergent pods. This bag has been labeled: Tod Pods, a Waffle Co. product."
	icon_state = "detergent"
	storage_type = /obj/item/reagent_containers/applicator/pill/detergent

/obj/item/storage/box/detergent/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/reagent_containers/applicator/pill/detergent(src)

/obj/machinery/washing_machine/proc/wash_cycle(mob/user)
	for(var/obj/item/I in (contents - component_parts))
		I.wash(CLEAN_WASH)
		I.machine_wash(src, user)
		if(istype(I, /obj/item/clothing))
			var/obj/item/clothing/C = I
			C.ironed_state = WRINKLES_WRINKLY
			if(detergent)
				C.change_smell(SMELL_CLEAN)
				addtimer(CALLBACK(C, TYPE_PROC_REF(/obj/item/clothing, change_smell), SMELL_DEFAULT), 5 MINUTES, TIMER_UNIQUE | TIMER_OVERRIDE)
	//if we had the ability to brainwash, remove that now
	REMOVE_TRAIT(src, TRAIT_BRAINWASHING, SKILLCHIP_TRAIT)
	busy = FALSE
	if(color_source)
		qdel(color_source)
		color_source = null
	update_appearance()
	qdel(detergent)
	detergent = null
	use_energy(active_power_usage)

