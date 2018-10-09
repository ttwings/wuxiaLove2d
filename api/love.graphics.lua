---@class love.graphics
---The primary responsibility for the love.graphics module is the drawing of lines, shapes, text, Images and other Drawable objects onto the screen. Its secondary responsibilities include loading external files (including Images and Fonts) into memory, creating specialized objects (such as ParticleSystems or Canvases) and managing screen geometry.
---
---LÖVE's coordinate system is rooted in the upper-left corner of the screen, which is at location (0, 0). The x axis is horizontal: larger values are further to the right. The y axis is vertical: larger values are further towards the bottom.
---
---In many cases, you draw images or shapes in terms of their upper-left corner.
---
---Many of the functions are used to manipulate the graphics coordinate system, which is essentially the way coordinates are mapped to the display. You can change the position, scale, and even rotation in this way.
local m = {}

--region Canvas
---@class Canvas : Texture
---A Canvas is used for off-screen rendering. Think of it as an invisible screen that you can draw to, but that will not be visible until you draw it to the actual visible screen. It is also known as "render to texture".
---
---By drawing things that do not change position often (such as background items) to the Canvas, and then drawing the entire Canvas instead of each item, you can reduce the number of draw operations performed each frame.
---
---In versions prior to 0.10.0, not all graphics cards that LÖVE supported could use Canvases. love.graphics.isSupported("canvas") could be used to check for support at runtime.
local Canvas = {}
---Gets the width and height of the Canvas.
---@return number, number
function Canvas:getDimensions() end

---Gets the filter mode of the Canvas.
---@return FilterMode, FilterMode, number
function Canvas:getFilter() end

---Gets the texture format of the Canvas.
---@return CanvasFormat
function Canvas:getFormat() end

---Gets the height of the Canvas.
---@return number
function Canvas:getHeight() end

---Gets the number of multisample antialiasing (MSAA) samples used when drawing to the Canvas.
---
---This may be different than the number used as an argument to love.graphics.newCanvas if the system running LÖVE doesn't support that number.
---@return number
function Canvas:getMSAA() end

---Gets the width of the Canvas.
---@return number
function Canvas:getWidth() end

---Gets the wrapping properties of a Canvas.
---
---This function returns the currently set horizontal and vertical wrapping modes for the Canvas.
---@return WrapMode, WrapMode
function Canvas:getWrap() end

---Generates ImageData from the contents of the Canvas.
---@return ImageData
---@overload fun(x:number, y:number, width:number, height:number):ImageData
function Canvas:newImageData() end

---Render to the Canvas using a function.
---@param func function @A function performing drawing operations.
function Canvas:renderTo(func) end

---Sets the filter of the Canvas.
---@param min FilterMode @How to scale a canvas down.
---@param mag FilterMode @How to scale a canvas up.
---@param anisotropy number @Maximum amount of anisotropic filtering used.
function Canvas:setFilter(min, mag, anisotropy) end

---Sets the wrapping properties of a Canvas.
---
---This function sets the way the edges of a Canvas are treated if it is scaled or rotated. If the WrapMode is set to "clamp", the edge will not be interpolated. If set to "repeat", the edge will be interpolated with the pixels on the opposing side of the framebuffer.
---@param horizontal WrapMode @Horizontal wrapping mode of the Canvas.
---@param vertical WrapMode @Vertical wrapping mode of the Canvas.
function Canvas:setWrap(horizontal, vertical) end

--endregion Canvas
--region Font
---@class Font : Object
---Defines the shape of characters than can be drawn onto the screen.
local Font = {}
---Gets the ascent of the Font. The ascent spans the distance between the baseline and the top of the glyph that reaches farthest from the baseline.
---@return number
function Font:getAscent() end

---Gets the baseline of the Font. Most scripts share the notion of a baseline: an imaginary horizontal line on which characters rest. In some scripts, parts of glyphs lie below the baseline.
---@return number
function Font:getBaseline() end

---Gets the descent of the Font. The descent spans the distance between the baseline and the lowest descending glyph in a typeface.
---@return number
function Font:getDescent() end

---Gets the filter mode for a font.
---@return FilterMode, FilterMode, number
function Font:getFilter() end

---Gets the height of the Font. The height of the font is the size including any spacing; the height which it will need.
---@return number
function Font:getHeight() end

---Gets the line height. This will be the value previously set by Font:setLineHeight, or 1.0 by default.
---@return number
function Font:getLineHeight() end

---Determines the horizontal size a line of text needs. Does not support line-breaks.
---@param line string @A line of text.
---@return number
function Font:getWidth(line) end

---Gets formatting information for text, given a wrap limit.
---
---This function accounts for newlines correctly (i.e. '\n').
---@param text string @The text that will be wrapped.
---@param wraplimit number @The maximum width in pixels of each line that text is allowed before wrapping.
---@return number, table
function Font:getWrap(text, wraplimit) end

---Gets whether the font can render a particular character.
---@param character string @A unicode character.
---@return boolean
---@overload fun(codepoint:number):boolean
function Font:hasGlyphs(character) end

---Sets the fallback fonts. When the Font doesn't contain a glyph, it will substitute the glyph from the next subsequent fallback Fonts. This is akin to setting a "font stack" in Cascading Style Sheets (CSS).
---@param fallbackfont1 Font @The first fallback Font to use.
---@param ... Font @Additional fallback Fonts.
function Font:setFallbacks(fallbackfont1, ...) end

---Sets the filter mode for a font.
---@param min FilterMode @How to scale a font down.
---@param mag FilterMode @How to scale a font up.
---@param anisotropy number @Maximum amount of anisotropic filtering used.
function Font:setFilter(min, mag, anisotropy) end

---Sets the line height. When rendering the font in lines the actual height will be determined by the line height multiplied by the height of the font. The default is 1.0.
---@param height number @The new line height.
function Font:setLineHeight(height) end

--endregion Font
--region Mesh
---@class Mesh : Drawable
---A 2D polygon mesh used for drawing arbitrary textured shapes.
local Mesh = {}
---Attaches a vertex attribute from a different Mesh onto this Mesh, for use when drawing. This can be used to share vertex attribute data between several different Meshes.
---@param name string @The name of the vertex attribute to attach.
---@param mesh Mesh @The Mesh to get the vertex attribute from.
function Mesh:attachAttribute(name, mesh) end

---Gets the mode used when drawing the Mesh.
---@return MeshDrawMode
function Mesh:getDrawMode() end

---Gets the range of vertices used when drawing the Mesh.
---
---If the Mesh's draw range has not been set previously with Mesh:setDrawRange, this function will return nil.
---@return number, number
function Mesh:getDrawRange() end

---Gets the texture (Image or Canvas) used when drawing the Mesh.
---@return Texture
function Mesh:getTexture() end

---Gets the properties of a vertex in the Mesh.
---@param index number @The index of the the vertex you want to retrieve the information for.
---@return number, number
---@overload fun(index:number):number, number, number, number, number, number, number, number
function Mesh:getVertex(index) end

---Gets the properties of a specific attribute within a vertex in the Mesh.
---
---Meshes without a custom vertex format specified in love.graphics.newMesh have position as their first attribute, texture coordinates as their second attribute, and color as their third attribute.
---@param vertexindex number @The index of the the vertex to be modified.
---@param attributeindex number @The index of the attribute within the vertex to be modified.
---@return number, number, number
function Mesh:getVertexAttribute(vertexindex, attributeindex) end

---Returns the total number of vertices in the Mesh.
---@return number
function Mesh:getVertexCount() end

---Gets the vertex format that the Mesh was created with.
---@return table
function Mesh:getVertexFormat() end

---Gets the vertex map for the Mesh. The vertex map describes the order in which the vertices are used when the Mesh is drawn. The vertices, vertex map, and mesh draw mode work together to determine what exactly is displayed on the screen.
---
---If no vertex map has been set previously via Mesh:setVertexMap, then this function will return nil in LÖVE 0.10.0+, or an empty table in 0.9.2 and older.
---@return table
function Mesh:getVertexMap() end

---Gets whether a specific vertex attribute in the Mesh is enabled. Vertex data from disabled attributes is not used when drawing the Mesh.
---@param name string @The name of the vertex attribute to enable or disable.
---@return boolean
function Mesh:isAttributeEnabled(name) end

---Enables or disables a specific vertex attribute in the Mesh. Vertex data from disabled attributes is not used when drawing the Mesh.
---@param name string @The name of the vertex attribute to enable or disable.
---@param enable boolean @Whether the vertex attribute is used when drawing this Mesh.
function Mesh:setAttributeEnabled(name, enable) end

---Sets the mode used when drawing the Mesh.
---@param mode MeshDrawMode @The mode to use when drawing the Mesh.
function Mesh:setDrawMode(mode) end

---Restricts the drawn vertices of the Mesh to a subset of the total.
---
---If a vertex map is used with the Mesh, this method will set a subset of the values in the vertex map array to use, instead of a subset of the total vertices in the Mesh.
---
---For example, if Mesh:setVertexMap(1, 2, 3, 1, 3, 4) and Mesh:setDrawRange(4, 6) are called, vertices 1, 3, and 4 will be drawn.
---@param min number @The index of the first vertex to use when drawing, or the index of the first value in the vertex map to use if one is set for this Mesh.
---@param max number @The index of the last vertex to use when drawing, or the index of the last value in the vertex map to use if one is set for this Mesh.
function Mesh:setDrawRange(min, max) end

