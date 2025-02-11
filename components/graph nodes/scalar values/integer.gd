extends PipelineGraphNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not data.has("value"):
		data["value"] = 0
	else:
		var int_edit = $SlotContainer/IntEdit
		int_edit.text = str(data["value"])
	if not data.has("key"):
		data["key"]="int_var"
	else:
		var key_edit = $KeyContainer/KeyEdit
		key_edit.text = data["key"]
	inputs = []
	outputs = [
		Pipeline.DataType.Int
	]
	set_slot(0,false,0,Color.WHITE,true,Pipeline.DataType.Int,Color.CRIMSON)


func value_changed(text:String)->void:
	var int_edit:LineEdit = $SlotContainer/IntEdit
	if text.is_valid_int():
		set_value(int(text))
	else:
		push_error("invalid input to integer scalar node")
		var sanitized_value = get_digits(text)
		int_edit.text = sanitized_value
	
func key_changed(text:String)->void:
	data["key"] = text
	
func get_digits(input_string: String) -> String:
	var digits = ""
	for character in input_string:
		if character.is_valid_int():
			digits += character
	return digits
