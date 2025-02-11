extends PipelineGraphNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	component_type=Pipeline.ComponentType.OllamaChatGenerator
	inputs = [
		Pipeline.DataType.ChatMessageList
	]
	outputs = [
		Pipeline.DataType.ChatMessageList
	]
	slot(0,Pipeline.DataType.ChatMessageList,Pipeline.DataType.ChatMessageList)
	data["receivers"] = ["chat_generator.messages"]
	data["senders"] = ["chat_generator.replies"]
