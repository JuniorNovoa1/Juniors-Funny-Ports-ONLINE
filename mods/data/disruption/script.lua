local originPosX = {};
local originPosY = {};
function onCreatePost()
    for i = 0, getProperty('strumLineNotes.length') do
        originPosX[i] = getPropertyFromGroup('strumLineNotes', i, 'x')
        originPosY[i] = getPropertyFromGroup('strumLineNotes', i, 'y')
    end
    for i = 0, getProperty('unspawnNotes.length') -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') ~= '' then --only "player" side
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets_3D')
        end
    end
end

function onUpdate(elapsed)
    for i = 0, getProperty('strumLineNotes.length') do
        local krunkThing = 60;
        if getPropertyFromGroup('strumLineNotes', i, 'ID') % 2 == 0 then
            setPropertyFromGroup('strumLineNotes', i, 'x', originPosX[i] + ((math.sin(elapsed) * (1) * krunkThing)))
            setPropertyFromGroup('strumLineNotes', i, 'y', originPosY[i] + (math.sin(elapsed - 5) * (1) * krunkThing))
            --setPropertyFromGroup('strumLineNotes', i, 'scale.x', math.abs(math.sin(elapsed - 5) * (1) / 4))
            --setPropertyFromGroup('strumLineNotes', i, 'scale.y', math.abs((math.sin(elapsed) * (1)) / 2))
        else
            setPropertyFromGroup('strumLineNotes', i, 'x', originPosX[i] + ((math.sin(elapsed) * (-1) * krunkThing)))
            setPropertyFromGroup('strumLineNotes', i, 'y', originPosY[i] + (math.sin(elapsed - 5) * (-1) * krunkThing))
            --setPropertyFromGroup('strumLineNotes', i, 'scale.x', math.abs(math.sin(elapsed - 5) * (-1) / 4))
            --setPropertyFromGroup('strumLineNotes', i, 'scale.y', math.abs((math.sin(elapsed) * (-1)) / 2))
        end

        --[[setPropertyFromGroup('strumLineNotes', i, 'scale.x', getPropertyFromGroup('strumLineNotes', i, 'scale.x') + 0.2)
        setPropertyFromGroup('strumLineNotes', i, 'scale.y', getPropertyFromGroup('strumLineNotes', i, 'scale.y') + 0.2)

        setPropertyFromGroup('strumLineNotes', i, 'scale.x', getPropertyFromGroup('strumLineNotes', i, 'scale.x') * 1.5)
        setPropertyFromGroup('strumLineNotes', i, 'scale.y', getPropertyFromGroup('strumLineNotes', i, 'scale.y') * 1.5)--]]
    end
end

function onTweenCompleted(tag)
    for i = 0, getProperty('strumLineNotes.length') -1 do
        if tag == 'noteXLeft'..i then
            noteTweenX('noteXRight'..i, i, originPosX[i] +offset, tweenTime, tweenType)
        end
        if tag == 'noteXRight'..i then
            noteTweenX('noteXLeft'..i, i, originPosX[i] -offset, tweenTime, tweenType)
        end
        if tag == 'noteYUp'..i then
            noteTweenY('noteYDown'..i, i, originPosY[i] +offset, tweenTime, tweenType)
        end
        if tag == 'noteYDown'..i then
            noteTweenY('noteYUp'..i, i, originPosY[i] -offset, tweenTime, tweenType)
        end
    end
end