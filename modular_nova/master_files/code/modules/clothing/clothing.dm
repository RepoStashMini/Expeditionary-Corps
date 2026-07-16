GLOBAL_LIST_EMPTY(taur_clothing_icons)

/obj/item/clothing
	blocks_emissive = EMISSIVE_BLOCK_UNIQUE
	/// For clothing that does not have body_parts_covered = CHEST /etc but that we would still like to be able to attach an accessory to
	var/attachment_slot_override = NONE

/obj/item/clothing/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	if(atom_integrity <= 0 && damage_flag == FIRE) // Our clothes don't get destroyed by fire, shut up stack trace >:(
		return

	return ..()

/// The code which handles generating a greyscale icon for worn clothing on big leg (taur) legs, for human_update_icons.dm
/obj/item/proc/generate_big_legs_icons(icon/base_icon, greyscale_colors, bodyshape)
	var/skirt = FALSE
	if(istype(src, /obj/item/clothing/under))
		var/obj/item/clothing/under/clothing_item = src
		// An assumption being made, that this combination of flags will basically always be a skirt
		if((clothing_item.female_sprite_flags & FEMALE_UNIFORM_TOP_ONLY) && (supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON))
			skirt = TRUE

	var/icon/legs = icon(SSgreyscale.GetColoredIconByType(greyscale_config, greyscale_colors), skirt ? "skirt_worn" : "jumpsuit_worn")
	return replace_icon_legs(base_icon, legs)

