extends PipelineGraphNode

var model_picker:OptionButton
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	model_picker = $HBoxContainer/ModelPicker
	model_picker.item_selected.connect(handle_select)
	inputs=[]
	outputs=[Pipeline.DataType.ModelName]
	slot(0,Pipeline.DataType.None,Pipeline.DataType.ModelName)
	if data.has("value"):
		for i in model_picker.item_count:
			if model_picker.get_item_text(i) == data["value"]:
				model_picker.select(i)
				break
	else:
		data["value"] = model_picker.get_item_text(0)
		model_picker.select(0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func handle_select(idx:int)->void:
	var item = model_picker.get_item_text(idx)
	set_value(item)
