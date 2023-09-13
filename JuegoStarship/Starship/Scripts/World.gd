extends Node

onready var particles = $Particles2D

func _ready():
	$Detectors/Detector_1.connect("area_entered",self,"_on_Detector_1_area_entered")
	$Detectors/Detector_2.connect("area_entered",self,"_on_Detector_2_area_entered")
	$Detectors/Detector_3.connect("area_entered",self,"_on_Detector_3_area_entered")

func _on_Detector_1_area_entered(area):
	particles.speed_scale = 1
func _on_Detector_2_area_entered(area):
	particles.speed_scale = 1.5
func _on_Detector_3_area_entered(area):
	particles.speed_scale = 2
