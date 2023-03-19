--SETTINGS
activated = false;

local prevTime = 0
local curEvent = -1;
local Events = {
	'Note Alpha',
	'BF Spin',
	'Scroll Speed',
	'Infinite HP',
	'Poison',
	'Fat',
	'Dizzy'
}
local EventText = {
	"Somebody's Notes will fade out!",
	"Somebody will start spinning!",
	"Somebody's Scroll speed will be random!",
	"Somebody will have infinite health!",
	"Somebody will be poisoned!",
	"Someone will become fat!",
	"Somebody will become dizzy!"
}

function onSongStart()
	prevTime = getSongPosition()
end

local prevAngle = -1;
local prevScrollSpeed = -1;

function onUpdate()
	if not activated then
		return;
	end

	if getSongPosition() >= (prevTime + 30000) then
		if curEvent == 1 then
			for i = 1, 8 do
				noteTweenAlpha('a'..i, i-1, 1, 1, 'sineInOut')
			end
		elseif curEvent == 2 then
			setProperty('boyfriend.angle', prevAngle)
		elseif curEvent == 3 then
			setProperty('songSpeed', prevScrollSpeed)
		end
		prevTime = getSongPosition()
		curEvent = getRandomInt(1, 6)
		print(EventText[curEvent])
		if curEvent == 1 then
			for i = 1, 8 do
				noteTweenAlpha('a'..i, i-1, 0.3, 1, 'sineInOut')
			end
		elseif curEvent == 2 then
			prevAngle = getProperty('boyfriend.angle')
		elseif curEvent == 3 then
			prevScrollSpeed = getProperty('songSpeed')
			setProperty('songSpeed', getRandomFloat(getProperty('songSpeed') - 0.4, getProperty('songSpeed') + 0.4))
		elseif curEvent == 6 then
			setProperty('boyfriend.scale.x', 2)
		end
	end

	if curEvent == 2 then
		setProperty('boyfriend.angle', getProperty('boyfriend.angle') + 0.25)
	elseif curEvent == 4 and getProperty('health') <= 0 then
		setProperty('health', 0.0000001)
	elseif curEvent == 5 then
		setProperty('health', getProperty('health') -0.001)
	end
end