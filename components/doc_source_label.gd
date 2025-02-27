extends Label

@onready var tooltip_scene:PackedScene = preload("res://components/doc_tooltip.tscn")
func _make_custom_tooltip(for_text: String) -> Object:
	var tooltip = tooltip_scene.instantiate()
	tooltip.text = for_text
	return tooltip
	
