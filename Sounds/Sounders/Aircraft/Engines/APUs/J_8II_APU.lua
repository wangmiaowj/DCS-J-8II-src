J_8II_APU = {cockpit = {}}

function J_8II_APU:new()
	o = {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function J_8II_APU:create(APUhost)
	self.rpm_sub = 0
	self.sndAPU = ED_AudioAPI.createSource(APUhost, "Aircrafts/Engines/Motor/J8Motor")
	self.sndAPUbegin = ED_AudioAPI.createSource(APUhost, "Aircrafts/Engines/Motor/J8MotorBegin")
	self.sndAPUEnd = ED_AudioAPI.createSource(APUhost, "Aircrafts/ASU_End")
end

function J_8II_APU:createCpt(APUhostCpt)
	self.cockpit.sndAPU = ED_AudioAPI.createSource(APUhostCpt, "Aircrafts/Engines/Motor/J8Motor")
	ED_AudioAPI.linkSource(self.sndAPU, self.cockpit.sndAPU)
	
	self.cockpit.sndAPUbegin = ED_AudioAPI.createSource(APUhostCpt, "Aircrafts/Engines/Motor/J8MotorBegin")
	ED_AudioAPI.linkSource(self.sndAPUbegin, self.cockpit.sndAPUbegin)

	self.cockpit.sndAPUEnd = ED_AudioAPI.createSource(APUhostCpt, "Aircrafts/ASU_End")
	ED_AudioAPI.linkSource(self.sndAPUEnd, self.cockpit.sndAPUEnd)
end

function J_8II_APU:update(params)
	self.rpm_sub = params.APU_RPM - self.rpm_sub
	if params.APU_RPM < 0.01 then
		ED_AudioAPI.stopSource(self.sndAPU)
		ED_AudioAPI.stopSource(self.sndAPUbegin)
		ED_AudioAPI.stopSource(self.sndAPUEnd)
	elseif params.APU_RPM > 0.02 then
		ED_AudioAPI.setSourcePitch(self.sndAPU, params.APU_RPM)
		ED_AudioAPI.setSourceGain(self.sndAPU, math.sqrt(params.APU_RPM))
		if not ED_AudioAPI.isSourcePlaying(self.sndAPU) then
			ED_AudioAPI.playSourceOnce(self.sndAPUbegin)
			ED_AudioAPI.playSourceLooped(self.sndAPU)
		end
	elseif self.rpm_sub < 0 and not ED_AudioAPI.isSourcePlaying(self.sndAPUEnd) then
		ED_AudioAPI.stopSource(self.sndAPU)
		ED_AudioAPI.stopSource(self.sndAPUbegin)
		ED_AudioAPI.playSourceOnce(self.sndAPUEnd)
	elseif self.rpm_sub > 0 and ED_AudioAPI.isSourcePlaying(self.sndAPUEnd) then
		ED_AudioAPI.stopSource(self.sndAPUEnd)
	end
end
