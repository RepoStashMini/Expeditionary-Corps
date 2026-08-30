/obj/structure/platform_deco // Этот код изначально был взят с Шиптеста, и да он адаптирован через нейронку.
	name = "platform border"
	desc = "An elevated platform railing meant to make someone feel more important."
	icon = 'icons/obj/platform.dmi'
	icon_state = "platform"
	flags_1 = ON_BORDER_1
	layer = ABOVE_OBJ_LAYER // Replaced RAILING_LAYER with standard TG layer
	pass_flags_self = LETPASSTHROW
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	density = TRUE
	anchored = TRUE
	max_integrity = 50

/obj/structure/platform_deco/Initialize(mapload)
	. = ..()
	// If the platform is dense and on a border, attach a signal to block exit from the turf
	if(density && (flags_1 & ON_BORDER_1))
		var/static/list/loc_connections = list(
			COMSIG_ATOM_EXIT = PROC_REF(on_exit),
		)
		AddElement(/datum/element/connect_loc, loc_connections)

	// TG Style: Climbing is handled via elements. 40 deciseconds = 4 seconds climb time.
	AddElement(/datum/element/climbable, climb_time = 40)

	// Register context screentips for tool interactions
	register_context()
	update_appearance()

/obj/structure/platform_deco/update_appearance(updates)
	. = ..()
	// Dynamically adjust layer based on direction to properly overlay structures
	if(dir in list(NORTH, NORTHEAST, EAST))
		layer = WIRE_LAYER // Hides the border behind items if it faces north/east
	else
		layer = ABOVE_OBJ_LAYER // Overlays the border over items if it faces south/west

// --- CONTEXT SCREENTIPS & TOOL INTERACTION (TG STYLE) ---

/obj/structure/platform_deco/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()
	if(isnull(held_item))
		return NONE

	// Set contextual screentips for Right-Click (RMB) interactions
	if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
		context[SCREENTIP_CONTEXT_RMB] = "Disassemble"
		return CONTEXTUAL_SCREENTIP_SET
	if(held_item.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_RMB] = "Deconstruct"
		return CONTEXTUAL_SCREENTIP_SET

	return .

// Secondary screwdriver interaction (Right-Click)
/obj/structure/platform_deco/screwdriver_act_secondary(mob/living/user, obj/item/tool)
	to_chat(user, span_notice("You start disassembling [src]..."))
	if(tool.use_tool(src, user, 20, volume=50)) // 20 = 2 seconds
		atom_deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

// Secondary wrench interaction (Right-Click)
/obj/structure/platform_deco/wrench_act_secondary(mob/living/user, obj/item/tool)
	to_chat(user, span_notice("You start deconstructing [src]..."))
	if(tool.use_tool(src, user, 40, volume=50)) // 40 = 4 seconds
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		atom_deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

// Left-Click interaction (Welder repairs while out of combat mode)
/obj/structure/platform_deco/attackby(obj/item/I, mob/living/user, params)
	add_fingerprint(user)

	if(I.tool_behaviour == TOOL_WELDER && !user.combat_mode)
		if(atom_integrity < max_integrity)
			if(!I.tool_start_check(user, src))
				return TRUE

			to_chat(user, span_notice("You begin repairing [src]..."))
			if(I.use_tool(src, user, 40, volume=50))
				atom_integrity = max_integrity
				to_chat(user, span_notice("You repair [src]."))
		else
			to_chat(user, span_warning("[src] is already in good condition!"))
		return TRUE
	return ..()

// Modern TG station deconstruction hook
/obj/structure/platform_deco/atom_deconstruct(disassembled = TRUE)
	if(resistance_flags & INDESTRUCTIBLE)
		return FALSE
	qdel(src)
	return TRUE


// --- PASSABILITY & MOVEMENT (BORDER LOGIC) ---

/obj/structure/platform_deco/CanPass(atom/movable/mover, border_dir)
	. = ..()
	// If moving towards the platform border direction, check if the mover can bypass it
	if(border_dir & dir)
		return . || mover.throwing || (mover.movement_type & (FLYING | FLOATING))
	return TRUE

