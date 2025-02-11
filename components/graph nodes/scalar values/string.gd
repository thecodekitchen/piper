extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	if not data.has("value"):
		data["value"] = "example"
	var val_edit = $SlotContainer0/StringEdit
	val_edit.text = data["value"]
	if not data.has("key"):
		data["key"] = "example"
	var key_edit = $KeyContainer/KeyEdit
	key_edit.text = data["key"]
	inputs = []
	outputs = [Pipeline.DataType.PlainString]
	set_slot(0,false,0,Color.WHITE,true,Pipeline.DataType.PlainString,pipeline.TypeColors["PlainString"])


func value_changed(text:String)->void:
	set_value(text)
	
func key_changed(text:String)->void:
	data["key"] = text
