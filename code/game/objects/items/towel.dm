// Big Gigachad Towels
// Code from https://github.com/SierraBay/SierraBay12
/obj/item/rolled_towel
	name = "rolled big towel"
	desc = "A collapsed big towel - looks like you can't use it as a normal one... Try it on a beach."
	icon = 'icons/obj/towel.dmi'
	icon_state = "rolled_towel"
	w_class = WEIGHT_CLASS_SMALL

	force = 0.3 // Big soft towel is more harmless
	attack_verb_continuous = list("hits", "bludgeons", "whacks","whipped")
	attack_verb_simple = list("hit", "bludgeon", "whack","whipped")
	hitsound = 'sound/items/towelwhip.ogg'

	var/beach_towel = /obj/structure/towel

/obj/item/rolled_towel/attack_self(mob/living/user)
	// FIX: Bay code incorrectly initialized rolled_towel here. Changed to beach_towel.
	var/obj/structure/towel/T = new beach_towel(user.loc)
	T.add_fingerprint(user)
	qdel(src)

/obj/structure/towel
	name = "big towel"
	icon = 'icons/obj/towel.dmi'
	icon_state = "beach_towel"
	anchored = FALSE
	var/rolled_towel = /obj/item/rolled_towel

/obj/structure/towel/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return
	visible_message("<span class='notice'>[user] rolled up [src].</span>")
	var/obj/item/rolled_towel/B = new rolled_towel(get_turf(src))
	user.put_in_hands(B)
	qdel(src)

/obj/item/rolled_towel/black
	name = "black rolled towel"
	icon_state = "black_rolled_towel"
	beach_towel = /obj/structure/towel/black

/obj/structure/towel/black
	name = "black big towel"
	icon_state = "black_beach_towel"
	rolled_towel = /obj/item/rolled_towel/black

/obj/item/rolled_towel/blue_stripped
	name = "blue rolled towel"
	icon_state = "bluestripp_towel"
	beach_towel = /obj/structure/towel/blue_stripped

/obj/structure/towel/blue_stripped
	name = "blue big towel"
	icon_state = "bluestripp_beach"
	rolled_towel = /obj/item/rolled_towel/blue_stripped

/obj/item/rolled_towel/red_stripped
	name = "red rolled towel"
	icon_state = "redstripp_towel"
	beach_towel = /obj/structure/towel/red_stripped

/obj/structure/towel/red_stripped
	name = "red big towel"
	icon_state = "redstripp_beach"
	rolled_towel = /obj/item/rolled_towel/red_stripped

/obj/item/rolled_towel/green_stripped
	name = "green rolled towel"
	icon_state = "greenstripp_towel"
	beach_towel = /obj/structure/towel/green_stripped

/obj/structure/towel/green_stripped
	name = "green big towel"
	icon_state = "greenstripp_beach"
	rolled_towel = /obj/item/rolled_towel/green_stripped

/obj/item/rolled_towel/yellow_stripped
	name = "yellow rolled towel"
	icon_state = "yellowstripp_towel"
	beach_towel = /obj/structure/towel/yellow_stripped

/obj/structure/towel/yellow_stripped
	name = "green big towel"
	icon_state = "yellowstripp_beach"
	rolled_towel = /obj/item/rolled_towel/yellow_stripped

/obj/item/rolled_towel/pink_stripped
	name = "pink rolled towel"
	icon_state = "pinkstripp_towel"
	beach_towel = /obj/structure/towel/pink_stripped

/obj/structure/towel/pink_stripped
	name = "green big towel"
	icon_state = "pinkstripp_beach"
	rolled_towel = /obj/item/rolled_towel/pink_stripped

/obj/item/rolled_towel/ilove
	name = "*i <3 you* rolled towel"
	icon_state = "rolled_towel"
	beach_towel = /obj/structure/towel/ilove

/obj/structure/towel/ilove
	name = "*i <3 you* big towel"
	icon_state = "ilove_beach"
	rolled_towel = /obj/item/rolled_towel/ilove

/obj/item/rolled_towel/fitness
	name = "rolled fitness mat"
	desc = "A fitness mat - place it in a gym for better training.."
	icon_state = "rolled_gym_beach"
	beach_towel = /obj/structure/towel/fitness

/obj/structure/towel/fitness
	name = "fitness mat"
	icon_state = "gym_beach"
	rolled_towel = /obj/item/rolled_towel/fitness

/obj/structure/towel/holo
	name = "big holographic towel"
	icon = 'icons/obj/towel.dmi'
	icon_state = "beach_towel"
	anchored = TRUE
	rolled_towel = null

/obj/structure/towel/holo/attack_hand(mob/living/user, list/modifiers)
	return

/obj/structure/towel/holo/ilove
	name = "*i <3 you* big towel"
	icon_state = "ilove_beach"

/obj/structure/towel/holo/blue_stripped
	name = "blue big towel"
	icon_state = "bluestripp_beach"
