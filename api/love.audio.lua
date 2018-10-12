---@class love.audio
---Provides an interface to create noise with the user's speakers.
local m = {}

--region Source
---@class Source : Object
---A Source represents audio you can play back. You can do interesting things with Sources, like set the volume, pitch, and its position relative to the listener.
local Source = {}
---Creates an identical copy of the Source in the stopped state.
---
---Static Sources will use significantly less memory and take much less time to be created if Source:clone is used to create them instead of love.audio.newSource, so this method should be preferred when making multiple Sources which play the same sound.
---
---Cloned Sources inherit all the set-able state of the original Source, but they are initialized stopped.
---@return Source
function Source:clone() end

---Returns the reference and maximum distance of the source.
---@return number, number
function Source:getAttenuationDistances() end

---Gets the number of channels in the Source. Only 1-channel (mono) Sources can use directional and positional effects.
---@return number
function Source:getChannels() end

---Gets the Source's directional volume cones. Together with Source:setDirection, the cone angles allow for the Source's volume to vary depending on its direction.
---@return number, number, number
function Source:getCone() end

---Gets the direction of the Source.
---@return number, number, number
function Source:getDirection() end

---Gets the duration of the Source. For streaming Sources it may not always be sample-accurate, and may return -1 if the duration cannot be determined at all.
---@param unit TimeUnit @The time unit for the return value.
---@return number
function Source:getDuration(unit) end

---Gets the current pitch of the Source.
---@return number
function Source:getPitch() end

---Gets the position of the Source.
---@return number, number, number
function Source:getPosition() end

---Returns the rolloff factor of the source.
---@return number
function Source:getRolloff() end

---Gets the type (static or stream) of the Source.
---@return SourceType
function Source:getType() end

---Gets the velocity of the Source.
---@return number, number, number
function Source:getVelocity() end

---Gets the current volume of the Source.
---@return number
function Source:getVolume() end

---Returns the volume limits of the source.
---@return number, number
function Source:getVolumeLimits() end

---Returns whether the Source will loop.
---@return boolean
function Source:isLooping() end

---Returns whether the Source is paused.
---@return boolean
function Source:isPaused() end

---Returns whether the Source is playing.
---@return boolean
function Source:isPlaying() end

---Returns whether the Source is stopped.
---@return boolean
function Source:isStopped() end

---Pauses the Source.
function Source:pause() end

---Starts playing the Source.
---@return boolean
function Source:play() end

---Resumes a paused Source.
function Source:resume() end

---Rewinds a Source.
function Source:rewind() end

---Sets the playing position of the Source.
---@param position number @The position to seek to.
---@param unit TimeUnit @The unit of the position value.
function Source:seek(position, unit) end

---Sets the direction vector of the Source. A zero vector makes the source non-directional.
---@param x number @The X part of the direction vector.
---@param y number @The Y part of the direction vector.
---@param z number @The Z part of the direction vector.
function Source:setDirection(x, y, z) end

---Sets the reference and maximum distance of the source.
---@param ref number @The new reference distance.
---@param max number @The new maximum distance.
function Source:setAttenuationDistances(ref, max) end

---Sets the Source's directional volume cones. Together with Source:setDirection, the cone angles allow for the Source's volume to vary depending on its direction.
---@param innerAngle number @The inner angle from the Source's direction, in radians. The Source will play at normal volume if the listener is inside the cone defined by this angle.
---@param outerAngle number @The outer angle from the Source's direction, in radians. The Source will play at a volume between the normal and outer volumes, if the listener is in between the cones defined by the inner and outer angles.
---@param outerVolume number @The Source's volume when the listener is outside both the inner and outer cone angles.
function Source:setCone(innerAngle, outerAngle, outerVolume) end

---Sets whether the Source should loop.
---@param loop boolean @True if the source should loop, false otherwise.
function Source:setLooping(loop) end

---Sets the pitch of the Source.
---@param pitch number @Calculated with regard to 1 being the base pitch. Each reduction by 50 percent equals a pitch shift of -12 semitones (one octave reduction). Each doubling equals a pitch shift of 12 semitones (one octave increase). Zero is not a legal value.
function Source:setPitch(pitch) end

---Sets the position of the Source.
---@param x number @The X position of the Source.
---@param y number @The Y position of the Source.
---@param z number @The Z position of the Source.
function Source:setPosition(x, y, z) end

---Sets the rolloff factor which affects the strength of the used distance attenuation.
---
---Extended information and detailed formulas can be found in the chapter "3.4. Attenuation By Distance" of OpenAL 1.1 specification.
---@param rolloff number @The new rolloff factor.
function Source:setRolloff(rolloff) end

