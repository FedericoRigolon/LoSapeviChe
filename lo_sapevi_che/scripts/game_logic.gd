const MAX_SCORE = 5

var score: int

func _ready():
	score = 0

func _on_round_finished(correct: bool, score: int):
	if correct:
		self.score += score
