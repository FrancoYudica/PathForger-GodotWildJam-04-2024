extends CanvasLayer

@export var level: Level

@onready var best_score_value_label := $LocalUIControl/ScoreDataGridContainer/BestScoreValue
@onready var total_score_value_label := $LocalUIControl/ScoreDataGridContainer/TotalValue
@onready var deaths_value_label := $LocalUIControl/ScoreDataGridContainer/DeathsValue
@onready var averaga_value_label := $LocalUIControl/ScoreDataGridContainer/AverageValue
@onready var last_score_value_label := $LocalUIControl/LastScore

func enter():
	
	var score_data: ScoreData = level.score_data
	
	last_score_value_label.text = str(score_data.last_score)
	
	best_score_value_label.text = str(score_data.best)
	total_score_value_label.text = str(score_data.total)
	deaths_value_label.text = str(score_data.deaths)
	
	var average = score_data.total
	if level.score_data.deaths != 0:
		average /= score_data.deaths
	
	averaga_value_label.text = str(average)
	
	
func exit():
	pass
