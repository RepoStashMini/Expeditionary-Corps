/obj/structure/bed/ironing_board
	name = "ironing board"
	desc = "An ironing board to unwrinkle your wrinkled clothing."
	icon = 'modular_teotr/modules/ironing_clothes/icons/ironing.dmi'
	icon_state = "basic-down"
	can_buckle = TRUE
	buckle_dir = SOUTH
	buckle_lying = 90
	can_deconstruct = FALSE
	elevation = 10
	base_icon_state = "basic"

	var/obj/item/ironing_board/item_type = /obj/item/ironing_board

	var/obj/item/clothing/clothing

	var/obj/item/ironing_iron/iron

	var/deployed


/obj/structure/bed/ironing_board/Destroy()
	QDEL_NULL(clothing)
	QDEL_NULL(iron)
	return ..()


/obj/structure/bed/ironing_board/Initialize()
	. = ..()
	// Добавляем эффект "мягкого приземления" при падении на кровать
	AddElement(/datum/element/soft_landing)
	// Если задано смещение, добавляем визуальный подъем спрайта
	if(elevation)
		AddElement(/datum/element/elevation, pixel_shift = elevation)
	update_buckle_vars(dir) // Устанавливаем положение пристегивания в зависимости от поворота
	register_context()


///obj/structure/bed/ironing_board/Move()
//	. = ..()
//	if (!isturf(loc))
//		return
//	var/turf/turf = loc


/obj/structure/bed/ironing_board/update_icon_state()
	. = ..()
	if (deployed)
		if (iron)
			icon_state = "[base_icon_state]-up-iron"
		else
			icon_state = "[base_icon_state]-up"
	else if (iron)
		icon_state = "[base_icon_state]-down-iron"
	else
		icon_state = "[base_icon_state]-down"


/obj/structure/bed/ironing_board/update_overlays()
	. = ..()
	// Если доска разложена и на ней есть одежда
	if(deployed && clothing)
		// В TG мы просто добавляем внешний вид объекта в список оверлеев
		. += clothing.appearance


/obj/structure/bed/ironing_board/attack_hand(mob/user, list/modifiers)
	// В TG attack_hand возвращает TRUE/FALSE. Если есть моб, используем стандартную логику отстегивания родителя.
	if(has_buckled_mobs())
		return ..()

	// Снятие утюга
	if(iron)
		user.visible_message(
			span_notice("[user] removes [iron] from [src]."),
			span_notice("You remove [iron] from [src].")
		)
		user.put_in_hands(iron)
		iron = null
		update_appearance() // В TG вместо update_icon() используется update_appearance()
		return TRUE

	// Снятие одежды
	if(clothing)
		user.visible_message(
			span_notice("[user] removes [clothing] from [src]."),
			span_notice("You remove [clothing] from [src].")
		)
		user.put_in_hands(clothing)
		clothing = null
		deployed = FALSE
		update_appearance()
		return TRUE

	// Складывание пустой доски
	if(!density)
		user.visible_message(
			span_notice("[user] begins folding [src]."),
			span_notice("You begin folding [src].")
		)
		// В TG флаги do_after пишутся через именованные аргументы или специфические константы
		if(!do_after(user, 2 SECONDS, target = src))
			return TRUE

		// Проверка на плотность после задержки (чтобы не сложили, если кто-то лег)
		if(density)
			return TRUE

		var/obj/structure/bed/ironing_board/folded_board = new item_type(drop_location())
		user.put_in_hands(folded_board) // В TG часто сразу кладут предмет в руки при сборке
		qdel(src)
		return TRUE
	return ..()


// В TG эти проки вызываются автоматически системой пристегивания
/obj/structure/bed/ironing_board/post_buckle_mob(mob/living/target)
	. = ..()
	// Если на доске появился хотя бы один моб
	if(has_buckled_mobs())
		set_density(TRUE)
		mouse_opacity = MOUSE_OPACITY_ICON
		deployed = TRUE
	update_appearance() // Обновляем визуал (включая оверлеи)

/obj/structure/bed/ironing_board/post_unbuckle_mob(mob/living/target)
	. = ..()
	// Если после отстегивания доска опустела
	if(!has_buckled_mobs())
		set_density(FALSE)
		mouse_opacity = MOUSE_OPACITY_ICON
		deployed = FALSE
	update_appearance()


/obj/structure/bed/ironing_board/examine(mob/user, distance)
	. = ..()
	if (distance > 5 && !isobserver(user))
		return
	if (iron)
		to_chat(user, "It has \a [iron] resting on it.")
	if (clothing)
		to_chat(user, "\A [clothing] is spread out across it.")

