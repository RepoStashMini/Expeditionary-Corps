/datum/job/exp_med_officer
	title = JOB_EXP_OFFICER
	description = "Organize the work of the medical expeditionary team, \
		сoordinate the expedition."
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	head_announce = RADIO_CHANNEL_EXP
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_EXP
	req_admin_notify = 1
	minimal_player_age = 4
	exp_requirements = 150
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_EXPEDITIONARY
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "EXP_MED_OFFICER"

	outfit = /datum/outfit/job/exp_med_officer
	plasmaman_outfit = /datum/outfit/plasmaman/research_director
	departments_list = list(
		/datum/job_department/exp_personnel,
		/datum/job_department/medical,
		)

	mind_traits = list(HEAD_OF_STAFF_MIND_TRAITS)
	desensitized_base = DESENSITIZED_THRESHOLD
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM, TRAIT_ROYAL_METABOLISM)

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_EXP

	display_order = JOB_DISPLAY_ORDER_HEAD_OF_SECURITY
	bounty_types = CIV_JOB_SEC

	family_heirlooms = list(/obj/item/melee/tomahawk)
	rpg_title = "The Great Explorer"
	job_flags = STATION_JOB_FLAGS | HEAD_OF_STAFF_JOB_FLAGS | JOB_ANTAG_PROTECTED

	human_authority = JOB_AUTHORITY_HUMANS_ONLY

	voice_of_god_power = 1.2 //Command staff has authority

/datum/job/exp_officer/get_captaincy_announcement(mob/living/captain)
	return "Due to staffing shortages, newly promoted Acting Captain [captain.real_name] on deck!"
///Надо бы это доделать
/datum/outfit/job/exp_med_officer
	name = "Medical Expedition Officer"
	jobtype = /datum/job/exp_med_officer

	id = /obj/item/card/id/advanced/silver
	id_trim = /datum/id_trim/job/exp_med_officer
	uniform = /obj/item/clothing/under/rank/expeditionary/med_com_forwarder

	shoes = /obj/item/clothing/shoes/combat/expeditionary_corps
	backpack = 	/obj/item/storage/backpack/duffelbag/expeditionary_corps
	gloves = /obj/item/clothing/gloves/latex/nitrile/expeditionary_corps

	ears = /obj/item/radio/headset/heads/med_exp_officer

	box = /obj/item/storage/box/survival
