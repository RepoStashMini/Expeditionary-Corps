
/atom/movable/screen/meow
	name = "Mrowl"
	icon = 'modular_teotr/modules/tgmp/tgmd.dmi'
	icon_state = "mews"
	screen_loc = ui_tgmd_menu
	mouse_over_pointer = MOUSE_HAND_POINTER

/atom/movable/screen/meow/Click()
	if(!isliving(usr))
		return TRUE
	var/mob/living/daydreamer = usr
	daydreamer.open_memory_panel()
