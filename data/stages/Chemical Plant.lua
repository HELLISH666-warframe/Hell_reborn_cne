function onCreate()
	-- background shit

	makeLuaSprite('Ground1', 'Chemical Plant/Ground1', -1000, -700)
	scaleObject('Ground1', 1.6, 1.6)
	addLuaSprite('Ground1', false)

	makeLuaSprite('Ground2', 'Chemical Plant/Ground2', -1000, -700)
	scaleObject('Ground2', 1.6, 1.6)
	addLuaSprite('Ground2', true)

end
