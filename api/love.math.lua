---@class love.math
---Provides system-independent mathematical functions.
local m = {}

--region BezierCurve
---@class BezierCurve : Object
---A Bézier curve object that can evaluate and render Bézier curves of arbitrary degree.
local BezierCurve = {}
---Evaluate Bézier curve at parameter t. The parameter must be between 0 and 1 (inclusive).
---
---This function can be used to move objects along paths or tween parameters. However it should not be used to render the curve, see BezierCurve:render for that purpose.
---@param t number @Where to evaluate the curve.
---@return number, number
function BezierCurve:evaluate(t) end

---Get coordinates of the i-th control point. Indices start with 1.
---@param i number @Index of the control point.
---@return number, number
function BezierCurve:getControlPoint(i) end

---Get the number of control points in the Bézier curve.
---@return number
function BezierCurve:getControlPointCount() end

---Get degree of the Bézier curve. The degree is equal to number-of-control-points - 1.
---@return number
function BezierCurve:getDegree() end

---Get the derivative of the Bézier curve.
---
---This function can be used to rotate sprites moving along a curve in the direction of the movement and compute the direction perpendicular to the curve at some parameter t.
---@return BezierCurve
function BezierCurve:getDerivative() end

---Gets a BezierCurve that corresponds to the specified segment of this BezierCurve.
---@param startpoint number @The starting point along the curve. Must be between 0 and 1.
---@param endpoint number @The end of the segment. Must be between 0 and 1.
---@return BezierCurve
function BezierCurve:getSegment(startpoint, endpoint) end

---Insert control point as the new i-th control point. Existing control points from i onwards are pushed back by 1. Indices start with 1. Negative indices wrap around: -1 is the last control point, -2 the one before the last, etc.
---@param x number @Position of the control point along the x axis.
---@param y number @Position of the control point along the y axis.
---@param i number @Index of the control point.
function BezierCurve:insertControlPoint(x, y, i) end

---Removes the specified control point.
---@param index number @The index of the control point to remove.
function BezierCurve:removeControlPoint(index) end

---Get a list of coordinates to be used with love.graphics.line.
---
---This function samples the Bézier curve using recursive subdivision. You can control the recursion depth using the depth parameter.
---
---If you are just interested to know the position on the curve given a parameter, use BezierCurve:evaluate.
---@param depth number @Number of recursive subdivision steps.
---@return table
function BezierCurve:render(depth) end

---Get a list of coordinates on a specific part of the curve, to be used with love.graphics.line.
---
---This function samples the Bézier curve using recursive subdivision. You can control the recursion depth using the depth parameter.
---
---If you are just need to know the position on the curve given a parameter, use BezierCurve:evaluate.
---@param startpoint number @The starting point along the curve. Must be between 0 and 1.
---@param endpoint number @The end of the segment to render. Must be between 0 and 1.
---@param depth number @Number of recursive subdivision steps.
---@return table
function BezierCurve:renderSegment(startpoint, endpoint, depth) end

---Rotate the Bézier curve by an angle.
---@param angle number @Rotation angle in radians.
---@param ox number @X coordinate of the rotation center.
---@param oy number @Y coordinate of the rotation center.
function BezierCurve:rotate(angle, ox, oy) end

---Scale the Bézier curve by a factor.
---@param s number @Scale factor.
---@param ox number @X coordinate of the scaling center.
---@param oy number @Y coordinate of the scaling center.
function BezierCurve:scale(s, ox, oy) end

---Set coordinates of the i-th control point. Indices start with 1.
---@param i number @Index of the control point.
---@param ox number @Position of the control point along the x axis.
---@param oy number @Position of the control point along the y axis.
function BezierCurve:setControlPoint(i, ox, oy) end

---Move the Bézier curve by an offset.
---@param dx number @Offset along the x axis.
---@param dy number @Offset along the y axis.
function BezierCurve:translate(dx, dy) end

--endregion BezierCurve
--region CompressedData
---@class CompressedData : Data
---Represents byte data compressed using a specific algorithm.
---
---love.math.decompress can be used to de-compress the data.
local CompressedData = {}
---Gets the compression format of the CompressedData.
---@return CompressedDataFormat
function CompressedData:getFormat() end

