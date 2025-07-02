extends Label

class_name Question

var _score: int

func setup(text: String , score: int = 1):
	set_text(text)
	self._score = score

func set_score(score: int = 1):
	self._score = score

func get_score() -> int:
	return self._score
