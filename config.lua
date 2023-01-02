Config = {}

Config.Command = "dokumentum" -- If nil, the command won't work

Config.DocumentItemName = "mappa" -- The name of the item you want to open the documents. If nil, no item will be registered

Config.PaperProp = {
  name = "prop_cd_paper_pile1",
  xRot = -130.0, 
	yRot = -50.0, 
	zRot = 0.0
}
-- These texts only show up on client side. To change texts in the NUI,
-- go to the web/build/config.js file
Config.Locale = {
  ["receiveNotification"] = "Kapott egy dokumentumot: ",
  ["giveNotification"] = "Adtál egy dokumentumot: ",
  ["cancel"] = "Mégsem",
  ["noPlayersAround"] = "Nincs körülötted senki",
  ["showDocument"] = "Dokumentum megjelenítése",
  ["giveCopy"] = "Adjon másolatot"
}