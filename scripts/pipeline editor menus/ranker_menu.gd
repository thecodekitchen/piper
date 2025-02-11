extends GraphNodeMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	editor = $"../../VBoxContainer/GraphEdit"
	graph_nodes = [
		preload("res://components/graph nodes/rankers/CohereRanker.tscn"),
		preload("res://components/graph nodes/rankers/FastembedRanker.tscn"),
		preload("res://components/graph nodes/rankers/JinaRanker.tscn"),
		preload("res://components/graph nodes/rankers/LostInTheMiddleRanker.tscn"),
		preload("res://components/graph nodes/rankers/MetaFieldGroupingRanker.tscn"),
		preload("res://components/graph nodes/rankers/MetaFieldRanker.tscn"),
		preload("res://components/graph nodes/rankers/NvidiaRanker.tscn"),
		preload("res://components/graph nodes/rankers/SentenceTransformersDiversityRanker.tscn"),
		preload("res://components/graph nodes/rankers/TransformersSimilarityRanker.tscn")
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
