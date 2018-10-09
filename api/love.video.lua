---@class love.video
---This module is responsible for decoding, controlling, and streaming video files.
---
---It can't draw the videos, see love.graphics.newVideo and Video objects for that.
local m = {}

--region VideoStream
---@class VideoStream : Object
---An object which decodes, streams, and controls Videos.
local VideoStream = {}
--endregion VideoStream
---Creates a new VideoStream. Currently only Ogg Theora video files are supported. VideoStreams can't draw videos, see love.graphics.newVideo for that.
---@param filename string @The file path to the Ogg Theora video file.
---@return VideoStream
---@overload fun(file:File):VideoStream
function m.newVideoStream(filename) end

return m