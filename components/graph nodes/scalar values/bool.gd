extends PipelineGraphNode

var label:Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	label = $SlotContainer/Label
	inputs = []
	outputs = [Pipeline.DataType.Bool]
	slot(0,Pipeline.DataType.None,Pipeline.DataType.Bool)
	
	if not data.has("value"):
		data["value"] = false
	elif data["value"]:
		var check_button = $SlotContainer/CheckButton
		check_button.button_pressed = true
		
func toggle_value(on:bool) -> void:
	set_value(on)
	if on:
		label.text = "True"
		set_slot_color_right(0, Color.WHITE)
	else:
		label.text = "False"
		set_slot_color_right(0, Color.BLACK)
		
func key_changed(text:String)->void:
	data["key"] = text
