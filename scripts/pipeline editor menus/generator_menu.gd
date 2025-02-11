extends GraphNodeMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	editor = $"../../VBoxContainer/GraphEdit"
	graph_nodes = [
		preload("res://components/graph nodes/generators/AmazonBedrockChatGenerator.tscn"),
		preload("res://components/graph nodes/generators/AmazonBedrockGenerator.tscn"),
		preload("res://components/graph nodes/generators/AnthropicChatGenerator.tscn"),
		preload("res://components/graph nodes/generators/AnthropicGenerator.tscn"),
		preload("res://components/graph nodes/generators/AnthropicVertexChatGenerator.tscn"),
		preload("res://components/graph nodes/generators/AzureOpenAIChatGenerator.tscn"),
		preload("res://components/graph nodes/generators/AzureOpenAIGenerator.tscn"),
		preload("res://components/graph nodes/generators/CohereChatGenerator.tscn"),
		preload("res://components/graph nodes/generators/CohereGenerator.tscn"),
		preload("res://components/graph nodes/generators/GoogleAIGeminiChatGenerator.tscn"),
		preload("res://components/graph nodes/generators/GoogleAIGeminiGenerator.tscn"),
		preload("res://components/graph nodes/generators/HuggingFaceAPIChatGenerator.tscn"),
		preload("res://components/graph nodes/generators/HuggingFaceAPIGenerator.tscn"),
		preload("res://components/graph nodes/generators/HuggingFaceLocalChatGenerator.tscn"),
		preload("res://components/graph nodes/generators/HuggingFaceLocalGenerator.tscn"),
		preload("res://components/graph nodes/generators/LlamaCppChatGenerator.tscn"),
		preload("res://components/graph nodes/generators/LlamaCppGenerator.tscn"),
		preload("res://components/graph nodes/generators/MistralChatGenerator.tscn"),
		preload("res://components/graph nodes/generators/NvidiaGenerator.tscn"),
		preload("res://components/graph nodes/generators/OllamaChatGenerator.tscn"),
		preload("res://components/graph nodes/generators/OllamaGenerator.tscn"),
		preload("res://components/graph nodes/generators/OpenAIChatGenerator.tscn"),
		preload("res://components/graph nodes/generators/OpenAIGenerator.tscn"),
		preload("res://components/graph nodes/generators/SagemakerGenerator.tscn"),
		preload("res://components/graph nodes/generators/VertexAICodeGenerator.tscn"),
		preload("res://components/graph nodes/generators/VertexAIGeminiChatGenerator.tscn"),
		preload("res://components/graph nodes/generators/VertexAIGeminiGenerator.tscn"),
		preload("res://components/graph nodes/generators/VertexAIImageCaptioner.tscn"),
		preload("res://components/graph nodes/generators/VertexAIImageGenerator.tscn"),
		preload("res://components/graph nodes/generators/VertexAIImageQA.tscn"),
		preload("res://components/graph nodes/generators/VertexAITextGenerator.tscn")
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
