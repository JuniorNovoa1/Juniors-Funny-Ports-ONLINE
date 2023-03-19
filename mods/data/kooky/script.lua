local oldVAR = false;

function onCreate()
	oldVAR = getPropertyFromClass('ClientPrefs', 'downscroll');
	setPropertyFromClass('ClientPrefs', 'downscroll', false)
end

function onCreatePost()
	local scaleXY = 0.8;
	for direction = 0, 3 do
		setPropertyFromGroup('opponentStrums', direction, 'visible', false)
		setPropertyFromGroup('playerStrums', direction, 'x', getPropertyFromGroup('opponentStrums', direction, 'x') + 62.5)
		setPropertyFromGroup('playerStrums', direction, 'y', getPropertyFromGroup('playerStrums', direction, 'y') - 115)
		setPropertyFromGroup('playerStrums', direction, 'scale.x', scaleXY)
		setPropertyFromGroup('playerStrums', direction, 'scale.y', scaleXY)

		local offsetss = 25 * direction;
		setPropertyFromGroup('playerStrums', direction, 'x', getPropertyFromGroup('playerStrums', direction, 'x') + offsetss)
	end
	for i = 1, getProperty('unspawnNotes.length') -1 do
		setPropertyFromGroup('unspawnNotes', i-1, 'scale.x', scaleXY)
		setPropertyFromGroup('unspawnNotes', i-1, 'scale.y', scaleXY)
		if getPropertyFromGroup('unspawnNotes', i-1, 'mustPress') == false then
			setPropertyFromGroup('unspawnNotes', i-1, 'visible', false)
		end
	end
	for i = 0, 4, 1 do
		setObjectCamera('playerStrums.members['..i..']', 'camGame')
	end
	
	setObjectCamera('scoreTxt', 'camGame')
	setObjectCamera('healthBarBG', 'camGame')
	setObjectCamera('healthBar', 'camGame')
	setObjectCamera('iconP1', 'camGame')
	setObjectCamera('iconP2', 'camGame')
	setObjectOrder('grid', getObjectOrder('iconP2') +1)

	scaleObject('healthBarBG', 0.8, 3)
	scaleObject('healthBar', 0.8, 4)
	setProperty('healthBarBG.angle', 90)
	setProperty('healthBar.angle', 90)
	setProperty('healthBarBG.x', 850)
	setProperty('healthBar.x', 850)
	setProperty('healthBarBG.y', 550)
	setProperty('healthBar.y', 550)
	setProperty('healthBarBG.flipX', true)
	setProperty('healthBar.flipX', true)
end

function onUpdate()
	setProperty('camFollow.x', 750);
	setProperty('camFollow.y', 340);
end

function onUpdatePost()
	setProperty('iconP1.x', getProperty('healthBarBG.x') * 1.1625)
	setProperty('iconP2.x', getProperty('healthBarBG.x') * 1.225)
	setProperty('iconP1.y', getProperty('healthBarBG.y') / 1.925)
	setProperty('iconP2.y', getProperty('healthBarBG.y') * 1.225)

	for i = 1, getProperty('notes.length') -1 do
		setObjectCamera('notes.members['..i..']', 'camGame')
	end
end

function onEndSong()
	setPropertyFromClass('ClientPrefs', 'downscroll', oldVAR)
end