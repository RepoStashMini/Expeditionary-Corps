/datum/job/exp_med_forwarder
	title = JOB_FORWARDER
	description = "Explore! and try not to let your comrades die in the process, \
		Go on an expedition."
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_MED_EXP
	minimal_player_age = 0
	exp_requirements = 60
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "EXP_FORWARDER_MEDIC"

	outfit = /datum/outfit/job/exp_med_forwarder
	plasmaman_outfit = /datum/outfit/plasmaman/research_director
	departments_list = list(
		/datum/job_department/exp_personnel,
		/datum/job_department/medical,
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
/datum/outfit/job/exp_med_forwarder
	name = "Expeditionary medic"
	jobtype = /datum/job/exp_med_forwarder

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/job/exp_med_forwarder
	uniform = /obj/item/clothing/under/rank/expeditionary/med_forwarder

	shoes = /obj/item/clothing/shoes/combat/expeditionary_corps
	backpack = 	/obj/item/storage/backpack/duffelbag/expeditionary_corps
	gloves = /obj/item/clothing/gloves/latex/nitrile/expeditionary_corps

	ears = /obj/item/radio/headset/headset_medexp

	box = /obj/item/storage/box/survival
