local selectingPlayer = false
local prop = nil

local TriggerCallback
local Notification

local QBCore
ESX = nil
local CurrentFramework

if GetResourceState("es_extended") == "started" then
  CurrentFramework = "esx"
elseif GetResourceState("qb-core") == "started" then
  CurrentFramework = "qb"
else
  print("^8ERROR: ^3This script only supports ESX and QBCore frameworks, but non of these are not present. Unfortunatelly, you cannot use this script.^7")
  return
end

if CurrentFramework == "esx" then
  Citizen.CreateThread(function()
    ESX = exports["es_extended"]:getSharedObject()
    while ESX.GetPlayerData().job == nil do
      Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
  end)

  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
  end)

  RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
  end)

  TriggerCallback = function (name, cb, ...) 
    ESX.TriggerServerCallback(name, cb, ...)
  end

  Notification = function (msg) 
    ESX.ShowNotification(msg)
  end

elseif CurrentFramework == "qb" then
  QBCore = exports['qb-core']:GetCoreObject()
  TriggerCallback = function (name, cb, ...) 
    QBCore.Functions.TriggerCallback(name, cb, ...)
  end

  Notification = function (msg) 
    QBCore.Functions.Notify(msg)
  end
end

function holdDocument(shouldHold)
    if shouldHold then
      detachPaper()

      playAnim("missfam4", "base")

      attachPaper()

    else 
      ClearPedTasks(GetPlayerPed(-1))
      detachPaper()
    end
end

function playAnim(dict, anim, duration)
  duration = duration or -1
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Wait(10)
  end

  TaskPlayAnim(GetPlayerPed(-1), dict, anim, 2.0, 2.0, duration, 51, 0, false, false, false)
  RemoveAnimDict(dict)
end

function attachPaper()
  local player = PlayerPedId()
  local x,y,z = table.unpack(GetEntityCoords(player))

  while not HasModelLoaded(GetHashKey(Config.PaperProp.name)) do
    RequestModel(GetHashKey(Config.PaperProp.name))
    Wait(10)
  end

  prop = CreateObject(GetHashKey(Config.PaperProp.name), x, y, z+0.2,  true,  true, true)
  SetEntityCompletelyDisableCollision(prop, false, false)
  AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 36029), 0.16, 0.08, 0.1, Config.PaperProp.xRot, Config.PaperProp.yRot, Config.PaperProp.zRot, true, true, false, true, 1, true)
  SetModelAsNoLongerNeeded(Config.PaperProp.name)
end

function detachPaper()
  DeleteEntity(prop)
end

local function toggleNuiFrame(shouldShow, shouldHoldDocument)
  holdDocument(shouldHoldDocument)
  SetNuiFocus(shouldShow, shouldShow)
  SendReactMessage('setVisible', shouldShow)
end

local function toggleDocumentFrame(shouldShow, document)
  holdDocument(shouldShow)
  SetNuiFocus(shouldShow, shouldShow)
  SendReactMessage('setDocument', document)
end

RegisterNUICallback('hideDocument', function(_, cb)
  toggleDocumentFrame(false, nil)
  cb({})
end)

if CurrentFramework and Config.Command then
  RegisterCommand(Config.Command, function()
    toggleNuiFrame(true, true)
  end)
end

RegisterNUICallback('hideFrame', function(_, cb)
  toggleNuiFrame(false, false)
  cb({})
end)

RegisterNUICallback('getPlayerJob', function(data, cb)
  if CurrentFramework == "esx" then
    local retData <const> = ESX.PlayerData.job
    retData.isBoss = retData.grade_name == "boss"
    cb(retData)
  elseif CurrentFramework == "qb" then
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    local retData = {
      grade = PlayerJob.grade.level,
      grade_label = PlayerJob.grade.name,
      grade_name = PlayerJob.grade.name,
      grade_salary = PlayerJob.payment,
      label = PlayerJob.label,
      name = PlayerJob.name,
      skin_female = {},
      skin_male = {},
    }
    retData.isBoss = PlayerJob.isboss
    cb(retData)
  end
end)

RegisterNUICallback('getPlayerData', function(data, cb)
  if CurrentFramework == "esx" then
    ESX.TriggerServerCallback('pedy_dokumentum:getPlayerData', function(result)
      cb(result)
    end)
  elseif CurrentFramework == "qb" then
    local PlayerData = QBCore.Functions.GetPlayerData().charinfo
    cb({
      firstname = PlayerData.firstname,
      lastname = PlayerData.lastname,
      dateofbirth = PlayerData.birthdate,
    })
  end
end)

RegisterNUICallback('getPlayerCopies', function(data, cb)
  TriggerCallback('pedy_dokumentum:getPlayerCopies', function(result)
    cb(result)
  end)
end)

