/datum/job/exp_eng_forwarder
	title = JOB_FORWARDER_ENGINEER
	description = "Explore! Remove obstacles from your path, \
		Go on an expedition."
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_EXP
	minimal_player_age = 0
	exp_requirements = 60
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "EXP_FORWARDER_ENGINEER"

	outfit = /datum/outfit/job/exp_eng_forwarder
	plasmaman_outfit = /datum/outfit/plasmaman/research_director
	departments_list = list(
		/datum/job_department/exp_personnel,
		/datum/job_department/engineering,
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
/datum/outfit/job/exp_eng_forwarder
	name = "Expeditionary engineer"
	jobtype = /datum/job/exp_forwarder

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/job/exp_eng_forwarder
	uniform = /obj/item/clothing/under/rank/expeditionary/eng_forwarder

	shoes = /obj/item/clothing/shoes/combat/expeditionary_corps
	backpack = 	/obj/item/storage/backpack/duffelbag/expeditionary_corps
	gloves = /obj/item/clothing/gloves/chief_engineer/expeditionary_corps

	ears = /obj/item/radio/headset/headset_engexp

	box = /obj/item/storage/box/survival
