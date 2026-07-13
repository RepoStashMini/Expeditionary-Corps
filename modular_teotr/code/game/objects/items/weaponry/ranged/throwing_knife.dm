//nova code//
//Marksman's throwing knife and a pouch for it
/obj/item/knife/combat/throwing
	name = "throwing knife"
	desc = "While very well weighted for throwing, the distribution of mass makes it unwieldy for use in melee."
	icon = 'modular_teotr/Icons/obj/weapons/throwing.dmi'
	icon_state = "throwing"
	force = 12 // don't stab with this
	throwforce = 30 // 38 force on embed? compare contrast with throwing stars.
	throw_speed = 4
	embed_type = /datum/embedding/combat_knife/throwing

// +10 embed chance up from combat knife's 65
/datum/embedding/combat_knife/throwing
	embed_chance = parent_type::embed_chance + 10

/obj/item/storage/pouch/ammo/marksman
	name = "marksman's knife pouch"

/obj/item/storage/pouch/ammo/marksman/setup_reskins()
	return

/obj/item/storage/pouch/ammo/marksman/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/marksman)

/datum/storage/marksman
	max_total_storage = 60
	max_slots = 10
	numerical_stacking = TRUE
	quickdraw = TRUE

/datum/storage/marksman/New()
	. = ..()
	can_hold = typecacheof(list(/obj/item/knife/combat))

/obj/item/storage/pouch/ammo/marksman/PopulateContents() //can kill most basic enemies with 5 knives, though marksmen shouldn't be soloing enemies anyways
	new /obj/item/knife/combat/throwing(src)
	new /obj/item/knife/combat/throwing(src)
	new /obj/item/knife/combat/throwing(src)
	new /obj/item/knife/combat/throwing(src)
	new /obj/item/knife/combat/throwing(src)