RegisterNUICallback('getIssuedDocuments', function(data, cb)
  TriggerCallback('pedy_dokumentum:getPlayerDocuments', function(result)
    cb(result)
  end)
end)

RegisterNUICallback('createDocument', function(data, cb)
  TriggerCallback('pedy_dokumentum:createDocument',function(result)
    cb(result)
  end,
  data)
end)

RegisterNUICallback('createTemplate', function(data, cb)
  TriggerCallback('pedy_dokumentum:createTemplate',function(result)
    cb(result)
  end,
  data)
end)

RegisterNUICallback('editTemplate', function(data, cb)
  TriggerCallback('pedy_dokumentum:editTemplate',function(result)
    cb(result)
  end,
  data)
end)

RegisterNUICallback('deleteTemplate', function(data, cb)
  TriggerCallback('pedy_dokumentum:deleteTemplate',function(result)
    cb(result)
  end,
  data)
end)

RegisterNUICallback('deleteDocument', function(data, cb)
  TriggerCallback('pedy_dokumentum:deleteDocument',function(result)
    cb(result)
  end,
  data)
end)

RegisterNUICallback('getMyTemplates', function(data, cb)
  TriggerCallback('pedy_dokumentum:getDocumentTemplates', function(result)
    cb(result)
  end)
end)

RegisterNUICallback('giveCopy', function(data, cb)
  Citizen.CreateThread(function()
    local targetId = playerSelector(Config.Locale.giveCopy)
    if targetId == -1 then
      holdDocument(false)
    else
      TriggerServerEvent("pedy_dokumentum:giveCopy", data, targetId)
    end
  end)
end)

RegisterNUICallback('showDocument', function(data, cb)
  Citizen.CreateThread(function()
    local targetId = playerSelector(Config.Locale.showDocument)
    if targetId == -1 then
      holdDocument(false)
    else
      holdDocument(false)
      playAnim("mp_common", "givetake1_a", 1500)
      TriggerServerEvent("pedy_dokumentum:receiveDocument", data, targetId)
    end
  end)
end)

RegisterNetEvent('pedy_dokumentum:copyGave')
AddEventHandler('pedy_dokumentum:copyGave', function(data)
	holdDocument(false)
  playAnim("mp_common", "givetake1_a", 1500)
  Notification(Config.Locale.giveNotification .. " " .. data)
end)

RegisterNetEvent("pedy_dokumentum:useItem")
AddEventHandler("pedy_dokumentum:useItem", function()
	toggleNuiFrame(true, true)
end)


RegisterNetEvent('pedy_dokumentum:copyReceived')
AddEventHandler('pedy_dokumentum:copyReceived', function(data)
  Notification(Config.Locale.receiveNotification .. " " .. data)
end)

RegisterNetEvent('pedy_dokumentum:viewDocument')
AddEventHandler('pedy_dokumentum:viewDocument', function(data)
	toggleDocumentFrame(true, data.data)
end)

function playerSelector(confirmText)
  toggleNuiFrame(false, true, nil)
  selectingPlayer = true

  while selectingPlayer do
    local closestPlayer, closestPlayerDistance
    if CurrentFramework == "esx" then
      closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
    elseif CurrentFramework == "qb" then
      closestPlayer, closestPlayerDistance = QBCore.Functions.GetClosestPlayer()
    end
    local closestPlayerCoords = GetEntityCoords(GetPlayerPed(closestPlayer))

    DisableControlAction(2, 200, true)

    if IsControlJustReleased(0, 202) then
      selectingPlayer = false
      return -1
    end

    BeginTextCommandDisplayHelp('main')
    AddTextEntry('main', "~INPUT_CONTEXT~ "..confirmText.."  ~INPUT_FRONTEND_PAUSE_ALTERNATE~ "..Config.Locale.cancel)
    EndTextCommandDisplayHelp(0, 0, 1, -1)

    if closestPlayer ~= -1 and closestPlayerDistance < 2.0 then
      DrawMarker(20, closestPlayerCoords.x, closestPlayerCoords.y, closestPlayerCoords.z + 1.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.4, 0.4, -0.4, 255, 255, 255, 100, false, true, 2, false, false, false, false)
      DrawMarker(25, closestPlayerCoords.x, closestPlayerCoords.y, closestPlayerCoords.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
      if IsControlJustReleased(0, 38) then
        selectingPlayer = false
        local targetId = GetPlayerServerId(closestPlayer)
        return targetId
      end
    else
      if IsControlJustReleased(0, 38) then
        Notification(Config.Locale.noPlayersAround)
      end
    end
    Citizen.Wait(1)
  end
end