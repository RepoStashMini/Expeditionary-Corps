/datum/job/exp_forwarder
	title = JOB_FORWARDER
	description = "Explore! and try not to die in the process, \
		Go on an expedition."
	faction = FACTION_STATION
	total_positions = 4
	spawn_positions = 4
	supervisors = SUPERVISOR_EXP
	minimal_player_age = 0
	exp_requirements = 60
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "EXP_FORWARDER"

	outfit = /datum/outfit/job/exp_forwarder
	plasmaman_outfit = /datum/outfit/plasmaman/research_director
	departments_list = list(
		/datum/job_department/exp_personnel
		)

	desensitized_base = DESENSITIZED_THRESHOLD

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_EXP

	display_order = JOB_DISPLAY_ORDER_FORWARDER
//	bounty_types =

//	family_heirlooms = list(/obj/item/melee/tomahawk)
	rpg_title = "The Explorer"
	job_flags = STATION_JOB_FLAGS

///Надо бы это доделать
/datum/outfit/job/exp_forwarder
	name = "Forwarder"
	jobtype = /datum/job/exp_forwarder

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/job/exp_forwarder
	uniform = /obj/item/clothing/under/rank/expeditionary/forwarder

	shoes = /obj/item/clothing/shoes/combat/expeditionary_corps
	backpack = 	/obj/item/clothing/gloves/chief_engineer/expeditionary_corps
	gloves = /obj/item/clothing/gloves/color/black/expeditionary_corps

	ears = /obj/item/radio/headset/headset_exp

	box = /obj/item/storage/box/survival


/datum/outfit/job/exp_forwarder/full
	name = "Forwarder full"
	jobtype = /datum/job/exp_forwarder

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/job/exp_forwarder
	uniform = /obj/item/clothing/under/rank/expeditionary/forwarder

	belt = /obj/item/storage/belt/military/expeditionary_corps

	head = /obj/item/clothing/head/helmet/expeditionary_corps

	suit = /obj/item/clothing/suit/armor/vest/expeditionary_corps

	shoes = /obj/item/clothing/shoes/combat/expeditionary_corps
	backpack = 	/obj/item/storage/backpack/duffelbag/expeditionary_corps
	gloves = /obj/item/clothing/gloves/color/black/expeditionary_corps

	ears = /obj/item/radio/headset/headset_exp

//	suit_store = /obj/item/gun/energy/e_gun

	box = /obj/item/storage/box/survival
