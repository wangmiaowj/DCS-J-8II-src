dofile("Aircraft/Engines/Engine.lua")
J_8B_eng = engine:new()

function J_8B_eng:initNames()
	self.core_name  = "Aircrafts/Engines/EngineTF34GE100Core"
	self.core2_name  = "Aircrafts/Engines/EngineTF34GE100Core"
	self.core3_name  = "Aircrafts/Engines/EngineTF34GE100Core"
	self.jet_name   = "Aircrafts/J-8/Engines/J8BackEngine"
	self.jet2_name   = "Aircrafts/J-8/Engines/J8BackEngine"
	--self.fan_name   = "Aircrafts/Engines/EngineTF34GE100Core"
	self.turb_name  = "Aircrafts/Engines/EngineTF34GE100Turbine"
	self.around_name = "Aircrafts/J-8/Engines/J8Afterburner"
end

function J_8B_eng:initCptNames()
	self.engine_l_name  = "Aircrafts/F-22A/Cockpit/F-22A_Afterburner"
	self.engine_r_name  = "Aircrafts/F-22A/Cockpit/F-22A_Afterburner"
	self.heAmb_l_name   = "Aircrafts/F-22A/Cockpit/F-22A_Idle"
	self.heAmb_r_name   = "Aircrafts/F-22A/Cockpit/F-22A_Idle"
end

function J_8B_eng:calculatePitchGainCore(coreRPM)
	return coreRPM, math.sqrt(coreRPM)
end

function J_8B_eng:calculatePitchGainCore2(coreRPM, fanRPM)
	return coreRPM, math.sqrt(coreRPM)
end

function J_8B_eng:calculatePitchGainCore3(coreRPM, fanRPM)
	return coreRPM, math.sqrt(coreRPM)
end

function J_8B_eng:calculatePitchGainFan(fanRPM)
	local gain = 1
	if fanRPM < 0.5 then
		gain = fanRPM * 2
	end
	
	return fanRPM, gain
end

function J_8B_eng:calculatePitchGainTurb(fanRPM, coreRPM, turbPower)
	local pitch = fanRPM
	if pitch == 0 then
		pitch = coreRPM -- using core if no fan is present
	end
	return pitch, turbPower
end

function J_8B_eng:calculatePitchGainAround(fanRPM, coreRPM, coreRPM2)
	local pitch = fanRPM
	if pitch == 0 then
		pitch = coreRPM -- using core if no fan is present
	end
	
	return pitch, math.max(0, 5.6592*coreRPM2*coreRPM2 - 13.259*coreRPM2*coreRPM + 8.3924*coreRPM2 - 0.337*coreRPM - 0.0048)
end

function J_8B_eng:calculatePitchGainJet(fanRPM, coreRPM, thrust, flame)
	local RPM = fanRPM
	if RPM == 0 then
		RPM = coreRPM -- using core if no fan is present
	end
	
	local gain = math.sqrt(thrust)
	if thrust < 0.05 and flame > 0 then
		gain = 0.23 * coreRPM / 0.7
	end
		
	return 0.5 + 0.5 * RPM, gain
end

function J_8B_eng:calculatePitchGainJet2(thrust)
	local gain
	if thrust > 0.4 then
		gain =  1.67 * thrust - 0.67
	else
		gain = 0
	end
		
	return 1.0, gain
end

function J_8B_eng:calculatePitchGainCpt(coreRPM)
	return coreRPM, 0.4 * math.sqrt(coreRPM)
end

function J_8B_eng:calculatePitchGainCpt2(coreRPM, fanRPM, turbPower, vTrue)
	return coreRPM, 1 - (math.exp(-(math.pow(coreRPM, 7))))
end

function J_8B_eng:calculatePitchGainCptAmb(coreRPM, coreRPM2)
	local gain = 1
	if coreRPM < 0.6784 then
		gain = math.max(0, 2.0967 * coreRPM2 + 0.0516 * coreRPM - 6E-15)
	end
	
	return 1, gain
end

-- function J_8B_eng:update(coreRPM, fanRPM, turbPower, thrust, flame)
-- 	engine:update(coreRPM, fanRPM, turbPower, thrust, flame)

-- end