/obj/machinery/vending/donuts
	name = "Monkin' Donuts"
	desc = "A donut vendor provided by Robust Industries, LLC."
	product_slogans = "Test your robustness!;Replenish your robustness!"
	product_ads = "Homer Simpson approves!;Each of us is a little cop!;Hope you're hunger!;Over 1 million donuts sold!;Try our new Robust Coffee!"
	icon_state = "donuts"
	panel_type = "panel7"
	light_mask = "donuts-light-mask"
	products = list(
		/obj/item/food/donut/plain = 5,
		/obj/item/food/donut/berry = 5,
		/obj/item/food/donut/choco = 5,
		/obj/item/food/donut/caramel = 5,
		/obj/item/food/donut/meat = 5,
	)
	contraband = list(
		/obj/item/food/donut/trumpet = 2,
	)
	premium = list(
		/obj/item/storage/fancy/donut_box = 3,
	)
	refill_canister = /obj/item/vending_refill/donuts
	default_price = PAYCHECK_CREW * 0.6
	extra_price = PAYCHECK_CREW
	payment_department = ACCOUNT_SRV

/obj/item/vending_refill/donuts
	machine_name = "Monkin' Donuts"
	icon_state = "refill_donuts"