---Sets the texture (Image or Canvas) used when drawing the Mesh.
---
---When called without an argument disables the texture. Untextured meshes have a white color by default.
---@overload fun(texture:Texture):void
function Mesh:setTexture() end

---Sets the properties of a vertex in the Mesh.
---@param index number @The index of the the vertex you want to modify.
---@param attributecomponent number @The first component of the first vertex attribute in the specified vertex.
---@param ... number @Additional components of all vertex attributes in the specified vertex.
---@overload fun(index:number, vertex:table):void
---@overload fun(index:number, x:number, y:number, u:number, v:number, r:number, g:number, b:number, a:number):void
---@overload fun(index:number, vertex:table):void
function Mesh:setVertex(index, attributecomponent, ...) end

---Sets the properties of a specific attribute within a vertex in the Mesh.
---
---Meshes without a custom vertex format specified in love.graphics.newMesh have position as their first attribute, texture coordinates as their second attribute, and color as their third attribute.
---@param vertexindex number @The index of the the vertex to be modified.
---@param attributeindex number @The index of the attribute within the vertex to be modified.
---@param value1 number @The value of the first component of the attribute.
---@param value2 number @The value of the second component of the attribute.
---@param ... number @Any additional vertex attribute components.
function Mesh:setVertexAttribute(vertexindex, attributeindex, value1, value2, ...) end

---Sets the vertex map for the Mesh. The vertex map describes the order in which the vertices are used when the Mesh is drawn. The vertices, vertex map, and mesh draw mode work together to determine what exactly is displayed on the screen.
---
---The vertex map allows you to re-order or reuse vertices when drawing without changing the actual vertex parameters or duplicating vertices. It is especially useful when combined with different Mesh Draw Modes.
---@param map table @A table containing a list of vertex indices to use when drawing. Values must be in the range of [1, Mesh:getVertexCount()].
---@overload fun(vi1:number, vi2:number, vi3:number):void
function Mesh:setVertexMap(map) end

---Replaces a range of vertices in the Mesh with new ones. The total number of vertices in a Mesh cannot be changed after it has been created.
---@param vertices table @The table filled with vertex information tables for each vertex, in the form of {vertex, ...} where each vertex is a table in the form of {attributecomponent, ...}.
---@overload fun(vertices:table):void
function Mesh:setVertices(vertices) end

--endregion Mesh
--region Image
---@class Image : Texture
---Drawable image type.
local Image = {}
---Gets the original ImageData or CompressedImageData used to create the Image.
---
---All Images keep a reference to the Data that was used to create the Image. The Data is used to refresh the Image when love.window.setMode or Image:refresh is called.
---@return ImageData
function Image:getData() end

---Gets the width and height of the Image.
---@return number, number
function Image:getDimensions() end

---Gets the filter mode for an image.
---@return FilterMode, FilterMode
function Image:getFilter() end

---Gets the flags used when the image was created.
---@return table
function Image:getFlags() end

---Gets the height of the Image.
---@return number
function Image:getHeight() end

---Gets the mipmap filter mode for an Image.
---@return FilterMode, number
function Image:getMipmapFilter() end

---Gets the width of the Image.
---@return number
function Image:getWidth() end

---Gets the wrapping properties of an Image.
---
---This function returns the currently set horizontal and vertical wrapping modes for the image.
---@return WrapMode, WrapMode
function Image:getWrap() end

---Reloads the Image's contents from the ImageData or CompressedImageData used to create the image.
---@overload fun(x:number, y:number, width:number, height:number):void
function Image:refresh() end

---Sets the filter mode for an image.
---@param min FilterMode @How to scale an image down.
---@param mag FilterMode @How to scale an image up.
function Image:setFilter(min, mag) end

---Sets the mipmap filter mode for an Image.
---
---Mipmapping is useful when drawing an image at a reduced scale. It can improve performance and reduce aliasing issues.
---
---In 0.10.0 and newer, the Image must be created with the mipmaps flag enabled for the mipmap filter to have any effect.
---@param filtermode FilterMode @The filter mode to use in between mipmap levels. "nearest" will often give better performance.
---@param sharpness number @A positive sharpness value makes the image use a more detailed mipmap level when drawing, at the expense of performance. A negative value does the reverse.
function Image:setMipmapFilter(filtermode, sharpness) end

---Sets the wrapping properties of an Image.
---
---This function sets the way an Image is repeated when it is drawn with a Quad that is larger than the image's extent. An image may be clamped or set to repeat in both horizontal and vertical directions. Clamped images appear only once, but repeated ones repeat as many times as there is room in the Quad.
---
---If you use a Quad that is larger than the image extent and do not use repeated tiling, there may be an unwanted visual effect of the image stretching all the way to fill the Quad. If this is the case, setting Image:getWrap("repeat", "repeat") for all the images to be repeated, and using Quad of appropriate size will result in the best visual appearance.
---@param horizontal WrapMode @Horizontal wrapping mode of the image.
---@param vertical WrapMode @Vertical wrapping mode of the image.
function Image:setWrap(horizontal, vertical) end

--endregion Image
--region ParticleSystem
---@class ParticleSystem : Drawable
---Used to create cool effects, like fire. The particle systems are created and drawn on the screen using functions in love.graphics. They also need to be updated in the update(dt) callback for you to see any changes in the particles emitted.
local ParticleSystem = {}
---Creates an identical copy of the ParticleSystem in the stopped state.
---
---Cloned ParticleSystem inherit all the set-able state of the original ParticleSystem, but they are initialized stopped.
---@return ParticleSystem
function ParticleSystem:clone() end

---Emits a burst of particles from the particle emitter.
---@param numparticles number @The amount of particles to emit. The number of emitted particles will be truncated if the particle system's max buffer size is reached.
function ParticleSystem:emit(numparticles) end

---Gets the amount of particles that are currently in the system.
---@return number
function ParticleSystem:getCount() end

---Gets the area-based spawn parameters for the particles.
---@return AreaSpreadDistribution, number, number
function ParticleSystem:getAreaSpread() end

---Gets the size of the buffer (the max allowed amount of particles in the system).
---@return number
function ParticleSystem:getBufferSize() end

---Gets a series of colors to apply to the particle sprite. The particle system will interpolate between each color evenly over the particle's lifetime. Color modulation needs to be activated for this function to have any effect.
---
---Arguments are passed in groups of four, representing the components of the desired RGBA value. At least one color must be specified. A maximum of eight may be used.
---@return number, number, number, number, number, number, number, number, number
function ParticleSystem:getColors() end

---Gets the direction the particles will be emitted in.
---@return number
function ParticleSystem:getDirection() end

---Gets the amount of particles emitted per second.
---@return number
function ParticleSystem:getEmissionRate() end

---Gets the mode to use when the ParticleSystem adds new particles.
---@return ParticleInsertMode
function ParticleSystem:getInsertMode() end

---Gets the linear acceleration (acceleration along the x and y axes) for particles.
---
---Every particle created will accelerate along the x and y axes between xmin,ymin and xmax,ymax.
---@return number, number, number, number
function ParticleSystem:getLinearAcceleration() end

---Gets the amount of linear damping (constant deceleration) for particles.
---@return number, number
function ParticleSystem:getLinearDamping() end

---Gets how long the particle system should emit particles (if -1 then it emits particles forever).
---@return number
function ParticleSystem:getEmitterLifetime() end

---Get the offget position which the particle sprite is rotated around. If this function is not used, the particles rotate around their center.
---@return number, number
function ParticleSystem:getOffset() end

---Gets the life of the particles.
---@return number, number
function ParticleSystem:getParticleLifetime() end

---Gets the series of Quads used for the particle sprites.
---@return table
function ParticleSystem:getQuads() end

---Gets the position of the emitter.
---@return number, number
function ParticleSystem:getPosition() end

---Get the radial acceleration (away from the emitter).
---@return number, number
function ParticleSystem:getRadialAcceleration() end

---Gets the rotation of the image upon particle creation (in radians).
---@return number, number
function ParticleSystem:getRotation() end

---Gets a series of sizes by which to scale a particle sprite. 1.0 is normal size. The particle system will interpolate between each size evenly over the particle's lifetime.
---
---At least one size must be specified. A maximum of eight may be used.
---@return number, number, number
function ParticleSystem:getSizes() end

---Gets the degree of variation (0 meaning no variation and 1 meaning full variation between start and end).
---@return number
function ParticleSystem:getSizeVariation() end

---Gets the speed of the particles.
---@return number, number
function ParticleSystem:getSpeed() end

---Gets the spin of the sprite.
---@return number, number
function ParticleSystem:getSpin() end

---Gets the degree of variation (0 meaning no variation and 1 meaning full variation between start and end).
---@return number
function ParticleSystem:getSpinVariation() end

---Gets the amount of spread for the system.
---@return number
function ParticleSystem:getSpread() end

---Gets the Image or Canvas which is to be emitted.
---@return Texture
function ParticleSystem:getTexture() end

