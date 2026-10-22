extends Node

# Autoload ProjectileSystem.gd
# Обработка расчетов пробития брони

func calculate_penetration(projectile_data: Resource, armor_edge_data: Resource, impact_angle: float, distance: float) -> Dictionary:
    var result = {
        "penetrated": false,
        "ricochet": false,
        "effective_thickness": 0.0,
        "damage": 0.0
    }

    # impact_angle - угол от нормали (0 = перпендикулярное попадание)
    var angle_rad = deg_to_rad(impact_angle)

    # Базовый расчет рикошета
    if impact_angle > projectile_data.ricochet_angle:
        result["ricochet"] = true
        return result

    # Приведенная толщина брони
    var thickness = armor_edge_data.thickness
    # TODO: Добавить нормализацию снаряда
    result["effective_thickness"] = thickness / cos(angle_rad)

    # Учитываем стойкость материала (композит, сталь и т.д.)
    var material_modifier = armor_edge_data.material.resistance_modifier
    var final_armor = result["effective_thickness"] * material_modifier

    # Расчет пробития с падением от дистанции (для AP, APCR)
    var current_penetration = projectile_data.base_penetration
    if projectile_data.type in ["AP", "APCR"]:
        current_penetration -= (distance * projectile_data.penetration_drop_rate)

    if current_penetration >= final_armor:
        result["penetrated"] = true
        result["damage"] = projectile_data.base_damage

    return result
