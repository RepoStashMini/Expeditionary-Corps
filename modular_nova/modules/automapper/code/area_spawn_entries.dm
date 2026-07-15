// Pets
/datum/area_spawn/markus
	target_areas = list(/area/station/cargo/sorting, /area/station/cargo/storage, /area/station/cargo/office, /area/station/command/heads_quarters/qm)
	desired_atom = /mob/living/basic/pet/dog/markus

/datum/area_spawn/bumbles
	target_areas = list(/area/station/service/hydroponics, /area/station/service/hydroponics/upper)
	desired_atom = /mob/living/basic/pet/bumbles

/datum/area_spawn/borgi
	target_areas = list(/area/station/science/robotics, /area/station/science/robotics/mechbay, /area/station/science/robotics/lab)
	desired_atom = /mob/living/basic/pet/dog/corgi/borgi

/datum/area_spawn/poppy
	target_areas = list(/area/station/engineering/main, /area/station/engineering/break_room, /area/station/engineering/lobby, /area/station/engineering/supermatter/room)
	desired_atom = /mob/living/basic/pet/poppy

// Structures
/datum/area_spawn/command_drobe
	target_areas = list(/area/station/command/meeting_room, /area/station/command/meeting_room/council, /area/station/command/bridge)
	desired_atom = /obj/machinery/vending/access/command
	mode = AREA_SPAWN_MODE_HUG_WALL

/datum/area_spawn/blueshield_locker
	target_areas = list(/area/station/command/heads_quarters/captain, /area/station/command/bridge, /area/station/command/corporate_dock, /area/station/command/meeting_room, /area/station/command/gateway)
	desired_atom = /obj/structure/closet/secure_closet/blueshield
	mode = AREA_SPAWN_MODE_HUG_WALL

/datum/area_spawn/ammo_workbench
	target_areas = list(/area/station/security/lockers, /area/station/security/office)
	desired_atom = /obj/machinery/ammo_workbench
	mode = AREA_SPAWN_MODE_HUG_WALL

/datum/area_spawn/gbp_machine
	target_areas = list(/area/station/cargo/lobby, /area/station/cargo/boutique, /area/station/construction/storage_wing) // lmao imagine map standardization
	desired_atom = /obj/machinery/gbp_redemption
	mode = AREA_SPAWN_MODE_HUG_WALL

// Wall mounts. Use sparingly as walls are prime real estate
/datum/area_spawn/posialert_robotics
	target_areas = list(/area/station/science/robotics, /area/station/science/robotics/lab)
	desired_atom = /obj/machinery/posialert
	mode = AREA_SPAWN_MODE_MOUNT_WALL

/datum/area_spawn/posialert_rd
	target_areas = list(/area/station/command/heads_quarters/rd, /area/station/science/lab)
	desired_atom = /obj/machinery/posialert
	mode = AREA_SPAWN_MODE_MOUNT_WALL

/datum/area_spawn/prison_cryo_console
	// Keep to one area so it's in the same area as the pods, which is required.
	target_areas = list(/area/station/security/prison)
	desired_atom = /obj/machinery/computer/cryopod
	mode = AREA_SPAWN_MODE_MOUNT_WALL

/datum/area_spawn/prison_cryopod
	target_areas = list(/area/station/security/prison)
	desired_atom = /obj/machinery/cryopod/prison
	mode = AREA_SPAWN_MODE_MOUNT_WALL
