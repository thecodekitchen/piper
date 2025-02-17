extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	title = "Run"
	data["component_name"] = "chat_prompt_builder"
	data["receivers"] = ["chat_prompt_builder.template"]
	data["senders"] = ["chat_prompt_builder.prompt"]
	if not data.has("connections"):
		data["connections"] = {}
	if not data.has("api_variables"):
		data["api_variables"] = {}
	inputs = [
		Pipeline.DataType.ChatTemplate,
		Pipeline.DataType.ArgDict
	]
	outputs = [
		Pipeline.DataType.ChatMessageList
	]
	slot(0,Pipeline.DataType.ChatTemplate,Pipeline.DataType.ChatMessageList)
	slot(1,Pipeline.DataType.ArgDict)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func handle_port_change(port:int,val)->void:
	match port:
		0:
			if not data.has("run_values"):
				data["run_values"] = {"template": val}
			else:
				data["run_values"]["template"] = val
		1:
#			Handle arg update
			if val is Dictionary:
#				If any ports from the arg node have been parameterized, pass those parameters to the CPB
				if val.has("api_variables"):
					if not data.has("api_variables"):
						data["api_variables"] = val["api_variables"]
					else:
						data["api_variables"].merge(val["api_variables"])
				if val.has("values"):
					if not data.has("run_values"):
						data["run_values"] = val["values"]
					else:
						data["run_values"].merge(val["values"])
				if val.has("kwargs") and val["kwargs"] is Dictionary:
					data["receivers"] = ["chat_prompt_builder.template"]
					for kwarg in val["kwargs"].keys():
						data["receivers"].append("chat_prompt_builder."+kwarg)
				if val.has("senders") and val["senders"] is Dictionary:
					for arg in val["senders"].keys():
						if not data["connections"].has("chat_prompt_builder."+arg):
							data["connections"]["chat_prompt_builder."+arg] = [val["senders"][arg]]
						else:
							data["connections"]["chat_prompt_builder."+arg].append(val["senders"][arg])
