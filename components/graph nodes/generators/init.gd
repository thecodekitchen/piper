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
	input_connected.connect(_input_connected)
	inputs = [
		Pipeline.DataType.ModelName,
		Pipeline.DataType.URL
	]
	outputs = []
	slot(0,Pipeline.DataType.ModelName)
	slot(1,Pipeline.DataType.URL)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input_connected(port:int,from:StringName,from_port:int)->void:
	match port:
		0:
			store_source_value(from,"model")
		1:
			store_source_value(from,"url")
