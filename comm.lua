local menus = data.menus

local parameters = {
	fighter = true,
	radar = true,
	ECM = true,
	refueling = true,
}

utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/LockOnAirplane.lua', getfenv()))(parameters)
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/JTAC.lua', getfenv()))(4)
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/ATC.lua', getfenv()))(5, {['Airdrome'] = true, ['Helipad'] = false} )
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/Tanker.lua', getfenv()))(6)
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/AWACS.lua', getfenv()))(7, {tanker = true, radar = true})
utils.verifyChunk(utils.loadfileIn('Scripts/UI/RadioCommandDialogPanel/Config/Common/Ground Crew.lua', getfenv()))(8)

-- set the rocket configration
menus['Wheel chocks'] = {
	name = _('Wheel chocks'),
	items = {
        [1] = {name = _('Place_').._('Wheel chocks'),         command = sendMessage.new(Message.wMsgLeaderGroundToggleWheelChocks, true)},
        [2] = {name = _('Remove_').._('Wheel chocks'),        command = sendMessage.new(Message.wMsgLeaderGroundToggleWheelChocks, false)}
    }
	
}

menus['AAR Probe'] = {
	name = _('AAR Probe'),
	items = {
		[1] = {
			name = _('Install Probe'), 		
			command = 6103
		},
		[2] = {
			name = _('Uninstall Probe'),
			command = 6104
		},
	}
}

menus['Ground Crew'].items[4] = { name = _('Wheel chocks'), submenu = menus['Wheel chocks']}
menus['Ground Crew'].items[5] = { name = _('AAR Probe'), submenu = menus['AAR Probe']}