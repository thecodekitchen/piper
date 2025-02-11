extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	title = "Run"
	data["receivers"] = ["chat_prompt_builder.template"]
	data["senders"] = ["chat_prompt_builder.prompt"]
	
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
func _process(delta: float) -> void:
	pass
