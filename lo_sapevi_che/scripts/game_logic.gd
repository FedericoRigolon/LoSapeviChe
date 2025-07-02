const MAX_SCORE = 5

var score: int

func _ready() -> void:
	score = 0

func _on_answer_chosen(correct: bool, score: int) -> void:
	if correct:
		self.score += score
