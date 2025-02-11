extends GraphNodeMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	editor = $"../../VBoxContainer/GraphEdit"
	graph_nodes = [
		preload("res://components/graph nodes/retrievers/AstraEmbeddingRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/ChromaEmbeddingRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/ChromaQueryTextRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/ElasticsearchBM25Retriever.tscn"),
		preload("res://components/graph nodes/retrievers/ElasticsearchEmbeddingRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/FilterRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/InMemoryBM25Retriever.tscn"),
		preload("res://components/graph nodes/retrievers/InMemoryEmbeddingRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/MongoDBAtlasEmbeddingRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/OpenSearchBM25Retriever.tscn"),
		preload("res://components/graph nodes/retrievers/OpenSearchEmbeddingRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/PgvectorEmbeddingRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/PgvectorKeywordRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/PineconeEmbeddingRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/QdrantEmbeddingRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/QdrantHybridRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/QdrantSparseEmbeddingRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/SentenceWindowRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/SnowflakeTableRetriever.tscn"),
		preload("res://components/graph nodes/retrievers/WeaviateBM25Retriever.tscn"),
		preload("res://components/graph nodes/retrievers/WeaviateEmbeddingRetriever.tscn")
	]
