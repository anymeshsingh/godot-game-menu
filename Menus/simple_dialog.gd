extends Control

class_name SimpleDialog

# Exports
@export_multiline var question_text: String = "Question?"
@export var confim_text: String = "Yes"
@export var cancel_text: String = "No"

# Signals
signal on_confirm_pressed
signal on_cancel_pressed

# Refs
@onready var question_label: Label = $ColorRect/CenterContainer/PanelContainer/VBoxContainer/MarginContainer/QuestionLabel
@onready var confirm_button: Button = $ColorRect/CenterContainer/PanelContainer/VBoxContainer/HBoxContainer/ConfirmButton
@onready var cancel_button: Button = $ColorRect/CenterContainer/PanelContainer/VBoxContainer/HBoxContainer/CancelButton

static func init(question: String, confirm: String = "Yes", cancel: String = "No") -> SimpleDialog:
	var scene: PackedScene = preload("res://Menus/simple_dialog.tscn")
	var instance: SimpleDialog = scene.instantiate()
	instance.question_text = question
	instance.confim_text = confirm
	instance.cancel_text = cancel
	return instance

func _ready():
	question_label.text = question_text
	confirm_button.text = confim_text
	cancel_button.text = cancel_text
	update_controller_ui(GameInputManager.input_type)
	GameInputManager.on_input_type_changed.connect(update_controller_ui)

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		on_confirm_pressed.emit()
	elif Input.is_action_pressed("ui_cancel"):
		on_cancel_pressed.emit()

func update_controller_ui(input_type: GameInputManager.InputType):
	if input_type == GameInputManager.InputType.MNK:
		confirm_button.icon = null
		cancel_button.icon = null
	else:
		confirm_button.icon = preload("res://Icons/XboxButtons/A.png")
		cancel_button.icon = preload("res://Icons/XboxButtons/B.png")

func _on_confirm_button_pressed():
	on_confirm_pressed.emit()


func _on_cancel_button_pressed():
	on_cancel_pressed.emit()
