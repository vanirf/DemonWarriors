azmarog =''
bullrik =''
krasit =''
sensal =''

function ClearAllDemonNames()
azmarog =nil
bullrik =nil
krasit =nil
sensal =nil
end


function SafeDemonName(_demonName, _demonType)
if _demonType == 'azmarog' then
azmarog =_demonName
end
if _demonType == 'bullrik' then
bullrik = _demonName
end
if _demonType == 'krasit' then
krasit = _demonName
end
if _demonType == 'sensal' then
sensal =_demonName
end
end


function InsertDemon(_demonType, _demonName)
_demonType = string.lower (_demonType)
_demonName = string.lower (_demonName)
SafeDemonName(_demonName, _demonType)
end