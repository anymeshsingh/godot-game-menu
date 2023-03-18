@tool
class_name Test
extends Node

var Type: String;

func _get_property_list():
	return [
		{
			name = "Type",
			type = TYPE_STRING,
			hint = PROPERTY_HINT_ENUM,
			hint_string = "Damage,Heal"
		}
	]

func print_type():
	print(Type)
