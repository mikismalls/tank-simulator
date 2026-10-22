extends Node

# Autoload TankDataManager.gd
# Управление загрузкой и сохранением конструкций танка

var current_tank_data: Dictionary = {}

func save_tank_to_json(filepath: String, tank_data: Dictionary) -> void:
    var file = FileAccess.open(filepath, FileAccess.WRITE)
    if file:
        var json_string = JSON.stringify(tank_data, "\t")
        file.store_string(json_string)
        file.close()

func load_tank_from_json(filepath: String) -> Dictionary:
    var file = FileAccess.open(filepath, FileAccess.READ)
    if file:
        var json_string = file.get_as_text()
        file.close()

        var json = JSON.new()
        var error = json.parse(json_string)
        if error == OK:
            return json.data
    return {}
