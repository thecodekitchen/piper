extends PipelineGraphNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs=[]
	outputs = [Pipeline.DataType.URL]
	slot(0,Pipeline.DataType.None,Pipeline.DataType.URL)
	var editor = $SlotContainer0/URLEdit
	editor.text_changed.connect(_url_changed)
	if data.has("value"):
		editor.text = data["value"]
	else:
		data["value"] = "http://localhost"
		editor.text = "http://localhost"
	
	if not data.has("key"):
		data["key"] = "example_url"
	var key_edit = $KeyContainer/KeyEdit as LineEdit
	key_edit.text = data["key"]
	key_edit.text_changed.connect(key_changed)
	
func _url_changed(new:String)->void:
	set_value(new)

func key_changed(new:String)->void:
	data["key"] = new