---Gets the tangential acceleration (acceleration perpendicular to the particle's direction).
---@return number, number
function ParticleSystem:getTangentialAcceleration() end

---Gets whether particle angles and rotations are relative to their velocities. If enabled, particles are aligned to the angle of their velocities and rotate relative to that angle.
---@return boolean
function ParticleSystem:hasRelativeRotation() end

---Checks whether the particle system is actively emitting particles.
---@return boolean
function ParticleSystem:isActive() end

---Checks whether the particle system is paused.
---@return boolean
function ParticleSystem:isPaused() end

---Checks whether the particle system is stopped.
---@return boolean
function ParticleSystem:isStopped() end

---Moves the position of the emitter. This results in smoother particle spawning behaviour than if ParticleSystem:setPosition is used every frame.
---@param x number @Position along x-axis.
---@param y number @Position along y-axis.
function ParticleSystem:moveTo(x, y) end

---Pauses the particle emitter.
function ParticleSystem:pause() end

---Resets the particle emitter, removing any existing particles and resetting the lifetime counter.
function ParticleSystem:reset() end

---Sets area-based spawn parameters for the particles. Newly created particles will spawn in an area around the emitter based on the parameters to this function.
---@param distribution AreaSpreadDistribution @The type of distribution for new particles.
---@param dx number @The maximum spawn distance from the emitter along the x-axis for uniform distribution, or the standard deviation along the x-axis for normal distribution.
---@param dy number @The maximum spawn distance from the emitter along the y-axis for uniform distribution, or the standard deviation along the y-axis for normal distribution.
function ParticleSystem:setAreaSpread(distribution, dx, dy) end

---Sets the size of the buffer (the max allowed amount of particles in the system).
---@param buffer number @The buffer size.
function ParticleSystem:setBufferSize(buffer) end

---Sets a series of colors to apply to the particle sprite. The particle system will interpolate between each color evenly over the particle's lifetime. Color modulation needs to be activated for this function to have any effect.
---
---Arguments are passed in groups of four, representing the components of the desired RGBA value. At least one color must be specified. A maximum of eight may be used.
---@param r1 number @First color, red component (0-255).
---@param g1 number @First color, green component (0-255).
---@param b1 number @First color, blue component (0-255).
---@param a1 number @First color, alpha component (0-255).
---@param r2 number @Second color, red component (0-255).
---@param g2 number @Second color, green component (0-255).
---@param b2 number @Second color, blue component (0-255).
---@param a2 number @Second color, alpha component (0-255).
---@param ... number @Etc.
function ParticleSystem:setColors(r1, g1, b1, a1, r2, g2, b2, a2, ...) end

---Sets the direction the particles will be emitted in.
---@param direction number @The direction of the particles (in radians).
function ParticleSystem:setDirection(direction) end

---Sets the amount of particles emitted per second.
---@param rate number @The amount of particles per second.
function ParticleSystem:setEmissionRate(rate) end

---Sets how long the particle system should emit particles (if -1 then it emits particles forever).
---@param life number @The lifetime of the emitter (in seconds).
function ParticleSystem:setEmitterLifetime(life) end

---Sets the mode to use when the ParticleSystem adds new particles.
---@param mode ParticleInsertMode @The mode to use when the ParticleSystem adds new particles.
function ParticleSystem:setInsertMode(mode) end

---Sets the linear acceleration (acceleration along the x and y axes) for particles.
---
---Every particle created will accelerate along the x and y axes between xmin,ymin and xmax,ymax.
---@param xmin number @The minimum acceleration along the x axis.
---@param ymin number @The minimum acceleration along the y axis.
---@param xmax number @The maximum acceleration along the x axis.
---@param ymax number @The maximum acceleration along the y axis.
function ParticleSystem:setLinearAcceleration(xmin, ymin, xmax, ymax) end

---Sets the amount of linear damping (constant deceleration) for particles.
---@param min number @The minimum amount of linear damping applied to particles.
---@param max number @The maximum amount of linear damping applied to particles.
function ParticleSystem:setLinearDamping(min, max) end

---Set the offset position which the particle sprite is rotated around. If this function is not used, the particles rotate around their center.
---@param x number @The x coordinate of the rotation offset.
---@param y number @The y coordinate of the rotation offset.
function ParticleSystem:setOffset(x, y) end

---Sets the life of the particles.
---@param min number @The minimum life of the particles (seconds).
---@param max number @The maximum life of the particles (seconds).
function ParticleSystem:setParticleLifetime(min, max) end

---Sets the position of the emitter.
---@param x number @Position along x-axis.
---@param y number @Position along y-axis.
function ParticleSystem:setPosition(x, y) end

---Sets a series of Quads to use for the particle sprites. Particles will choose a Quad from the list based on the particle's current lifetime, allowing for the use of animated sprite sheets with ParticleSystems.
---@param quad1 Quad @The first Quad to use.
---@param quad2 Quad @The second Quad to use.
---@overload fun(quads:table):void
function ParticleSystem:setQuads(quad1, quad2) end

---Set the radial acceleration (away from the emitter).
---@param min number @The minimum acceleration.
---@param max number @The maximum acceleration.
function ParticleSystem:setRadialAcceleration(min, max) end

---Sets whether particle angles and rotations are relative to their velocities. If enabled, particles are aligned to the angle of their velocities and rotate relative to that angle.
---@param enable boolean @True to enable relative particle rotation, false to disable it.
function ParticleSystem:setRelativeRotation(enable) end

---Sets the rotation of the image upon particle creation (in radians).
---@param min number @The minimum initial angle (radians).
---@param max number @The maximum initial angle (radians).
function ParticleSystem:setRotation(min, max) end

---Sets a series of sizes by which to scale a particle sprite. 1.0 is normal size. The particle system will interpolate between each size evenly over the particle's lifetime.
---
---At least one size must be specified. A maximum of eight may be used.
---@param size1 number @The first size.
---@param size2 number @The second size.
---@param ... number @Etc.
function ParticleSystem:setSizes(size1, size2, ...) end

---Sets the degree of variation (0 meaning no variation and 1 meaning full variation between start and end).
---@param variation number @The degree of variation (0 meaning no variation and 1 meaning full variation between start and end).
function ParticleSystem:setSizeVariation(variation) end

---Sets the speed of the particles.
---@param min number @The minimum linear speed of the particles.
---@param max number @The maximum linear speed of the particles.
function ParticleSystem:setSpeed(min, max) end

---Sets the spin of the sprite.
---@param min number @The minimum spin (radians per second).
---@param max number @The maximum spin (radians per second).
function ParticleSystem:setSpin(min, max) end

---Sets the degree of variation (0 meaning no variation and 1 meaning full variation between start and end).
---@param variation number @The degree of variation (0 meaning no variation and 1 meaning full variation between start and end).
function ParticleSystem:setSpinVariation(variation) end

---Sets the amount of spread for the system.
---@param spread number @The amount of spread (radians).
function ParticleSystem:setSpread(spread) end

---Sets the Image or Canvas which is to be emitted.
---@param texture Texture @An Image or Canvas to use for the particle.
function ParticleSystem:setTexture(texture) end

---Sets the tangential acceleration (acceleration perpendicular to the particle's direction).
---@param min number @The minimum acceleration.
---@param max number @The maximum acceleration.
function ParticleSystem:setTangentialAcceleration(min, max) end

---Starts the particle emitter.
function ParticleSystem:start() end

---Stops the particle emitter, resetting the lifetime counter.
function ParticleSystem:stop() end

---Updates the particle system; moving, creating and killing particles.
---@param dt number @The time (seconds) since last frame.
function ParticleSystem:update(dt) end

--endregion ParticleSystem
--region Quad
---@class Quad : Object
---A quadrilateral (a polygon with four sides and four corners) with texture coordinate information.
---
---Quads can be used to select part of a texture to draw. In this way, one large texture atlas can be loaded, and then split up into sub-images.
local Quad = {}
---Gets reference texture dimensions initially specified in love.graphics.newQuad.
---@return number, number
function Quad:getTextureDimensions() end

---Gets the current viewport of this Quad.
---@return number, number, number, number
function Quad:getViewport() end

---Sets the texture coordinates according to a viewport.
---@param x number @The top-left corner along the x-axis.
---@param y number @The top-right corner along the y-axis.
---@param w number @The width of the viewport.
---@param h number @The height of the viewport.
function Quad:setViewport(x, y, w, h) end

--endregion Quad
--region Shader
---@class Shader : Object
---A Shader is used for advanced hardware-accelerated pixel or vertex manipulation. These effects are written in a language based on GLSL (OpenGL Shading Language) with a few things simplified for easier coding.
---
---Potential uses for shaders include HDR/bloom, motion blur, grayscale/invert/sepia/any kind of color effect, reflection/refraction, distortions, bump mapping, and much more! Here is a collection of basic shaders and good starting point to learn: https://github.com/vrld/shine
local Shader = {}
---Gets information about an 'extern' ('uniform') variable in the shader.
---@param name string @The name of the extern variable.
---@return ShaderVariableType, number, number
function Shader:getExternVariable(name) end

---Returns any warning and error messages from compiling the shader code. This can be used for debugging your shaders if there's anything the graphics hardware doesn't like.
---@return string
function Shader:getWarnings() end

---Sends one or more values to a special (uniform) variable inside the shader. Uniform variables have to be marked using the uniform or extern keyword.
---@param name string @Name of the number to send to the shader.
---@param number number @Number to send to store in the uniform variable.
---@param ... number @Additional numbers to send if the uniform variable is an array.
---@overload fun(name:string, vector:table, ...:table):void
---@overload fun(name:string, matrix:table, ...:table):void
---@overload fun(name:string, texture:Texture):void
---@overload fun(name:string, boolean:boolean, ...:boolean):void
function Shader:send(name, number, ...) end

---Sends one or more colors to a special (extern / uniform) vec3 or vec4 variable inside the shader. The color components must be in the range of [0, 255], unlike Shader:send. The colors are gamma-corrected if global gamma-correction is enabled.
---@param name string @The name of the color extern variable to send to in the shader.
---@param color table @A table with red, green, blue, and optional alpha color components in the range of [0, 255] to send to the extern as a vector.
---@param ... table @Additional colors to send in case the extern is an array. All colors need to be of the same size (e.g. only vec3's).
function Shader:sendColor(name, color, ...) end

--endregion Shader
--region SpriteBatch
---@class SpriteBatch : Drawable
---Using a single image, draw any number of identical copies of the image using a single call to love.graphics.draw. This can be used, for example, to draw repeating copies of a single background image.
---
---A SpriteBatch can be even more useful when the underlying image is a Texture Atlas (a single image file containing many independent images); by adding Quad to the batch, different sub-images from within the atlas can be drawn.
local SpriteBatch = {}
---Add a sprite to the batch.
---@param x number @The position to draw the object (x-axis).
---@param y number @The position to draw the object (y-axis).
---@param r number @Orientation (radians).
---@param sx number @Scale factor (x-axis).
---@param sy number @Scale factor (y-axis).
---@param ox number @Origin offset (x-axis).
---@param oy number @Origin offset (y-axis).
---@param kx number @Shear factor (x-axis).
---@param ky number @Shear factor (y-axis).
---@return number
---@overload fun(quad:Quad, x:number, y:number, r:number, sx:number, sy:number, ox:number, oy:number, kx:number, ky:number):number
function SpriteBatch:add(x, y, r, sx, sy, ox, oy, kx, ky) end

---Attaches a per-vertex attribute from a Mesh onto this SpriteBatch, for use when drawing. This can be combined with a Shader to augment a SpriteBatch with per-vertex or additional per-sprite information instead of just having per-sprite colors.
---
---Each sprite in a SpriteBatch has 4 vertices in the following order: top-left, bottom-left, top-right, bottom-right. The index returned by SpriteBatch:add (and used by SpriteBatch:set) can used to determine the first vertex of a specific sprite with the formula "1 + 4 * ( id - 1 )".
---@param name string @The name of the vertex attribute to attach.
---@param mesh Mesh @The Mesh to get the vertex attribute from.
function SpriteBatch:attachAttribute(name, mesh) end

---Removes all sprites from the buffer.
function SpriteBatch:clear() end

---Immediately sends all new and modified sprite data in the batch to the graphics card.
function SpriteBatch:flush() end

---Gets the maximum number of sprites the SpriteBatch can hold.
---@return number
function SpriteBatch:getBufferSize() end

---Gets the color that will be used for the next add and set operations.
---
---If no color has been set with SpriteBatch:setColor or the current SpriteBatch color has been cleared, this method will return nil.
---@return number, number, number, number
function SpriteBatch:getColor() end

---Gets the amount of sprites currently in the SpriteBatch.
---@return number
function SpriteBatch:getCount() end

---Returns the Image or Canvas used by the SpriteBatch.
---@return Texture
function SpriteBatch:getTexture() end

---Changes a sprite in the batch. This requires the identifier returned by add and addq.
---@param id number @The identifier of the sprite that will be changed.
---@param x number @The position to draw the object (x-axis).
---@param y number @The position to draw the object (y-axis).
---@param r number @Orientation (radians).
---@param sx number @Scale factor (x-axis).
---@param sy number @Scale factor (y-axis).
---@param ox number @Origin offset (x-axis).
---@param oy number @Origin offset (y-axis).
---@param kx number @Shear factor (x-axis).
---@param ky number @Shear factor (y-axis).
---@overload fun(id:number, quad:Quad, x:number, y:number, r:number, sx:number, sy:number, ox:number, oy:number, kx:number, ky:number):void
function SpriteBatch:set(id, x, y, r, sx, sy, ox, oy, kx, ky) end

---Sets the maximum number of sprites the SpriteBatch can hold. Existing sprites in the batch (up to the new maximum) will not be cleared when this function is called.
---@param size number @The new maximum number of sprites the batch can hold.
function SpriteBatch:setBufferSize(size) end

---Sets the color that will be used for the next add and set operations. Calling the function without arguments will clear the color.
---
---In version [[0.9.2]] and older, the global color set with love.graphics.setColor will not work on the SpriteBatch if any of the sprites has its own color.
---@param r number @The amount of red.
---@param g number @The amount of green.
---@param b number @The amount of blue.
---@param a number @The amount of alpha.
function SpriteBatch:setColor(r, g, b, a) end

---Replaces the Image or Canvas used for the sprites.
---@param texture Texture @The new Image or Canvas to use for the sprites.
function SpriteBatch:setTexture(texture) end

--endregion SpriteBatch
--region Text
---@class Text : Drawable
---Drawable text.
local Text = {}
---Adds additional colored text to the Text object at the specified position.
---@param textstring string @The text to add to the object.
---@param x number @The position of the new text on the x-axis.
---@param y number @The position of the new text on the y-axis.
---@param angle number @The orientation of the new text in radians.
---@param sx number @Scale factor on the x-axis.
---@param sy number @Scale factor on the y-axis.
---@param ox number @Origin offset on the x-axis.
---@param oy number @Origin offset on the y-axis.
---@param kx number @Shearing / skew factor on the x-axis.
---@param ky number @Shearing / skew factor on the y-axis.
---@return number
---@overload fun(coloredtext:table, x:number, y:number, angle:number, sx:number, sy:number, ox:number, oy:number, kx:number, ky:number):number
function Text:add(textstring, x, y, angle, sx, sy, ox, oy, kx, ky) end

---Adds additional formatted / colored text to the Text object at the specified position.
---@param textstring string @The text to add to the object.
---@param wraplimit number @The maximum width in pixels of the text before it gets automatically wrapped to a new line.
---@param align AlignMode @The alignment of the text.
---@param x number @The position of the new text on the x-axis.
---@param y number @The position of the new text on the y-axis.
---@param angle number @The orientation of the object in radians.
---@param sx number @Scale factor on the x-axis.
---@param sy number @Scale factor on the y-axis.
---@param ox number @Origin offset on the x-axis.
---@param oy number @Origin offset on the y-axis.
---@param kx number @Shearing / skew factor on the x-axis.
---@param ky number @Shearing / skew factor on the y-axis.
---@return number
---@overload fun(coloredtext:table, wraplimit:number, align:AlignMode, x:number, y:number, angle:number, sx:number, sy:number, ox:number, oy:number, kx:number, ky:number):number
function Text:addf(textstring, wraplimit, align, x, y, angle, sx, sy, ox, oy, kx, ky) end

---Clears the contents of the Text object.
function Text:clear() end

---Gets the width and height of the text in pixels.
---@return number, number
---@overload fun(index:number):number, number
function Text:getDimensions() end

---Gets the Font used with the Text object.
---@return Font
function Text:getFont() end

---Gets the height of the text in pixels.
---@return number
---@overload fun(index:number):number
function Text:getHeight() end

---Gets the width of the text in pixels.
---@return number
---@overload fun(index:number):number
function Text:getWidth() end

---Replaces the contents of the Text object with a new unformatted string.
---@param textstring string @The new string of text to use.
---@overload fun(coloredtext:table):void
function Text:set(textstring) end

---Replaces the contents of the Text object with a new formatted string.
---@param textstring string @The new string of text to use.
---@param wraplimit number @The maximum width in pixels of the text before it gets automatically wrapped to a new line.
---@param align AlignMode @The alignment of the text.
---@overload fun(coloredtext:table, wraplimit:number, align:AlignMode):void
function Text:setf(textstring, wraplimit, align) end

---Replaces the Font used with the text.
---@param font Font @The new font to use with this Text object.
function Text:setFont(font) end

--endregion Text
--region Texture
---@class Texture : Drawable
---Superclass for drawable objects which represent a texture. All Textures can be drawn with Quads. This is an abstract type that can't be created directly.
local Texture = {}
--endregion Texture
--region Video
---@class Video : Drawable
---A drawable video.
local Video = {}
---Gets the width and height of the Video in pixels.
---@return number, number
function Video:getDimensions() end

---Gets the scaling filters used when drawing the Video.
---@return FilterMode, FilterMode, number
function Video:getFilter() end

---Gets the height of the Video in pixels.
---@return number
function Video:getHeight() end

---Gets the audio Source used for playing back the video's audio. May return nil if the video has no audio, or if Video:setSource is called with a nil argument.
---@return Source
function Video:getSource() end

---Gets the VideoStream object used for decoding and controlling the video.
---@return VideoStream
function Video:getStream() end

---Gets the width of the Video in pixels.
---@return number
function Video:getWidth() end

---Gets whether the Video is currently playing.
---@return boolean
function Video:isPlaying() end

---Pauses the Video.
function Video:pause() end

---Starts playing the Video. In order for the video to appear onscreen it must be drawn with love.graphics.draw.
function Video:play() end

---Rewinds the Video to the beginning.
function Video:rewind() end

---Sets the current playback position of the Video.
---@param offset number @The time in seconds since the beginning of the Video.
function Video:seek(offset) end

---Sets the scaling filters used when drawing the Video.
---@param min FilterMode @The filter mode used when scaling the Video down.
---@param mag FilterMode @The filter mode used when scaling the Video up.
---@param anisotropy number @Maximum amount of anisotropic filtering used.
function Video:setFilter(min, mag, anisotropy) end

---Sets the audio Source used for playing back the video's audio. The audio Source also controls playback speed and synchronization.
---@param source Source @The audio Source used for audio playback, or nil to disable audio synchronization.
function Video:setSource(source) end

---Gets the current playback position of the Video.
---@param seconds number @The time in seconds since the beginning of the Video.
function Video:tell(seconds) end

--endregion Video
---Text alignment.
AlignMode = {
	---Align text center.
	['center'] = 1,
	---Align text left.
	['left'] = 2,
	---Align text right.
	['right'] = 3,
	---Align text both left and right.
	['justify'] = 4,
}
---Different types of arcs that can be drawn.
ArcType = {
	---The arc is drawn like a slice of pie, with the arc circle connected to the center at its end-points.
	['pie'] = 1,
	---The arc circle's two end-points are unconnected when the arc is drawn as a line. Behaves like the "closed" arc type when the arc is drawn in filled mode.
	['open'] = 2,
	---The arc circle's two end-points are connected to each other.
	['closed'] = 3,
}
---Types of particle area spread distribution.
AreaSpreadDistribution = {
	---Uniform distribution.
	['uniform'] = 1,
	---Normal (gaussian) distribution.
	['normal'] = 2,
	---Uniform distribution in an ellipse.
	['ellipse'] = 3,
	---No distribution - area spread is disabled.
	['none'] = 4,
}
---Different ways alpha affects color blending. See BlendMode and the BlendMode Formulas for additional notes.
BlendAlphaMode = {
	---The RGB values of what's drawn are multiplied by the alpha values of those colors during blending. This is the default alpha mode.
	['alphamultiply'] = 1,
	---The RGB values of what's drawn are not multiplied by the alpha values of those colors during blending. For most blend modes to work correctly with this alpha mode, the colors of a drawn object need to have had their RGB values multiplied by their alpha values at some point previously ("premultiplied alpha").
	['premultiplied'] = 2,
}
---Different ways to do color blending. See BlendAlphaMode and the BlendMode Formulas for additional notes.
BlendMode = {
	---Alpha blending (normal). The alpha of what's drawn determines its opacity.
	['alpha'] = 1,
	---The colors of what's drawn completely replace what was on the screen, with no additional blending. The BlendAlphaMode specified in love.graphics.setBlendMode still affects what happens.
	['replace'] = 2,
	---"Screen" blending.
	['screen'] = 3,
	---The pixel colors of what's drawn are added to the pixel colors already on the screen. The alpha of the screen is not modified.
	['add'] = 4,
	---The pixel colors of what's drawn are subtracted from the pixel colors already on the screen. The alpha of the screen is not modified.
	['subtract'] = 5,
	---The pixel colors of what's drawn are multiplied with the pixel colors already on the screen (darkening them). The alpha of drawn objects is multiplied with the alpha of the screen rather than determining how much the colors on the screen are affected, even when the "alphamultiply" BlendAlphaMode is used.
	['multiply'] = 6,
	---The pixel colors of what's drawn are compared to the existing pixel colors, and the larger of the two values for each color component is used. Only works when the "premultiplied" BlendAlphaMode is used in love.graphics.setBlendMode.
	['lighten'] = 7,
	---The pixel colors of what's drawn are compared to the existing pixel colors, and the smaller of the two values for each color component is used. Only works when the "premultiplied" BlendAlphaMode is used in love.graphics.setBlendMode.
	['darken'] = 8,
}
---Canvas formats.
CanvasFormat = {
	---The default Canvas format - usually an alias for the rgba8 format, or the srgb format if gamma-correct rendering is enabled in LÖVE 0.10.0 and newer.
	['normal'] = 1,
	---A format suitable for high dynamic range content - an alias for the rgba16f format, normally.
	['hdr'] = 2,
	---8 bits per channel (32 bpp) RGBA. Color channel values range from 0-255 (0-1 in shaders).
	['rgba8'] = 3,
	---4 bits per channel (16 bpp) RGBA.
	['rgba4'] = 4,
	---RGB with 5 bits each, and a 1-bit alpha channel (16 bpp).
	['rgb5a1'] = 5,
	---RGB with 5, 6, and 5 bits each, respectively (16 bpp). There is no alpha channel in this format.
	['rgb565'] = 6,
	---RGB with 10 bits per channel, and a 2-bit alpha channel (32 bpp).
	['rgb10a2'] = 7,
	---Floating point RGBA with 16 bits per channel (64 bpp). Color values can range from [-65504, +65504].
	['rgba16f'] = 8,
	---Floating point RGBA with 32 bits per channel (128 bpp).
	['rgba32f'] = 9,
	---Floating point RGB with 11 bits in the red and green channels, and 10 bits in the blue channel (32 bpp). There is no alpha channel. Color values can range from [0, +65024].
	['rg11b10f'] = 10,
	---The same as rgba8, but the Canvas is interpreted as being in the sRGB color space. Everything drawn to the Canvas will be converted from linear RGB to sRGB. When the Canvas is drawn (or used in a shader), it will be decoded from sRGB to linear RGB. This reduces color banding when doing gamma-correct rendering, since sRGB encoding has more precision than linear RGB for darker colors.
	['srgb'] = 11,
	---Single-channel (red component) format (8 bpp).
	['r8'] = 12,
	---Two channels (red and green components) with 8 bits per channel (16 bpp).
	['rg8'] = 13,
	---Floating point single-channel format (16 bpp). Color values can range from [-65504, +65504].
	['r16f'] = 14,
	---Floating point two-channel format with 16 bits per channel (32 bpp). Color values can range from [-65504, +65504].
	['rg16f'] = 15,
	---Floating point single-channel format (32 bpp).
	['r32f'] = 16,
	---Floating point two-channel format with 32 bits per channel (64 bpp).
	['rg32f'] = 17,
}
---Different types of per-pixel stencil test comparisons. The pixels of an object will be drawn if the comparison succeeds, for each pixel that the object touches.
CompareMode = {
	---The stencil value of the pixel must be equal to the supplied value.
	['equal'] = 1,
	---The stencil value of the pixel must not be equal to the supplied value.
	['notequal'] = 2,
	---The stencil value of the pixel must be less than the supplied value.
	['less'] = 3,
	---The stencil value of the pixel must be less than or equal to the supplied value.
	['lequal'] = 4,
	---The stencil value of the pixel must be greater than or equal to the supplied value.
	['gequal'] = 5,
	---The stencil value of the pixel must be greater than the supplied value.
	['greater'] = 6,
}
---Controls whether shapes are drawn as an outline, or filled.
DrawMode = {
	---Draw filled shape.
	['fill'] = 1,
	---Draw outlined shape.
	['line'] = 2,
}
---How the image is filtered when scaling.
FilterMode = {
	---Scale image with linear interpolation.
	['linear'] = 1,
	---Scale image with nearest neighbor interpolation.
	['nearest'] = 2,
}
---Graphics features that can be checked for with love.graphics.getSupported.
GraphicsFeature = {
	---Whether the "clampzero" WrapMode is supported.
	['clampzero'] = 1,
	---Whether the "lighten" and "darken" BlendModes are supported.
	['lighten'] = 2,
	---Whether multiple Canvases with different formats can be used in the same love.graphics.setCanvas call.
	['multicanvasformats'] = 3,
}
---Types of system-dependent graphics limits checked for using love.graphics.getSystemLimits.
GraphicsLimit = {
	---The maximum size of points.
	['pointsize'] = 1,
	---The maximum width or height of Images and Canvases.
	['texturesize'] = 2,
	---The maximum number of simultaneously active canvases (via love.graphics.setCanvas).
	['multicanvas'] = 3,
	---The maximum number of antialiasing samples for a Canvas.
	['canvasmsaa'] = 4,
}
---Line join style.
LineJoin = {
	---The ends of the line segments beveled in an angle so that they join seamlessly.
	['miter'] = 1,
	---No cap applied to the ends of the line segments.
	['bevel'] = 2,
	---Flattens the point where line segments join together.
	['none'] = 3,
}
---The styles in which lines are drawn.
LineStyle = {
	---Draw rough lines.
	['rough'] = 1,
	---Draw smooth lines.
	['smooth'] = 2,
}
---How a Mesh's vertices are used when drawing.
MeshDrawMode = {
	---The vertices create a "fan" shape with the first vertex acting as the hub point. Can be easily used to draw simple convex polygons.
	['fan'] = 1,
	---The vertices create a series of connected triangles using vertices 1, 2, 3, then 3, 2, 4 (note the order), then 3, 4, 5 and so on.
	['strip'] = 2,
	---The vertices create unconnected triangles.
	['triangles'] = 3,
	---The vertices are drawn as unconnected points (see love.graphics.setPointSize.)
	['points'] = 4,
}
---How newly created particles are added to the ParticleSystem.
ParticleInsertMode = {
	---Particles are inserted at the top of the ParticleSystem's list of particles.
	['top'] = 1,
	---Particles are inserted at the bottom of the ParticleSystem's list of particles.
	['bottom'] = 2,
	---Particles are inserted at random positions in the ParticleSystem's list of particles.
	['random'] = 3,
}
---Usage hints for SpriteBatches and Meshes to optimize data storage and access.
SpriteBatchUsage = {
	---The object's data will change occasionally during its lifetime.
	['dynamic'] = 1,
	---The object will not be modified after initial sprites or vertices are added.
	['static'] = 2,
	---The object data will always change between draws.
	['stream'] = 3,
}
---Graphics state stack types used with love.graphics.push.
StackType = {
	---The transformation stack (love.graphics.translate, love.graphics.rotate, etc.)
	['transform'] = 1,
	---All love.graphics state, including transform state.
	['all'] = 2,
}
---How a stencil function modifies the stencil values of pixels it touches.
StencilAction = {
	---The stencil value of a pixel will be replaced by the value specified in love.graphics.stencil, if any object touches the pixel.
	['replace'] = 1,
	---The stencil value of a pixel will be incremented by 1 for each object that touches the pixel. If the stencil value reaches 255 it will stay at 255.
	['increment'] = 2,
	---The stencil value of a pixel will be decremented by 1 for each object that touches the pixel. If the stencil value reaches 0 it will stay at 0.
	['decrement'] = 3,
	---The stencil value of a pixel will be incremented by 1 for each object that touches the pixel. If a stencil value of 255 is incremented it will be set to 0.
	['incrementwrap'] = 4,
	---The stencil value of a pixel will be decremented by 1 for each object that touches the pixel. If the stencil value of 0 is decremented it will be set to 255.
	['decrementwrap'] = 5,
	---The stencil value of a pixel will be bitwise-inverted for each object that touches the pixel. If a stencil value of 0 is inverted it will become 255.
	['invert'] = 6,
}
---How the image wraps inside a Quad with a larger quad size than image size. This also affects how Meshes with texture coordinates which are outside the range of [0, 1] are drawn, and the color returned by the Texel Shader function when using it to sample from texture coordinates outside of the range of [0, 1].
WrapMode = {
	---How the image wraps inside a Quad with a larger quad size than image size. This also affects how Meshes with texture coordinates which are outside the range of [0, 1] are drawn, and the color returned by the Texel Shader function when using it to sample from texture coordinates outside of the range of [0, 1].
	['clamp'] = 1,
	---Repeat the image. Fills the whole available extent.
	['repeat'] = 2,
	---Repeat the texture, flipping it each time it repeats. May produce better visual results than the repeat mode when the texture doesn't seamlessly tile.
	['mirroredrepeat'] = 3,
	---Clamp the texture. Fills the area outside the texture's normal range with transparent black (or opaque black for textures with no alpha channel.)
	['clampzero'] = 4,
}
---Draws a filled or unfilled arc at position (x, y). The arc is drawn from angle1 to angle2 in radians. The segments parameter determines how many segments are used to draw the arc. The more segments, the smoother the edge.
---@param drawmode DrawMode @How to draw the arc.
---@param x number @The position of the center along x-axis.
---@param y number @The position of the center along y-axis.
---@param radius number @Radius of the arc.
---@param angle1 number @The angle at which the arc begins.
---@param angle2 number @The angle at which the arc terminates.
---@param segments number @The number of segments used for drawing the arc.
---@overload fun(drawmode:DrawMode, arctype:ArcType, x:number, y:number, radius:number, angle1:number, angle2:number, segments:number):void
function m.arc(drawmode, x, y, radius, angle1, angle2, segments) end

---Draws a circle.
---@param mode DrawMode @How to draw the circle.
---@param x number @The position of the center along x-axis.
---@param y number @The position of the center along y-axis.
---@param radius number @The radius of the circle.
---@overload fun(mode:DrawMode, x:number, y:number, radius:number, segments:number):void
function m.circle(mode, x, y, radius) end

---Clears the screen to the background color in LÖVE 0.9.2 and earlier, or to the specified color in 0.10.0 and newer.
---
---This function is called automatically before love.draw in the default love.run function. See the example in love.run for a typical use of this function.
---
---Note that the scissor area bounds the cleared region.
---@overload fun(r:number, g:number, b:number, a:number):void
---@overload fun(color:table, ...:table):void
function m.clear() end

---Discards (trashes) the contents of the screen or active Canvas. This is a performance optimization function with niche use cases.
---
---If the active Canvas has just been changed and the "replace" BlendMode is about to be used to draw something which covers the entire screen, calling love.graphics.discard rather than calling love.graphics.clear or doing nothing may improve performance on mobile devices.
---
---On some desktop systems this function may do nothing.
---@param discardcolor boolean @Whether to discard the texture(s) of the active Canvas(es) (the contents of the screen if no Canvas is active).
---@param discardstencil boolean @Whether to discard the contents of the stencil buffer of the screen / active Canvas.
---@overload fun(discardcolors:table, discardstencil:boolean):void
function m.discard(discardcolor, discardstencil) end

---Draws a Drawable object (an Image, Canvas, SpriteBatch, ParticleSystem, Mesh, or Video) on the screen with optional rotation, scaling and shearing.
---
---Objects are drawn relative to their local coordinate system. The origin is by default located at the top left corner of Image and Canvas. All scaling, shearing, and rotation arguments transform the object relative to that point. Also, the position of the origin can be specified on the screen coordinate system.
---
---It's possible to rotate an object about its center by offsetting the origin to the center. Angles must be given in radians for rotation. One can also use a negative scaling factor to flip about its centerline.
---
---Note that the offsets are applied before rotation, scaling, or shearing; scaling and shearing are applied before rotation.
---
---The right and bottom edges of the object are shifted at an angle defined by the shearing factors.
---@param drawable Drawable @A drawable object.
---@param x number @The position to draw the object (x-axis).
---@param y number @The position to draw the object (y-axis).
---@param r number @Orientation (radians).
---@param sx number @Scale factor (x-axis). Can be negative.
---@param sy number @Scale factor (y-axis). Can be negative.
---@param ox number @Origin offset (x-axis). (A value of 20 would effectively move your drawable object 20 pixels to the left.)
---@param oy number @Origin offset (y-axis). (A value of 20 would effectively move your drawable object 20 pixels up.)
---@param kx number @Shearing factor (x-axis).
---@param ky number @Shearing factor (y-axis).
---@overload fun(texture:Texture, quad:Quad, x:number, y:number, r:number, sx:number, sy:number, ox:number, oy:number, kx:number, ky:number):void
function m.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky) end

---Draws an ellipse.
---@param mode DrawMode @How to draw the ellipse.
---@param x number @The position of the center along x-axis.
---@param y number @The position of the center along y-axis.
---@param radiusx number @The radius of the ellipse along the x-axis (half the ellipse's width).
---@param radiusy number @The radius of the ellipse along the y-axis (half the ellipse's height).
---@overload fun(mode:DrawMode, x:number, y:number, radiusx:number, radiusy:number, segments:number):void
function m.ellipse(mode, x, y, radiusx, radiusy) end

---Gets the current background color.
---@return number, number, number, number
function m.getBackgroundColor() end

---Gets the blending mode.
---@return BlendMode, BlendAlphaMode
function m.getBlendMode() end

---Gets the current target Canvas.
---@return Canvas
function m.getCanvas() end

---Gets the available Canvas formats, and whether each is supported.
---@return table
function m.getCanvasFormats() end

---Gets the current color.
---@return number, number, number, number
function m.getColor() end

---Gets the active color components used when drawing. Normally all 4 components are active unless love.graphics.setColorMask has been used.
---
---The color mask determines whether individual components of the colors of drawn objects will affect the color of the screen. They affect love.graphics.clear and Canvas:clear as well.
---@return boolean, boolean, boolean, boolean
function m.getColorMask() end

---Gets the available compressed image formats, and whether each is supported.
---@return table
function m.getCompressedImageFormats() end

---Returns the default scaling filters used with Images, Canvases, and Fonts.
---@return FilterMode, FilterMode, number
function m.getDefaultFilter() end

---Gets the width and height of the window.
---@return number, number
function m.getDimensions() end

---Gets the current Font object.
---@return Font
function m.getFont() end

---Gets the height of the window.
---@return number
function m.getHeight() end

---Gets the line join style.
---@return LineJoin
function m.getLineJoin() end

---Gets the line style.
---@return LineStyle
function m.getLineStyle() end

---Gets the current line width.
---@return number
function m.getLineWidth() end

---Returns the current Shader. Returns nil if none is set.
---@return Shader
function m.getShader() end

---Gets performance-related rendering statistics.
---@return table
function m.getStats() end

---Gets whether stencil testing is enabled.
---
---When stencil testing is enabled, the geometry of everything that is drawn will be clipped / stencilled out based on whether it intersects with what has been previously drawn to the stencil buffer.
---
---Each Canvas has its own stencil buffer.
---@return boolean, boolean
function m.getStencilTest() end

---Gets the optional graphics features and whether they're supported on the system.
---
---Some older or low-end systems don't always support all graphics features.
---@return table
function m.getSupported() end

---Gets the system-dependent maximum values for love.graphics features.
---@return table
function m.getSystemLimits() end

---Gets the point size.
---@return number
function m.getPointSize() end

---Gets information about the system's video card and drivers.
---@return string, string, string, string
function m.getRendererInfo() end

---Gets the current scissor box.
---@return number, number, number, number
function m.getScissor() end

---Gets the width of the window.
---@return number
function m.getWidth() end

---Sets the scissor to the rectangle created by the intersection of the specified rectangle with the existing scissor. If no scissor is active yet, it behaves like love.graphics.setScissor.
---
---The scissor limits the drawing area to a specified rectangle. This affects all graphics calls, including love.graphics.clear.
---
---The dimensions of the scissor is unaffected by graphical transformations (translate, scale, ...).
---@param x number @The x-coordinate of the upper left corner of the rectangle to intersect with the existing scissor rectangle.
---@param y number @The y-coordinate of the upper left corner of the rectangle to intersect with the existing scissor rectangle.
---@param width number @The width of the rectangle to intersect with the existing scissor rectangle.
---@param height number @The height of the rectangle to intersect with the existing scissor rectangle.
function m.intersectScissor(x, y, width, height) end

---Gets whether gamma-correct rendering is supported and enabled. It can be enabled by setting t.gammacorrect = true in love.conf.
---
---Not all devices support gamma-correct rendering, in which case it will be automatically disabled and this function will return false. It is supported on desktop systems which have graphics cards that are capable of using OpenGL 3 / DirectX 10, and iOS devices that can use OpenGL ES 3.
---@return boolean
function m.isGammaCorrect() end

---Gets whether wireframe mode is used when drawing.
---@return boolean
function m.isWireframe() end

---Draws lines between points.
---@param x1 number @The position of first point on the x-axis.
---@param y1 number @The position of first point on the y-axis.
---@param x2 number @The position of second point on the x-axis.
---@param y2 number @The position of second point on the y-axis.
---@param ... number @You can continue passing point positions to draw a polyline.
---@overload fun(points:table):void
function m.line(x1, y1, x2, y2, ...) end

---Creates a new Canvas object for offscreen rendering.
---
---Antialiased Canvases have slightly higher system requirements than normal Canvases. Additionally, the supported maximum number of MSAA samples varies depending on the system. Use love.graphics.getSystemLimit to check.
---
---If the number of MSAA samples specified is greater than the maximum supported by the system, the Canvas will still be created but only using the maximum supported amount (this includes 0.)
---@param width number @The width of the Canvas.
---@param height number @The height of the Canvas.
---@param format CanvasFormat @The desired texture mode of the Canvas.
---@param msaa number @The desired number of antialiasing samples used when drawing to the Canvas.
---@return Canvas
function m.newCanvas(width, height, format, msaa) end

---Creates a new Font from a TrueType Font or BMFont file. Created fonts are not cached, in that calling this function with the same arguments will always create a new Font object.
---
---All variants which accept a filename can also accept a Data object instead.
---@param filename string @The filepath to the BMFont or TrueType font file.
---@return Font
---@overload fun(filename:string, size:number):Font
---@overload fun(filename:string, imagefilename:string):Font
---@overload fun(size:number):Font
function m.newFont(filename) end

---Creates a new Mesh.
---
---Use Mesh:setTexture if the Mesh should be textured with an Image or Canvas when it's drawn.
---@param vertices table @The table filled with vertex information tables for each vertex as follows:
---@param mode MeshDrawMode @How the vertices are used when drawing. The default mode "fan" is sufficient for simple convex polygons.
---@param usage SpriteBatchUsage @The expected usage of the Mesh. The specified usage mode affects the Mesh's memory usage and performance.
---@return Mesh
---@overload fun(vertexcount:number, mode:MeshDrawMode, usage:SpriteBatchUsage):Mesh
---@overload fun(vertexformat:table, vertices:table, mode:MeshDrawMode, usage:SpriteBatchUsage):Mesh
---@overload fun(vertexformat:table, vertexcount:number, mode:MeshDrawMode, usage:SpriteBatchUsage):Mesh
function m.newMesh(vertices, mode, usage) end

---Creates a new Image from a filepath, FileData, an ImageData, or a CompressedImageData, and optionally generates or specifies mipmaps for the image.
---@param filename string @The filepath to the image file.
---@return Image
---@overload fun(imageData:ImageData):Image
---@overload fun(compressedImageData:CompressedImageData):Image
---@overload fun(filename:string, flags:table):Image
function m.newImage(filename) end

---Creates a new Font by loading a specifically formatted image.
---
---In versions prior to 0.9.0, LÖVE expects ISO 8859-1 encoding for the glyphs string.
---@param filename string @The filepath to the image file.
---@param glyphs string @A string of the characters in the image in order from left to right.
---@return Font
---@overload fun(imageData:ImageData, glyphs:string):Font
---@overload fun(filename:string, glyphs:string, extraspacing:number):Font
function m.newImageFont(filename, glyphs) end

---Creates a new ParticleSystem.
---@param texture Texture @The Image or Canvas to use.
---@param buffer number @The max number of particles at the same time.
---@return ParticleSystem
function m.newParticleSystem(texture, buffer) end

---Creates a new Shader object for hardware-accelerated vertex and pixel effects. A Shader contains either vertex shader code, pixel shader code, or both.
---
---Vertex shader code must contain at least one function, named position, which is the function that will produce transformed vertex positions of drawn objects in screen-space.
---
---Pixel shader code must contain at least one function, named effect, which is the function that will produce the color which is blended onto the screen for each pixel a drawn object touches.
---@param code string @The pixel shader or vertex shader code, or a filename pointing to a file with the code.
---@return Shader
---@overload fun(pixelcode:string, vertexcode:string):Shader
function m.newShader(code) end

---Creates a new drawable Text object.
---@param font Font @The font to use for the text.
---@param textstring string @The initial string of text that the new Text object will contain. May be nil.
---@return Text
function m.newText(font, textstring) end

---Creates a new Quad.
---
---The purpose of a Quad is to describe the result of the following transformation on any drawable object. The object is first scaled to dimensions sw * sh. The Quad then describes the rectangular area of dimensions width * height whose upper left corner is at position (x, y) inside the scaled object.
---@param x number @The top-left position along the x-axis.
---@param y number @The top-left position along the y-axis.
---@param width number @The width of the Quad.
---@param height number @The height of the Quad.
---@param sw number @The reference width, the width of the Image.
---@param sh number @The reference height, the height of the Image.
---@return Quad
function m.newQuad(x, y, width, height, sw, sh) end

---Creates a screenshot and returns the image data.
---@param copyAlpha boolean @Whether to include the screen's alpha channel in the ImageData. If false, the screenshot will be fully opaque.
---@return ImageData
function m.newScreenshot(copyAlpha) end

---Creates a new SpriteBatch object.
---@param texture Texture @The Image or Canvas to use for the sprites.
---@param maxsprites number @The max number of sprites.
---@param usage SpriteBatchUsage @The expected usage of the SpriteBatch. The specified usage mode affects the SpriteBatch's memory usage and performance.
---@return SpriteBatch
function m.newSpriteBatch(texture, maxsprites, usage) end

---Creates a new drawable Video. Currently only Ogg Theora video files are supported.
---@param filename string @The file path to the Ogg Theora video file.
---@param loadaudio boolean @Whether to try to load the video's audio into an audio Source. If not explicitly set to true or false, it will try without causing an error if the video has no audio.
---@return Video
---@overload fun(videostream:VideoStream, loadaudio:boolean):Video
function m.newVideo(filename, loadaudio) end

---Resets the current coordinate transformation.
---
---This function is always used to reverse any previous calls to love.graphics.rotate, love.graphics.scale, love.graphics.shear or love.graphics.translate. It returns the current transformation state to its defaults.
function m.origin() end

---Draws one or more points.
---@param x number @The position of the first point on the x-axis.
---@param y number @The position of the first point on the y-axis.
---@param ... number @The x and y coordinates of additional points.
---@overload fun(points:table):void
---@overload fun(points:table):void
function m.points(x, y, ...) end

---Draw a polygon.
---
---Following the mode argument, this function can accept multiple numeric arguments or a single table of numeric arguments. In either case the arguments are interpreted as alternating x and y coordinates of the polygon's vertices.
---
---When in fill mode, the polygon must be convex and simple or rendering artifacts may occur.
---@param mode DrawMode @How to draw the polygon.
---@param ... number @The vertices of the polygon.
---@overload fun(mode:DrawMode, vertices:table):void
function m.polygon(mode, ...) end

---Pops the current coordinate transformation from the transformation stack.
---
---This function is always used to reverse a previous push operation. It returns the current transformation state to what it was before the last preceding push. For an example, see the description of love.graphics.push.
function m.pop() end

---Displays the results of drawing operations on the screen.
---
---This function is used when writing your own love.run function. It presents all the results of your drawing operations on the screen. See the example in love.run for a typical use of this function.
function m.present() end

---Draws text on screen. If no Font is set, one will be created and set (once) if needed.
---
---As of LOVE 0.7.1, when using translation and scaling functions while drawing text, this function assumes the scale occurs first. If you don't script with this in mind, the text won't be in the right position, or possibly even on screen.
---
---love.graphics.print and love.graphics.printf both support UTF-8 encoding. You'll also need a proper Font for special characters.
---@param text string @The text to draw.
---@param x number @The position to draw the object (x-axis).
---@param y number @The position to draw the object (y-axis).
---@param r number @Orientation (radians).
---@param sx number @Scale factor (x-axis).
---@param sy number @Scale factor (y-axis).
---@param ox number @Origin offset (x-axis).
---@param oy number @Origin offset (y-axis).
---@param kx number @Shear factor (x-axis).
---@param ky number @Shear factor (y-axis).
---@overload fun(coloredtext:table, x:number, y:number, angle:number, sx:number, sy:number, ox:number, oy:number, kx:number, ky:number):void
function m.print(text, x, y, r, sx, sy, ox, oy, kx, ky) end

---Draws formatted text, with word wrap and alignment.
---
---See additional notes in love.graphics.print.
---
---In version 0.9.2 and earlier, wrapping was implemented by breaking up words by spaces and putting them back together to make sure things fit nicely within the limit provided. However, due to the way this is done, extra spaces between words would end up missing when printed on the screen, and some lines could overflow past the provided wrap limit. In version 0.10.0 and newer this is no longer the case.
---@param text string @A text string.
---@param x number @The position on the x-axis.
---@param y number @The position on the y-axis.
---@param limit number @Wrap the line after this many horizontal pixels.
---@param align AlignMode @The alignment.
---@param r number @Orientation (radians).
---@param sx number @Scale factor (x-axis).
---@param sy number @Scale factor (y-axis).
---@param ox number @Origin offset (x-axis).
---@param oy number @Origin offset (y-axis).
---@param kx number @Shear factor (x-axis).
---@param ky number @Shear factor (y-axis).
---@overload fun(coloredtext:table, x:number, y:number, wraplimit:number, align:AlignMode, angle:number, sx:number, sy:number, ox:number, oy:number, kx:number, ky:number):void
function m.printf(text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky) end

---Copies and pushes the current coordinate transformation to the transformation stack.
---
---This function is always used to prepare for a corresponding pop operation later. It stores the current coordinate transformation state into the transformation stack and keeps it active. Later changes to the transformation can be undone by using the pop operation, which returns the coordinate transform to the state it was in before calling push.
---@param stack StackType @The type of stack to push (e.g. just transformation state, or all love.graphics state).
function m.push(stack) end

---Draws a rectangle.
---@param mode DrawMode @How to draw the rectangle.
---@param x number @The position of top-left corner along the x-axis.
---@param y number @The position of top-left corner along the y-axis.
---@param width number @Width of the rectangle.
---@param height number @Height of the rectangle.
---@overload fun(mode:DrawMode, x:number, y:number, width:number, height:number, rx:number, ry:number, segments:number):void
function m.rectangle(mode, x, y, width, height) end

---Resets the current graphics settings.
---
---Calling reset makes the current drawing color white, the current background color black, resets any active Canvas or Shader, and removes any scissor settings. It sets the BlendMode to alpha. It also sets both the point and line drawing modes to smooth and their sizes to 1.0.
function m.reset() end

---Rotates the coordinate system in two dimensions.
---
---Calling this function affects all future drawing operations by rotating the coordinate system around the origin by the given amount of radians. This change lasts until love.draw exits.
---@param angle number @The amount to rotate the coordinate system in radians.
function m.rotate(angle) end

---Scales the coordinate system in two dimensions.
---
---By default the coordinate system in LÖVE corresponds to the display pixels in horizontal and vertical directions one-to-one, and the x-axis increases towards the right while the y-axis increases downwards. Scaling the coordinate system changes this relation.
---
---After scaling by sx and sy, all coordinates are treated as if they were multiplied by sx and sy. Every result of a drawing operation is also correspondingly scaled, so scaling by (2, 2) for example would mean making everything twice as large in both x- and y-directions. Scaling by a negative value flips the coordinate system in the corresponding direction, which also means everything will be drawn flipped or upside down, or both. Scaling by zero is not a useful operation.
---
---Scale and translate are not commutative operations, therefore, calling them in different orders will change the outcome.
---
---Scaling lasts until love.draw exits.
---@param sx number @The scaling in the direction of the x-axis.
---@param sy number @The scaling in the direction of the y-axis. If omitted, it defaults to same as parameter sx.
function m.scale(sx, sy) end

---Sets the background color.
---@param r number @The red component (0-255).
---@param g number @The green component (0-255).
---@param b number @The blue component (0-255).
---@param a number @The alpha component (0-255).
---@overload fun(rgba:table):void
function m.setBackgroundColor(r, g, b, a) end

---Sets the blending mode.
---@param mode BlendMode @The blend mode to use.
---@overload fun(mode:BlendMode, alphamode:BlendAlphaMode):void
function m.setBlendMode(mode) end

---Captures drawing operations to a Canvas.
---@param canvas Canvas @A render target.
---@overload fun(canvas1:Canvas, canvas2:Canvas, ...:Canvas):void
function m.setCanvas(canvas) end

---Sets the color used for drawing.
---@param red number @The amount of red.
---@param green number @The amount of green.
---@param blue number @The amount of blue.
---@param alpha number @The amount of alpha. The alpha value will be applied to all subsequent draw operations, even the drawing of an image.
---@overload fun(rgba:table):void
function m.setColor(red, green, blue, alpha) end

---Sets the color mask. Enables or disables specific color components when rendering and clearing the screen. For example, if red is set to false, no further changes will be made to the red component of any pixels.
---
---Enables all color components when called without arguments.
---@param red boolean @Render red component.
---@param green boolean @Render green component.
---@param blue boolean @Render blue component.
---@param alpha boolean @Render alpha component.
function m.setColorMask(red, green, blue, alpha) end

---Sets the default scaling filters used with Images, Canvases, and Fonts.
---
---This function does not apply retroactively to loaded images.
---@param min FilterMode @Filter mode used when scaling the image down.
---@param mag FilterMode @Filter mode used when scaling the image up.
---@param anisotropy number @Maximum amount of Anisotropic Filtering used.
function m.setDefaultFilter(min, mag, anisotropy) end

---Set an already-loaded Font as the current font or create and load a new one from the file and size.
---
---It's recommended that Font objects are created with love.graphics.newFont in the loading stage and then passed to this function in the drawing stage.
---@param font Font @The Font object to use.
function m.setFont(font) end

---Sets the line join style.
---@param join LineJoin @The LineJoin to use.
function m.setLineJoin(join) end

---Sets the line style.
---@param style LineStyle @The LineStyle to use.
function m.setLineStyle(style) end

---Sets the line width.
---@param width number @The width of the line.
function m.setLineWidth(width) end

---Creates and sets a new font.
---@param filename string @The path and name of the file with the font.
---@param size number @The size of the font.
---@return Font
---@overload fun(file:File, size:number):Font
---@overload fun(data:Data, size:number):Font
function m.setNewFont(filename, size) end

---Sets or resets a Shader as the current pixel effect or vertex shaders. All drawing operations until the next love.graphics.setShader will be drawn using the Shader object specified.
---
---Disables the shaders when called without arguments.
---@overload fun(shader:Shader):void
function m.setShader() end

---Sets the point size.
---@param size number @The new point size.
function m.setPointSize(size) end

---Sets or disables scissor.
---
---The scissor limits the drawing area to a specified rectangle. This affects all graphics calls, including love.graphics.clear.
---@param x number @The X coordinate of upper left corner.
---@param y number @The Y coordinate of upper left corner.
---@param width number @The width of clipping rectangle.
---@param height number @The height of clipping rectangle.
function m.setScissor(x, y, width, height) end

---Configures or disables stencil testing.
---
---When stencil testing is enabled, the geometry of everything that is drawn afterward will be clipped / stencilled out based on a comparison between the arguments of this function and the stencil value of each pixel that the geometry touches. The stencil values of pixels are affected via love.graphics.stencil.
---
---Each Canvas has its own per-pixel stencil values.
---@param comparemode CompareMode @The type of comparison to make for each pixel.
---@param comparevalue number @The value to use when comparing with the stencil value of each pixel. Must be between 0 and 255.
function m.setStencilTest(comparemode, comparevalue) end

---Sets whether wireframe lines will be used when drawing.
---
---Wireframe mode should only be used for debugging. The lines drawn with it enabled do not behave like regular love.graphics lines: their widths don't scale with the coordinate transformations or with love.graphics.setLineWidth, and they don't use the smooth LineStyle.
---@param enable boolean @True to enable wireframe mode when drawing, false to disable it.
function m.setWireframe(enable) end

---Shears the coordinate system.
---@param kx number @The shear factor on the x-axis.
---@param ky number @The shear factor on the y-axis.
function m.shear(kx, ky) end

---Draws geometry as a stencil.
---
---The geometry drawn by the supplied function sets invisible stencil values of pixels, instead of setting pixel colors. The stencil values of pixels can act like a mask / stencil - love.graphics.setStencilTest can be used afterward to determine how further rendering is affected by the stencil values in each pixel.
---
---Each Canvas has its own per-pixel stencil values. Stencil values are within the range of [0, 255].
---@param stencilfunction function @Function which draws geometry. The stencil values of pixels, rather than the color of each pixel, will be affected by the geometry.
---@param action StencilAction @How to modify any stencil values of pixels that are touched by what's drawn in the stencil function.
---@param value number @The new stencil value to use for pixels if the "replace" stencil action is used. Has no effect with other stencil actions. Must be between 0 and 255.
---@param keepvalues boolean @True to preserve old stencil values of pixels, false to re-set every pixel's stencil value to 0 before executing the stencil function. love.graphics.clear will also re-set all stencil values.
function m.stencil(stencilfunction, action, value, keepvalues) end

---Translates the coordinate system in two dimensions.
---
---When this function is called with two numbers, dx, and dy, all the following drawing operations take effect as if their x and y coordinates were x+dx and y+dy.
---
---Scale and translate are not commutative operations, therefore, calling them in different orders will change the outcome.
---
---This change lasts until love.graphics.clear is called (which is called automatically before love.draw in the default love.run function), or a love.graphics.pop reverts to a previous coordinate system state.
---
---Translating using whole numbers will prevent tearing/blurring of images and fonts draw after translating.
---@param dx number @The translation relative to the x-axis.
---@param dy number @The translation relative to the y-axis.
function m.translate(dx, dy) end

return m