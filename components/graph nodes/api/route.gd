extends PipelineGraphNode

var method_options:OptionButton
var name_edit:LineEdit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs = [Pipeline.DataType.APIResponse]
	outputs = [Pipeline.DataType.APIRoute]
	slot(0,Pipeline.DataType.APIResponse,Pipeline.DataType.APIRoute)
	method_options = $MethodPicker/MethodOptionButton
	name_edit = $NameRow/NameEdit
	method_options.item_selected.connect(method_selected)
	name_edit.text_changed.connect(name_changed)
	if data.has("value"):
		if data["value"].has("method"):
			match data["value"]["method"]:
				"GET":
					method_options.select(0)
				"POST":
					method_options.select(1)
		else:
			data["value"]["method"] = "GET"
			method_options.select(0)
		if data.has("route"):
			name_edit.text = data["route"]
		else:
			data["route"] = []
	else:
		data["value"]= {
			"method": "GET"
		}
		method_options.select(0)
		data["route"] = ""
	
	
func method_selected(idx:int)->void:
	var option = method_options.get_item_text(idx)
	data["value"]["method"] = option
	set_value(data["value"])
	
func name_changed(new:String)->void:
	data["value"]["name"] = new
	data["route"] = new
	set_value(data["value"])
