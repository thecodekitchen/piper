extends PipelineGraphNode

var loc_options:OptionButton
var type_options:OptionButton
var name_edit:LineEdit

func _ready() -> void:
	super._ready()
	inputs = [Pipeline.DataType.APIRoute]
	outputs = [Pipeline.DataType.PlainString]
	slot(0,Pipeline.DataType.APIRoute,Pipeline.DataType.PlainString)
	loc_options = $LocPicker/LocOptionButton
	loc_options.item_selected.connect(handle_select)
	type_options = $TypeRow/TypeOptionButton
	type_options.item_selected.connect(handle_type_change)
	name_edit = $NameRow/NameEdit
	name_edit.text_changed.connect(handle_name_change)
	
	if data.has("api_param"):
		if data["api_param"].has("idx"):
			print("found idx. Option: ", type_options.get_item_text(data["api_param"]["idx"]))
			type_options.select(data["api_param"]["idx"])
			handle_type_change(data["api_param"]["idx"])
		if data["api_param"].has("loc"):
			print("found loc: ", data["api_param"]["loc"])
			match data["api_param"]["loc"]:
				"Path":
					loc_options.select(0)
				"Query":
					loc_options.select(1)
				"Body":
					loc_options.select(2)
		if data["api_param"].has("name"):
			name_edit.text = data["api_param"]["name"]
	else:				
		data["api_param"] = {
			"route": "",
			"type": "str",
			"loc": "Path",
			"name": ""
		}
	
	
func handle_port_change(port:int,val)->void:
	if val.has("name"):
		data["api_param"]["route"] = val["name"]
	if val is Dictionary && val.has("method") && val["method"] == "GET":
		loc_options.select(0)
		loc_options.set_item_disabled(2,true)
	else:
		loc_options.set_item_disabled(2,false)
		
func handle_select(idx:int):
	var option = loc_options.get_item_text(idx)
	data["api_param"]["loc"] = option
	
func handle_name_change(new:String)->void:
	data["api_param"]["name"] = new

func handle_type_change(idx:int):
	var option = type_options.get_item_text(idx)
	if option == "List[Path]":
		data["api_param"]["type"] = "List[str]"
	elif option == "Path":
		data["api_param"]["type"] = "str"
	else:
		data["api_param"]["type"] = option
	data["api_param"]["idx"] = idx
	match option:
		"str":
			outputs[0] = Pipeline.DataType.PlainString
			slot(0,Pipeline.DataType.APIRoute,Pipeline.DataType.PlainString)
		"int":
			outputs[0] = Pipeline.DataType.Int
			slot(0,Pipeline.DataType.APIRoute,Pipeline.DataType.Int)
		"bool":
			outputs[0] = Pipeline.DataType.Bool
			slot(0,Pipeline.DataType.APIRoute,Pipeline.DataType.Bool)
		"dict":
			outputs[0] = Pipeline.DataType.MetaDict
			slot(0,Pipeline.DataType.APIRoute,Pipeline.DataType.MetaDict)
		"List[str]":
			outputs[0] = Pipeline.DataType.PlainStringList
			slot(0,Pipeline.DataType.APIRoute,Pipeline.DataType.PlainStringList)
#		TODO: Make better data type for int lists
		"List[int]":
			outputs[0] = Pipeline.DataType.Embedding
			slot(0,Pipeline.DataType.APIRoute,Pipeline.DataType.Embedding)
#		TODO: Same goes for bool lists
		"List[bool]":
			outputs[0] = Pipeline.DataType.ScoreDict
			slot(0,Pipeline.DataType.APIRoute,Pipeline.DataType.ScoreDict)
		"List[dict]":
			outputs[0] = Pipeline.DataType.MetaDictList
			slot(0,Pipeline.DataType.APIRoute,Pipeline.DataType.MetaDictList)
		"Path":
			outputs[0] = Pipeline.DataType.PathOrByteStreamList
			slot(0,Pipeline.DataType.APIRoute, Pipeline.DataType.PathOrByteStreamList)
		"List[Path]":
			outputs[0] = Pipeline.DataType.PathList
			slot(0,Pipeline.DataType.APIRoute,Pipeline.DataType.PathList)
		"ChatMessage":
			outputs[0] = Pipeline.DataType.ChatMessage
			slot(0,Pipeline.DataType.APIRoute,Pipeline.DataType.ChatMessage)
		"List[ChatMessage]":
			outputs[0] = Pipeline.DataType.ChatMessageList
			slot(0,Pipeline.DataType.APIRoute,Pipeline.DataType.ChatMessageList)
		_:
			outputs[0] = Pipeline.DataType.Any
			slot(0,Pipeline.DataType.APIRoute,Pipeline.DataType.Any)