/*
/obj/structure/ironing_board/use_grab(obj/item/grab/grab, list/click_params)
	if (deployed)
		if (buckled_mob)
			USE_FEEDBACK_GRAB_FAILURE("\The [src] already has \the [buckled_mob] on it.")
		else if (clothing)
			USE_FEEDBACK_GRAB_FAILURE("\The [src] already has \a [clothing] on it.")
		else
			USE_FEEDBACK_GRAB_FAILURE("\The [src] is already deployed.")
		return TRUE
	if (!can_buckle(grab.affecting, grab.assailant))
		return TRUE
	grab.assailant.visible_message(
		SPAN_NOTICE("\The [grab.assailant] starts buckling \the [grab.affecting] to \the [src]!"),
		SPAN_NOTICE("You start buckling \the [grab.affecting] to \the [src]!"),
		exclude_mobs = list(grab.affecting)
	)
	grab.affecting.show_message(
		SPAN_NOTICE("\The [grab.assailant] starts buckling you to \the [src]!")
	)
	if (!do_after(grab.assailant, 3 SECONDS, src, DO_PUBLIC_UNIQUE) || QDELETED(grab) || !grab.use_sanity_check(src))
		return TRUE
	if (!user_buckle_mob(grab.affecting, grab.assailant))
		return TRUE

	deployed = TRUE
	grab.affecting.remove_grabs_and_pulls()
	update_icon()
	return TRUE


	GRAB_AGGRESSIVE
*/

/obj/structure/bed/ironing_board/attackby(obj/item/tool, mob/user, list/params)
	// 1. ВЗАИМОДЕЙСТВИЕ С ОДЕЖДОЙ (Кладем на доску)
	if(istype(tool, /obj/item/clothing))
		if(deployed)
			var/fail_reason = "is already deployed."
			if(has_buckled_mobs())
				fail_reason = "already has [buckled_mobs[1]] on it."
			else if(clothing)
				fail_reason = "already has [clothing] on it."

			to_chat(user, span_warning("\The [src] [fail_reason]"))
			return TRUE

		if(!user.transferItemToLoc(tool, src))
			return TRUE

		clothing = tool
		deployed = TRUE
		update_appearance()

		user.visible_message(
			span_notice("[user] puts [tool] on [src]."),
			span_notice("You put [tool] on [src].")
		)
		return TRUE

	// 2. ВЗАИМОДЕЙСТВИЕ С УТЮГОМ
	if(istype(tool, /obj/item/ironing_iron))
		var/obj/item/ironing_iron/tool_iron = tool

		// Глажка одежды
		if(clothing)
			user.visible_message(
				span_notice("[user] starts ironing [clothing] on [src] with [tool_iron]."),
				span_notice("You start ironing [clothing] on [src] with [tool_iron].")
			)

			if(!do_after(user, 5 SECONDS, target = src))
				return TRUE

			if(!tool_iron.iron_enabled) // Проверка, включен ли утюг
				to_chat(user, span_warning("\The [tool_iron] wasn't turned on!"))
				return TRUE

			clothing.ironed_state = WRINKLES_NONE

			user.visible_message(
				span_notice("[user] irons [clothing] on [src] with [tool_iron]."),
				span_notice("You iron [clothing] on [src] with [tool_iron].")
			)
			return TRUE

		// Установка утюга на подставку
		if(iron)
			to_chat(user, span_warning("\The [src] already has [tool_iron] on it."))
			return TRUE

		if(!user.transferItemToLoc(tool_iron, src))
			return TRUE

		iron = tool_iron
		update_appearance()
		user.visible_message(
			span_notice("[user] puts [tool_iron] on [src]."),
			span_notice("You put [tool_iron] on [src].")
		)
		return TRUE

	return ..()


/obj/structure/bed/ironing_board/fancy
	icon_state = "fancy-down"
	base_icon_state = "fancy"
	item_type = /obj/item/ironing_board/fancy


/obj/item/ironing_board
	name = "ironing board"
	desc = "A collapsed ironing board that can be carried around."
	icon = 'modular_teotr/modules/ironing_clothes/icons/ironing.dmi'
	icon_state = "basic-item"
	base_icon_state = "rbed"
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY

	var/structure_type = /obj/structure/bed/ironing_board


/obj/item/ironing_board/attack_self(mob/living/user)
	// В TG используется is_living() или проверка на наличие пола под ногами
	if(!isturf(user.loc))
		to_chat(user, span_warning("You don't have enough space to set up [src] here!"))
		return

	user.visible_message(
		span_notice("[user] starts setting up [src]."),
		span_notice("You start setting up [src].")
	)

	// do_after в TG принимает аргументы немного иначе
	if(!do_after(user, 2 SECONDS, target = user.loc))
		return

	// Создаем структуру на месте игрока
	var/obj/structure/bed/ironing_board/board = new structure_type(user.loc)

	// Переносим отпечатки и логируем действие
	board.add_fingerprint(user)

	// Безопасное удаление предмета из рук и мира
	qdel(src)


/obj/item/ironing_board/fancy
	icon_state = "fancy-item"
	structure_type = /obj/structure/bed/ironing_board/fancy


