extends PipelineGraphFrame

func _ready()->void:
	super._ready()
	component_type=Pipeline.ComponentType.OllamaChatGenerator
