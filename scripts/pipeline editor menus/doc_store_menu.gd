extends GraphNodeMenu

func _ready() -> void:
	super._ready()
	editor = $"../../VBoxContainer/GraphEdit"
	graph_nodes = [
		preload("res://components/graph nodes/doc stores/InMemoryDocumentStore.tscn"),
		preload("res://components/graph nodes/doc stores/AstraDocumentStore.tscn"),
		preload("res://components/graph nodes/doc stores/AzureAISearchDocumentStore.tscn"),
		preload("res://components/graph nodes/doc stores/ChromaDocumentStore.tscn"),
		preload("res://components/graph nodes/doc stores/ElasticsearchDocumentStore.tscn"),
		preload("res://components/graph nodes/doc stores/MilvusDocumentStore.tscn"),
		preload("res://components/graph nodes/doc stores/MongoDBAtlasDocumentStore.tscn"),
		preload("res://components/graph nodes/doc stores/Neo4jDocumentStore.tscn"),
		preload("res://components/graph nodes/doc stores/OpenSearchDocumentStore.tscn"),
		preload("res://components/graph nodes/doc stores/PgvectorDocumentStore.tscn"),
		preload("res://components/graph nodes/doc stores/PineconeDocumentStore.tscn"),
		preload("res://components/graph nodes/doc stores/QdrantDocumentStore.tscn"),
		preload("res://components/graph nodes/doc stores/WeaviateDocumentStore.tscn"),
	]