---Sets the velocity of the Source.
---
---This does not change the position of the Source, but is used to calculate the doppler effect.
---@param x number @The X part of the velocity vector.
---@param y number @The Y part of the velocity vector.
---@param z number @The Z part of the velocity vector.
function Source:setVelocity(x, y, z) end

---Sets the volume of the Source.
---@param volume number @The volume of the Source, where 1.0 is normal volume.
function Source:setVolume(volume) end

---Sets the volume limits of the source. The limits have to be numbers from 0 to 1.
---@param min number @The minimum volume.
---@param max number @The maximum volume.
function Source:setVolumeLimits(min, max) end

---Stops a Source.
function Source:stop() end

---Gets the currently playing position of the Source.
---@param unit TimeUnit @The type of unit for the return value.
---@return number
function Source:tell(unit) end

--endregion Source
---The different distance models.
---
---Extended information can be found in the chapter "3.4. Attenuation By Distance" of the OpenAL 1.1 specification.
DistanceModel = {
	---Sources do not get attenuated.
	['none'] = 1,
	---Inverse distance attenuation.
	['inverse'] = 2,
	---Inverse distance attenuation. Gain is clamped. In version 0.9.2 and older this is named inverse clamped.
	['inverseclamped'] = 3,
	---Linear attenuation.
	['linear'] = 4,
	---Linear attenuation. Gain is clamped. In version 0.9.2 and older this is named linear clamped.
	['linearclamped'] = 5,
	---Exponential attenuation.
	['exponent'] = 6,
	---Exponential attenuation. Gain is clamped. In version 0.9.2 and older this is named exponent clamped.
	['exponentclamped'] = 7,
}
---Types of audio sources.
---
---A good rule of thumb is to use stream for music files and static for all short sound effects. Basically, you want to avoid loading large files into memory at once.
SourceType = {
	---Decode the entire sound at once.
	['static'] = 1,
	---Stream the sound; decode it gradually.
	['stream'] = 2,
}
---Units that represent time.
TimeUnit = {
	---Regular seconds.
	['seconds'] = 1,
	---Audio samples.
	['samples'] = 2,
}
---Returns the distance attenuation model.
---@return DistanceModel
function m.getDistanceModel() end

---Gets the current global scale factor for velocity-based doppler effects.
---@return number
function m.getDopplerScale() end

---Returns the number of sources which are currently playing or paused.
---@return number
function m.getSourceCount() end

---Returns the orientation of the listener.
---@return number, number, number, number, number, number
function m.getOrientation() end

---Returns the position of the listener.
---@return number, number, number
function m.getPosition() end

---Returns the velocity of the listener.
---@return number, number, number
function m.getVelocity() end

---Returns the master volume.
---@return number
function m.getVolume() end

---Creates a new Source from a file or SoundData. Sources created from SoundData are always static.
---@param filename string @The filepath to create a Source from.
---@param type SourceType @Streaming or static source.
---@return Source
---@overload fun(file:File, type:SourceType):Source
---@overload fun(decoder:Decoder, type:SourceType):Source
---@overload fun(soundData:SoundData):Source
---@overload fun(fileData:FileData):Source
function m.newSource(filename, type) end

---Pauses currently played Sources.
---@overload fun(source:Source):void
function m.pause() end

---Plays the specified Source.
---@param source Source @The Source to play.
function m.play(source) end

---Resumes all audio
---@overload fun(source:Source):void
function m.resume() end

---Rewinds all playing audio.
---@overload fun(source:Source):void
function m.rewind() end

---Sets the distance attenuation model.
---@param model DistanceModel @The new distance model.
function m.setDistanceModel(model) end

---Sets a global scale factor for velocity-based doppler effects. The default scale value is 1.
---@param scale number @The new doppler scale factor. The scale must be greater than 0.
function m.setDopplerScale(scale) end

---Sets the orientation of the listener.
---@param fx number @The X component of the forward vector of the listener orientation.
---@param fy number @The Y component of the forward vector of the listener orientation.
---@param fz number @The Z component of the forward vector of the listener orientation.
---@param ux number @The X component of the up vector of the listener orientation.
---@param uy number @The Y component of the up vector of the listener orientation.
---@param uz number @The Z component of the up vector of the listener orientation.
function m.setOrientation(fx, fy, fz, ux, uy, uz) end

---Sets the position of the listener, which determines how sounds play.
---@param x number @The X position of the listener.
---@param y number @The Y position of the listener.
---@param z number @The Z position of the listener.
function m.setPosition(x, y, z) end

---Sets the velocity of the listener.
---@param x number @The X velocity of the listener.
---@param y number @The Y velocity of the listener.
---@param z number @The Z velocity of the listener.
function m.setVelocity(x, y, z) end

---Sets the master volume.
---@param volume number @1.0f is max and 0.0f is off.
function m.setVolume(volume) end

---Stops currently played sources.
---@overload fun(source:Source):void
function m.stop() end

return m