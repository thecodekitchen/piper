extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	if not data.has("value"):
		data["value"] = ""
	else:
		var editor = $SlotContainer/APIKeyEdit
		editor.text = data["value"]
	if not data.has("key"):
		data["key"] = "api_key"
	else:
		var key_editor = $KeyContainer/KeyEdit
		key_editor.text = data["key"]
	inputs = []
	outputs = [Pipeline.DataType.ApiKey]
	set_slot(0,false,0,Color.WHITE,true,Pipeline.DataType.ApiKey,Color.FIREBRICK)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func value_changed(text:String)->void:
	set_value(text)

func key_changed(text:String)->void:
	data["key"] = text
