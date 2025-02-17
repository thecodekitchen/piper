extends PipelineGraphNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	data["deps"] = [
		"ollama-haystack"
	]
	data["import"] = "haystack_integrations.components.generators.ollama.chat.chat_generator.OllamaChatGenerator"
	data["component_name"] = "chat_generator"
	component_type=Pipeline.ComponentType.OllamaChatGenerator
	inputs = [
		Pipeline.DataType.ModelName,
		Pipeline.DataType.URL
	]
	outputs = []
	slot(0,Pipeline.DataType.ModelName)
	slot(1,Pipeline.DataType.URL)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func handle_port_change(port:int,val)->void:
	match port:
		0:
			data["model"] = val
		1:
			data["url"] = val