/obj/item/ironing_iron
	name = "iron"
	desc = "An ironing iron for ironing your iro- err... clothes."
	icon = 'modular_teotr/ironing_clothes/icons/ironing.dmi'
	icon_state = "iron"
	//item_state = "ironingiron"
	//slot_flags = SLOT_BELT
	throwforce = 10
	throw_range = 6
	force = 8
	attack_verb_continuous = list("slammed", "whacked", "bashed", "thunked", "battered", "bludgeoned", "thrashed")

	var/iron_enabled

/obj/item/ironing_iron/attack_self(mob/living/user)
	iron_enabled = !iron_enabled

	// В TG принято выделять включение/выключение цветом для наглядности
	var/iron_on_off = iron_enabled ? span_notice("on") : span_warning("off")

	user.visible_message(
		span_notice("[user] turns [src] [iron_enabled ? "on" : "off"]."),
		span_notice("You turn [src] [iron_on_off]."),
	)

	// Опционально: в TG часто добавляют звуковой эффект или обновление иконки
	playsound(src, 'sound/items/weapons/gun_mode_switch1.ogg', 50, TRUE)
	update_appearance()
/////////////////////////////////////////
/obj/item/ironing_iron/attack(mob/living/target, mob/living/user)
	// 1. Проверяем, включен ли утюг и может ли цель сопротивляться
	// Если цель в сознании и не оглушена — просто бьем утюгом как предметом (вызов родителя)
	if(!iron_enabled || (target.stat == CONSCIOUS && !target.IsParalyzed() && !target.IsParalyzed()))
		return ..()

	// 2. Определяем зону попадания и часть тела
	var/zone = user.zone_selected
	var/obj/item/bodypart/part = target.get_bodypart(zone)

	// Если это человек, но части тела в этой зоне нет (например, оторвана)
	if(ishuman(target) && !part)
		to_chat(user, span_warning("[target] has no [parse_zone(zone)] to iron!"))
		return TRUE

	// 3. Сообщения о начале экзекуции
	user.visible_message(
		span_warning("[user] starts ironing [target][part ? "'s [parse_zone(zone)]" : ""] with [src]!"),
		span_danger("You start ironing [target][part ? "'s [parse_zone(zone)]" : ""] with [src]!"),
		ignored_mobs = target
	)

	to_chat(target, span_userdanger("[user] starts ironing your [part ? "[parse_zone(zone)]" : "body"] with [src]!"))
	to_chat(target, span_bolddanger("You feel a hot, searing pain[part ? " in your [parse_zone(zone)]" : ""]!"))

	// 4. Цикл пытки
	for(var/i in 1 to 5)
		// do_after проверяет расстояние и прерывается при движении
		if(!do_after(user, 1 SECONDS, target = target))
			break

		// Звук шипения на каждом этапе
		playsound(src, 'modular_teotr/modules/ironing_clothes/sound/iron_sizzle.ogg', 80, TRUE)

		if(part)
			// Наносим 0 физ. урона и 3-5 урона ожогом конкретной части
			part.receive_damage(0, rand(3, 5))
		else
			// Для не-гуманоидов (слаймы и т.д.) наносим общий урон ожогом
			target.apply_damage(rand(3, 5), BURN)

		// Визуальный эффект дыма/пара при прижигании
		target.updatehealth()
		do_smoke(1, target.loc)

	return TRUE


	// 4. Логика урона в цикле
	for(var/i in 1 to 5)
		// В TG важно: target в do_after проверяет, не ушел ли противник
		if(!do_after(user, 1 SECONDS, target = target))
			break // Если игрок или цель дернулись — прекращаем

		// Проверяем, не выключили ли утюг в процессе (мало ли)
		if(!iron_enabled)
			break

		// Звук шипения (лучше проигрывать внутри цикла, чтобы он повторялся) modular_teotr/ironing_clothes/sound/iron_sizzle.ogg
		playsound(target, 'modular_teotr/modules/ironing_clothes/sound/iron_sizzle.ogg', 80, TRUE)

		// Наносим урон
		if(part)
			part.receive_damage(0, rand(3, 5)) // 0 Brute, 3-5 Burn
		else
			target.apply_damage(rand(3, 5), BURN)

		// Если цель умерла в процессе — можно тоже прервать
		if(target.stat == DEAD)
			break

	return TRUE

/*
/obj/random/ironing_board_structure
	name = "random deployed ironing board"
	icon = 'icons/obj/structure/beds/ironing.dmi'
	icon_state = "basic-down"


/obj/random/ironing_board_structure/spawn_choices()
	return list(
		/obj/structure/bed/ironing_board,
		/obj/structure/bed/ironing_board/fancy
	)


/obj/random/ironing_board_item
	name = "random collapsed ironing board"
	icon = 'icons/obj/structure/beds/ironing.dmi'
	icon_state = "basic-item"


/obj/random/ironing_board_item/spawn_choices()
	return list(
		/obj/item/ironing_board,
		/obj/item/ironing_board/fancy
	)
*/
