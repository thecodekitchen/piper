extends PipelineGraphNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	data["import"] = "haystack.components.builders.chat_prompt_builder.ChatPromptBuilder"
	data["component_name"] = "chat_prompt_builder"
	title = "Init"
	#graph_editor.connection_request.connect(_input_connected)
	inputs= [
		Pipeline.DataType.ChatTemplate,
		Pipeline.DataType.PlainStringList,
		Pipeline.DataType.PlainStringList
	]
	outputs = [
		Pipeline.DataType.ArgDict
	]
	if not data.has("value"):
		data["value"]={}
	if not data.has("api_variables"):
		data["api_variables"]={}
	inputs_allow_multi = [
		false,
		false,
		false
	]
	slot(0,Pipeline.DataType.ChatTemplate,Pipeline.DataType.ArgDict)
	slot(1,Pipeline.DataType.PlainStringList)
	slot(2,Pipeline.DataType.PlainStringList)
			
func handle_port_change(port:int,val)->void:
	match port:
		0:
			if val is Array && val.size() == 2:
				data["template"]=val
				print("template updated: ", data["template"])
		1:
			if val is Array:
				for v in val:
					if data.has("required_variables") && (data["required_variables"] as Array[String]).find(v)!=-1: 
						data["value"][v] = true
						set_value(data["value"])
					else:
						data["value"][v] = false
						set_value(data["value"])
				data["variables"]=val
				print("updated arg_dict: ", data["value"])
		2:
			if val is Array:
				data["required_variables"]=val
#					If no variables exist yet, populate them with new required variables
				if !data.has("variables"):
					data["variables"] = val
					set_value(data["value"])
				for v in val:
					data["value"][v] = true
					set_value(data["value"])
				print("updated arg_dict: ", data["value"])
				
func handle_param_assignment(port:int,param_data)->void:
	if param_data.has("name"):
		var param = param_data["name"]
		match port:
			0:
				data["api_variables"]["template"] = param
			1:
				data["api_variables"]["variables"] = param
			2:
				data["api_variables"]["required_variables"] = param
