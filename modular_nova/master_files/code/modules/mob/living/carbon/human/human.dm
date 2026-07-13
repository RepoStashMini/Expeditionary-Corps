/mob/living/carbon/human
	/// Used for footstep type pref, to apply to any new legs that get added to this mob. Uses a var instead of checking prefs because there are a lot of clientless mob situations.
	var/footstep_type



/mob/living/carbon/human/Destroy()

	if(held_left)
		held_left.UnregisterSignal(src, COMSIG_ATOM_DIR_CHANGE)
		QDEL_NULL(held_left)
	if(held_right)
		held_right.UnregisterSignal(src, COMSIG_ATOM_DIR_CHANGE)
		QDEL_NULL(held_right)
	return ..()

