---@class love.sound
---This module is responsible for decoding sound files. It can't play the sounds, see love.audio for that.
local m = {}

--region Decoder
---@class Decoder : Object
---An object which can gradually decode a sound file.
local Decoder = {}
---Returns the number of bits per sample.
---@return number
function Decoder:getBitDepth() end

---Returns the number of channels in the stream.
---@return number
function Decoder:getChannels() end

---Gets the duration of the sound file. It may not always be sample-accurate, and it may return -1 if the duration cannot be determined at all.
---@return number
function Decoder:getDuration() end

---Returns the sample rate of the Decoder.
---@return number
function Decoder:getSampleRate() end

--endregion Decoder
--region SoundData
---@class SoundData : Data
---Contains raw audio samples. You can not play SoundData back directly. You must wrap a Source object around it.
local SoundData = {}
---Returns the number of bits per sample.
---@return number
function SoundData:getBitDepth() end

---Returns the number of channels in the stream.
---@return number
function SoundData:getChannels() end

---Gets the duration of the sound data.
---@return number
function SoundData:getDuration() end

---Gets the sample at the specified position.
---@param i number @An integer value specifying the position of the sample (0 points to the first sample).
---@return number
function SoundData:getSample(i) end

---Returns the number of samples per channel of the SoundData.
---@return number
function SoundData:getSampleCount() end

---Returns the sample rate of the SoundData.
---@return number
function SoundData:getSampleRate() end

---Sets the sample at the specified position.
---@param i number @The position of the sample (0 means first sample).
---@param sample number @A normalized sample (range -1.0 to 1.0).
function SoundData:setSample(i, sample) end

--endregion SoundData
---Attempts to find a decoder for the encoded sound data in the specified file.
---@param file File @The file with encoded sound data.
---@param buffer number @The size of each decoded chunk, in bytes.
---@return Decoder
---@overload fun(filename:string, buffer:number):Decoder
function m.newDecoder(file, buffer) end

---Creates new SoundData from a file. It's also possible to create SoundData with a custom sample rate, channel and bit depth.
---
---The sound data will be decoded to the memory in a raw format. It is recommended to create only short sounds like effects, as a 3 minute song uses 30 MB of memory this way.
---@param filename string @The filename of the file to load.
---@return SoundData
---@overload fun(file:File):SoundData
---@overload fun(data:Data):SoundData
---@overload fun(samples:number, rate:number, bits:number, channels:number):SoundData
function m.newSoundData(filename) end

return m