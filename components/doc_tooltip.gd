extends PanelContainer

@export var text:String = ""
@export var width:float = 200.0
@export var height:float = 500.0

@onready var label = $Label

func _ready() -> void:
	custom_minimum_size = Vector2(width,height)
	label.text = text
