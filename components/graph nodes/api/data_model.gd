class_name DataModelNode
extends PipelineGraphNode

var kv_row_scene:PackedScene
var kv_rows:Array[KeyValueRow] = []
var custom_types:Array[String] = []
var pipeline_types:Array[String] = []
var model_idx:int
var name_edit:LineEdit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	kv_row_scene = preload("res://components/graph nodes/api/kv_row.tscn")
	name_edit = $NameRow/NameEdit
	name_edit.text = "NewModel"
	name_edit.text_submitted.connect(_model_name_submitted)
	
	for type in Pipeline.DataType.keys():
		if type is String:
			pipeline_types.append(type)
	if custom_types.size() == 0:
		for model in graph_editor.data_models:
			custom_types.append(model.name)
#	Only initialize with example values if none are assigned prior to entering tree during loading
	if not data.has("name"):
		data["name"] = "NewModel"
	if not data.has("spec"):
		data["spec"] = {
			"example": {
				"type": "PlainString",
				"custom": false
			}
		}
	var spec = data["spec"]
	for key in spec.keys():
		var type = spec[key]["type"]
		var is_custom = spec[key]["custom"]
		kv_rows.append(make_kv_row(key,type,is_custom))

	for i in range(graph_editor.data_models.size()):
		var model = graph_editor.data_models[i]
#		Found self in models, record index
		if model._name == data["name"]:
			model_idx = i
	if not model_idx:
#		Model not found, add to editor and record index
		print(data["name"])
		print(spec)
		model_idx = graph_editor.add_data_model(DataModel.new(data["name"],spec))

func refresh_editor()->void:
	var parent = get_parent()
	if graph_editor == null:
		if parent is PipelineGraphEdit:
			graph_editor = parent
		else:
			push_error("DataModelNode used in incorrect context. Should be child of PipelineGraphEdit.")

func _model_name_submitted(new:String)->void:
	data["name"] = new
	var models = graph_editor.data_models
	if models.size() > model_idx:
		models[model_idx]._name = new
	else:
		push_error("model_idx not found!")			
		
func _custom_changed(key:String,val:bool)->void:
	data["spec"][key]["custom"] = val
	update_rows()
	update_editor()
	
func _type_changed(key:String,val:String)->void:
	data["spec"][key]["type"] = val
	update_rows()
	update_editor()

func _key_changed(idx:int,new_key:String)->void:
	var spec = data["spec"] as Dictionary
	if spec.keys().size()<=idx:
		push_error("key changed out of bounds")
		return
	if new_key in spec:
		push_error("new key already exists")
		return
	var old_key = spec.keys()[idx]
	var prop_data = spec[old_key]
	spec.erase(old_key)
	spec[new_key] = prop_data
	update_rows()
	update_editor()
	
func _add_pressed()->void:
	var row = make_kv_row("new","PlainString",false)
	kv_rows.append(row)
	add_child(row)
	data["spec"]["new"]={"type":"PlainString","custom":false}
	update_rows()
	update_editor()

func update_editor()->void:
	graph_editor.data_models[model_idx] = DataModel.new(data["name"],data["spec"])

func update_rows()->void:
	var rows:Array[KeyValueRow] = []
	for child in get_children():
		if child is KeyValueRow:
			rows.append(child)
	kv_rows = rows	
func make_kv_row(key:String,type:String,is_custom:bool)->KeyValueRow:
	var row = kv_row_scene.instantiate() as KeyValueRow
	add_child(row)
	row.custom_changed.connect(_custom_changed)
	row.type_changed.connect(_type_changed)
	row.key_changed.connect(_key_changed)
	row.add_pressed.connect(_add_pressed)
	row.custom_type_button.button_pressed=is_custom
	row.key_edit.text = key
	if is_custom:
		row.type_option_button.clear()
		for custom_type in custom_types:
			row.type_option_button.add_item(custom_type)
		row.type_option_button.select(custom_types.find(type))
	else:
		row.type_option_button.clear()
		for pipeline_type in pipeline_types:
			row.type_option_button.add_item(pipeline_type)
		row.type_option_button.select(pipeline_types.find(type))
	return row
