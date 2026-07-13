//Gateway Medkit, no more combat defibs!
/obj/item/storage/medkit/expeditionary
	name = "expeditionary medical kit"
	desc = "Now with 100% less bullshit."
	icon_state = "medkit_tactical"
	damagetype_healed = "all"

/obj/item/storage/medkit/expeditionary/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/wrap/gauze(src)
	new /obj/item/defibrillator/compact/loaded(src)
	new /obj/item/reagent_containers/hypospray/combat(src)
	new /obj/item/stack/medical/mesh/advanced(src)
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/clothing/glasses/hud/health(src)

/obj/item/storage/medkit/expeditionary/surplus
	desc = "Now with less bullshit. And more dust. But mainly less bullshit. If you have to use this, there's no way you've got insurance."

/obj/item/storage/medkit/expeditionary/surplus/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/wrap/gauze/twelve(src)
	new /obj/item/reagent_containers/hypospray/combat(src) // epi/atro + lepo + omnizine
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/stack/medical/mesh/advanced(src)
	new /obj/item/stack/medical/mesh/advanced(src)
	new /obj/item/clothing/glasses/hud/health(src)
