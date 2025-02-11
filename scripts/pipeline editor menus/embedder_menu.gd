extends GraphNodeMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	editor = $"../../VBoxContainer/GraphEdit"
	graph_nodes = [
		preload("res://components/graph nodes/embedders/AmazonBedrockDocumentEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/AmazonBedrockTextEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/AzureOpenAIDocumentEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/AzureOpenAITextEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/CohereDocumentEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/CohereTextEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/FastembedDocumentEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/FastembedSparseDocumentEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/FastembedSparseTextEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/FastembedTextEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/HuggingFaceAPIDocumentEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/HuggingFaceAPITextEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/JinaDocumentEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/JinaTextEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/MistralDocumentEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/MistralTextEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/NvidiaDocumentEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/NvidiaTextEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/OllamaDocumentEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/OllamaTextEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/OpenAIDocumentEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/OpenAITextEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/OptimumDocumentEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/OptimumTextEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/SentenceTransformersDocumentEmbedder.tscn"),
		preload("res://components/graph nodes/embedders/SentenceTransformersTextEmbedder.tscn")
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
