extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_changed.connect(on_change)


func on_change(txt:String)->void:
	Globals.qdrant_api_key = txt
