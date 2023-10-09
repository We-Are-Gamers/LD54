extends Node2D


func _select_sound_effect(type: ActionType.ActionTypeEnum) -> AudioStreamPlayer:
	if type == ActionType.ROCK:
		return $Audio/RockSound
	elif type == ActionType.PAPER:
		return $Audio/PaperSound
	elif type == ActionType.SCISSORS:
		return $Audio/ScissorsSound
	return null


func _select_particles(type: ActionType.ActionTypeEnum) -> GPUParticles2D:
	return {
		ActionType.ROCK: $Particles/Rock,
		ActionType.PAPER: $Particles/Paper,
		ActionType.SCISSORS: $Particles/Scissors
	}[type]


func do_action(type: ActionType.ActionTypeEnum):
	_select_particles(type).restart()
	_select_sound_effect(type).play()
	