/obj/structure/platform_deco/CanAStarPass(obj/item/card/id/ID, to_dir, atom/movable/requester)
	if (!(to_dir & dir))
		return TRUE
	return ..()

// Prevents atoms from leaving the tile through the platform's blocked direction
/obj/structure/platform_deco/proc/on_exit(datum/source, atom/movable/leaving, direction)
	SIGNAL_HANDLER

	if(leaving == src || !(direction & dir) || !density || leaving.throwing)
		return

	if(leaving.movement_type & (PHASING | FLYING | FLOATING))
		return

	if(leaving.move_force >= MOVE_FORCE_EXTREMELY_STRONG)
		return

	leaving.Bump(src)
	return COMPONENT_ATOM_BLOCK_EXIT

// --- SUBTYPES ---

/obj/structure/platform_deco/corner
	icon_state = "platform_corners"
	density = FALSE

/obj/structure/platform_deco/industrial
	icon_state = "industrial_platform"

/obj/structure/platform_deco/industrial/corner
	icon_state = "ind_platform_corners"
	density = FALSE

/obj/structure/platform_deco/industrial_alt
	icon_state = "industrial2_platform"

/obj/structure/platform_deco/industrial_alt/corner
	icon_state = "ind2_platform_corners"
	density = FALSE

/obj/structure/platform_deco/industrial_alt/indestructible
	icon_state = "industrial2_platform"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/platform_deco/industrial_alt/indestructible/Initialize(mapload)
	. = ..()
	// Indestructible versions do not get the climbable element
	RemoveElement(/datum/element/climbable)

/obj/structure/platform_deco/industrial_alt/indestructible/CanPass(atom/movable/mover, border_dir)
	. = ..()
	if(border_dir & dir)
		return . || mover.throwing || (mover.movement_type & (FLYING | FLOATING))
	return FALSE

/obj/structure/platform_deco/industrial_alt/corner/indestructible
	icon_state = "ind2_platform_corners"
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/platform_deco/industrial_alt/corner/indestructible/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/climbable)

/obj/structure/platform_deco/military
	icon_state = "military_platform"

/obj/structure/platform_deco/military/corner
	icon_state = "mil_platform_corners"
	density = FALSE

/obj/structure/platform_deco/ship
	icon_state = "ship_platform"

/obj/structure/platform_deco/ship/corner
	icon_state = "ship_platform_corners"
	density = FALSE

/obj/structure/platform_deco/ship_two
	icon_state = "ship2_platform"

/obj/structure/platform_deco/ship_two/corner
	icon_state = "ship2_platform_corners"
	density = FALSE

/obj/structure/platform_deco/ship_three
	icon_state = "ship3_platform"

/obj/structure/platform_deco/ship_three/corner
	icon_state = "ship3_platform_corners"
	density = FALSE

/obj/structure/platform_deco/ship_three/indestructible
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/platform_deco/ship_three/indestructible/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/climbable)

/obj/structure/platform_deco/ship_three/indestructible/CanPass(atom/movable/mover, border_dir)
	. = ..()
	if(border_dir & dir)
		return . || mover.throwing || (mover.movement_type & (FLYING | FLOATING))
	return FALSE

/obj/structure/platform_deco/ship_three/corner/indestructible
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/platform_deco/ship_three/corner/indestructible/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/climbable)

/obj/structure/platform_deco/ship_four
	icon_state = "ship4_platform"

/obj/structure/platform_deco/ship_four/corner
	icon_state = "ship4_platform_corners"
	density = FALSE

/obj/structure/platform_deco/wood
	name = "wooden platform"
	icon_state = "wood_platform"
	resistance_flags = FLAMMABLE

/obj/structure/platform_deco/wood/corner
	icon_state = "wood_platform_corners"
	density = FALSE

/obj/structure/platform_deco/wood_two
	name = "wooden platform"
	icon_state = "fancy_wood_platform"
	resistance_flags = FLAMMABLE

/obj/structure/platform_deco/wood_two/corner
	icon_state = "fwood_platform_corners"
	density = FALSE
