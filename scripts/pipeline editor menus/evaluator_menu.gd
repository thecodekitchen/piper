extends GraphNodeMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	editor = $"../../VBoxContainer/GraphEdit"
	graph_nodes = [
		preload("res://components/graph nodes/evaluators/AnswerExactMatchEvaluator.tscn"),
		preload("res://components/graph nodes/evaluators/ContextRelevanceEvaluator.tscn"),
		preload("res://components/graph nodes/evaluators/DeepEvalEvaluator.tscn"),
		preload("res://components/graph nodes/evaluators/DocumentMAPEvaluator.tscn"),
		preload("res://components/graph nodes/evaluators/DocumentNDCGEvaluator.tscn"),
		preload("res://components/graph nodes/evaluators/DocumentRecallEvaluator.tscn"),
		preload("res://components/graph nodes/evaluators/FaithfulnessEvaluator.tscn"),
		preload("res://components/graph nodes/evaluators/LLMEvaluator.tscn"),
		preload("res://components/graph nodes/evaluators/RagasEvaluator.tscn"),
		preload("res://components/graph nodes/evaluators/SASEvaluator.tscn")
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