--endregion CompressedData
--region RandomGenerator
---@class RandomGenerator : Object
---A random number generation object which has its own random state.
local RandomGenerator = {}
---Gets the state of the random number generator.
---
---The state is split into two numbers due to Lua's use of doubles for all number values - doubles can't accurately represent integer values above 2^53.
---@return number, number
function RandomGenerator:getSeed() end

---Gets the current state of the random number generator. This returns an opaque implementation-dependent string which is only useful for later use with RandomGenerator:setState.
---
---This is different from RandomGenerator:getSeed in that getState gets the RandomGenerator's current state, whereas getSeed gets the previously set seed number.
---
---The value of the state string does not depend on the current operating system.
---@return string
function RandomGenerator:getState() end

---Generates a pseudo-random number in a platform independent manner.
---@return number
---@overload fun(max:number):number
---@overload fun(min:number, max:number):number
function RandomGenerator:random() end

---Get a normally distributed pseudo random number.
---@param stddev number @Standard deviation of the distribution.
---@param mean number @The mean of the distribution.
---@return number
function RandomGenerator:randomNormal(stddev, mean) end

---Sets the seed of the random number generator using the specified integer number.
---@param seed number @The integer number with which you want to seed the randomization. Must be within the range of [1, 2^53].
---@overload fun(low:number, high:number):void
function RandomGenerator:setSeed(seed) end

---Sets the current state of the random number generator. The value used as an argument for this function is an opaque implementation-dependent string and should only originate from a previous call to RandomGenerator:getState.
---
---This is different from RandomGenerator:setSeed in that setState directly sets the RandomGenerator's current implementation-dependent state, whereas setSeed gives it a new seed value.
---
---The effect of the state string does not depend on the current operating system.
---@param state string @The new state of the RandomGenerator object, represented as a string. This should originate from a previous call to RandomGenerator:getState.
function RandomGenerator:setState(state) end

--endregion RandomGenerator
---Compressed data formats.
CompressedDataFormat = {
	---The LZ4 compression format. Compresses and decompresses very quickly, but the compression ratio is not the best. LZ4-HC is used when compression level 9 is specified.
	['lz4'] = 1,
	---The zlib format is DEFLATE-compressed data with a small bit of header data. Compresses relatively slowly and decompresses moderately quickly, and has a decent compression ratio.
	['zlib'] = 2,
	---The gzip format is DEFLATE-compressed data with a slightly larger header than zlib. Since it uses DEFLATE it has the same compression characteristics as the zlib format.
	['gzip'] = 3,
}
---Compresses a string or data using a specific compression algorithm.
---@param rawstring string @The raw (un-compressed) string to compress.
---@param format CompressedDataFormat @The format to use when compressing the string.
---@param level number @The level of compression to use, between 0 and 9. -1 indicates the default level. The meaning of this argument depends on the compression format being used.
---@return CompressedData
---@overload fun(data:Data, format:CompressedDataFormat, level:number):CompressedData
function m.compress(rawstring, format, level) end

---Decompresses a CompressedData or previously compressed string or Data object.
---@param compressedData CompressedData @The compressed data to decompress.
---@return string
---@overload fun(compressedString:string, format:CompressedDataFormat):string
---@overload fun(data:Data, format:CompressedDataFormat):string
function m.decompress(compressedData) end

---Converts a color from gamma-space (sRGB) to linear-space (RGB). This is useful when doing gamma-correct rendering and you need to do math in linear RGB in the few cases where LÖVE doesn't handle conversions automatically.
---@param r number @The red channel of the sRGB color to convert.
---@param g number @The green channel of the sRGB color to convert.
---@param b number @The blue channel of the sRGB color to convert.
---@return number, number, number
---@overload fun(color:table):number, number, number
---@overload fun(c:number):number
function m.gammaToLinear(r, g, b) end

---Gets the seed of the random number generator.
---
---The state is split into two numbers due to Lua's use of doubles for all number values - doubles can't accurately represent integer values above 2^53.
---@return number, number
function m.getRandomSeed() end

