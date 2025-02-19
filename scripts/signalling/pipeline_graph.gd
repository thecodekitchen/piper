class_name PipelineGraphEdit
extends GraphEdit

signal node_added(name:StringName)
signal data_model_added(names:Array[String])
signal data_model_removed(names:Array[String])
var data_models:Array[DataModel]:
	get:
		return data_models
	set(new_array):
		var model_names = []
		for model in data_models:
			model_names.append(model._name)
#		model was added
		if data_models.size()<new_array.size():
			var new_model_name = new_array[-1]._name
			model_names.append(new_model_name)
			emit_signal("data_model_added",{"names":model_names})
#		model was removed
		elif data_models.size()>new_array.size():
			var new_names = []
			for model in new_array:
				new_names.append(model._name)
			emit_signal("data_model_removed",{"names":new_names})
		data_models = new_array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	honor_union_and_any_types()


func _node_added(node:Node)->void:
	if node is PipelineGraphNode:
		emit_signal("node_added", {"name": node.name})
	
func _popup_request(pos:Vector2) -> void:
	var popup_menu:PopupMenu = $"../../NodeMenu"
	popup_menu.popup(Rect2i(pos.x,pos.y,200,100))
	
func honor_union_and_any_types()->void:
#	Honor Any
	for i in range(Pipeline.DataType.keys().size()):
		add_valid_connection_type(i,Pipeline.DataType.Any)
#	Honor StringOrMessageList
	add_valid_connection_type(Pipeline.DataType.PlainStringList,Pipeline.DataType.StringOrMessageList)
	add_valid_connection_type(Pipeline.DataType.ChatMessageList,Pipeline.DataType.StringOrMessageList)
	add_valid_connection_type(Pipeline.DataType.EmbeddedDocumentList, Pipeline.DataType.DocumentList)
	add_valid_connection_type(Pipeline.DataType.EmbeddedDocument, Pipeline.DataType.Document)
	
func add_data_model(model:DataModel)->int:
	var new_models = data_models.duplicate()
	new_models.append(model)
	data_models = new_models
	return data_models.size()-1
	
func remove_model(idx:int)->void:
	var new_models = data_models.duplicate()
	new_models.remove_at(idx)
	data_models = new_models
