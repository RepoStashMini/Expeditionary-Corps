
/datum/station_alert/New(holder, list/alarm_types, list/listener_z_level, list/listener_areas, title, camera_view)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_CREWMEMBER_JOINED, PROC_REF(change_listener_level))

/datum/station_alert/Destroy()
	. = ..()
	UnregisterSignal(SSdcs, COMSIG_GLOB_CREWMEMBER_JOINED)

/// Signal handler for [COMSIG_GLOB_CREWMEMBER_JOINED]. Changes [/datum/alarm_listener]'s [var/list/allowed_z_levels] to our borg's Z level (which is station's Z level, as this signal only called for station crewmember)
/datum/station_alert/proc/change_listener_level(datum/source, mob/living/new_crewmember, rank)
	SIGNAL_HANDLER

	if(new_crewmember != holder)
		return
	listener.allowed_z_levels = SSmapping.levels_by_trait(ZTRAIT_STATION)

/mob/living/silicon/robot/proc/dissipate()
	particles.spawning = 0
	addtimer(CALLBACK(src, PROC_REF(particles_qdel)), 1.5 SECONDS)

/mob/living/silicon/robot/proc/particles_qdel()
	QDEL_NULL(particles)

// The smoke
/particles/smoke/robot
	spawning = 0.4
	lifespan = 1 SECONDS
	fade = 0.75 SECONDS
	position = list(5, 12, 0)
	velocity = list(0, 0.2, 0)
	friction = 0.35
	scale = 0.5
	grow = 0.1
	spin = generator("num", -20, 20)


/obj/effect/temp_visual/mook_dust/robot/table
	color = "#ffffffc2"
	pixel_y = -8
	layer = ABOVE_MOB_LAYER

// Update the borg's model appearance when they change models
/obj/item/robot_model/do_transform_animation()
	. = ..()
	var/mob/living/silicon/robot/cyborg = loc
	var/mutable_appearance/character_appearance = new(cyborg.appearance)
	GLOB.name_to_appearance[cyborg.real_name] = character_appearance // Cache this for Character Directory
