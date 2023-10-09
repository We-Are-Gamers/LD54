extends Node2D


func _select_sound_effect(type: ActionType.ActionTypeEnum) -> AudioStreamPlayer:
	return {
		ActionType.ROCK: $Audio/RockSound,
		ActionType.PAPER: $Audio/PaperSound,
		ActionType.SCISSORS: $Audio/ScissorsSound,
		ActionType.HEAL: $Audio/HealSound
	}[type]


func _select_particles(type: ActionType.ActionTypeEnum) -> GPUParticles2D:
	return {
		ActionType.ROCK: $Particles/Rock,
		ActionType.PAPER: $Particles/Paper,
		ActionType.SCISSORS: $Particles/Scissors,
		ActionType.HEAL: $Particles/Heal
	}[type]


func do_action(type: ActionType.ActionTypeEnum):
	_select_particles(type).restart()
	_select_sound_effect(type).play()
	