---Gets the current state of the random number generator. This returns an opaque implementation-dependent string which is only useful for later use with RandomGenerator:setState.
---
---This is different from RandomGenerator:getSeed in that getState gets the RandomGenerator's current state, whereas getSeed gets the previously set seed number.
---
---The value of the state string does not depend on the current operating system.
---@return string
function m.getRandomState() end

---Checks whether a polygon is convex.
---
---PolygonShapes in love.physics, some forms of Mesh, and polygons drawn with love.graphics.polygon must be simple convex polygons.
---@param vertices table @The vertices of the polygon as a table in the form of {x1, y1, x2, y2, x3, y3, ...}.
---@return boolean
---@overload fun(x1:number, y1:number, x2:number, y2:number, x3:number, y3:number, ...:number):boolean
function m.isConvex(vertices) end

---Converts a color from linear-space (RGB) to gamma-space (sRGB). This is useful when storing linear RGB color values in an image, because the linear RGB color space has less precision than sRGB for dark colors, which can result in noticeable color banding when drawing.
---
---In general, colors chosen based on what they look like on-screen are already in gamma-space and should not be double-converted. Colors calculated using math are often in the linear RGB space.
---@param lr number @The red channel of the linear RGB color to convert.
---@param lg number @The green channel of the linear RGB color to convert.
---@param lb number @The blue channel of the linear RGB color to convert.
---@return number, number, number
---@overload fun(color:table):number, number, number
---@overload fun(lc:number):number
function m.linearToGamma(lr, lg, lb) end

---Creates a new BezierCurve object.
---
---The number of vertices in the control polygon determines the degree of the curve, e.g. three vertices define a quadratic (degree 2) Bézier curve, four vertices define a cubic (degree 3) Bézier curve, etc.
---@param vertices table @The vertices of the control polygon as a table in the form of {x1, y1, x2, y2, x3, y3, ...}.
---@return BezierCurve
---@overload fun(x1:number, y1:number, x2:number, y2:number, x3:number, y3:number, ...:number):BezierCurve
function m.newBezierCurve(vertices) end

---Creates a new RandomGenerator object which is completely independent of other RandomGenerator objects and random functions.
---@return RandomGenerator
---@overload fun(seed:number):RandomGenerator
---@overload fun(low:number, high:number):RandomGenerator
function m.newRandomGenerator() end

---Generates a Simplex or Perlin noise value in 1-4 dimensions. The return value will always be the same, given the same arguments.
---
---Simplex noise is closely related to Perlin noise. It is widely used for procedural content generation.
---
---There are many webpages which discuss Perlin and Simplex noise in detail.
---@param x number @The number used to generate the noise value.
---@return number
---@overload fun(x:number, y:number):number
---@overload fun(x:number, y:number, z:number):number
---@overload fun(x:number, y:number, z:number, w:number):number
function m.noise(x) end

---Generates a pseudo-random number in a platform independent manner.
---@return number
---@overload fun(max:number):number
---@overload fun(min:number, max:number):number
function m.random() end

---Get a normally distributed pseudo random number.
---@param stddev number @Standard deviation of the distribution.
---@param mean number @The mean of the distribution.
---@return number
function m.randomNormal(stddev, mean) end

---Sets the seed of the random number generator using the specified integer number.
---@param seed number @The integer number with which you want to seed the randomization. Must be within the range of [1, 2^53].
---@overload fun(low:number, high:number):void
function m.setRandomSeed(seed) end

---Gets the current state of the random number generator. This returns an opaque implementation-dependent string which is only useful for later use with RandomGenerator:setState.
---
---This is different from RandomGenerator:getSeed in that getState gets the RandomGenerator's current state, whereas getSeed gets the previously set seed number.
---
---The value of the state string does not depend on the current operating system.
---@param state string @The current state of the RandomGenerator object, represented as a string.
function m.setRandomState(state) end

---Triangulate a simple polygon.
---@param polygon table @Polygon to triangulate. Must not intersect itself.
---@return table
---@overload fun(x1:number, y1:number, x2:number, y2:number, x3:number, y3:number, ...:number):table
function m.triangulate(polygon) end

return m