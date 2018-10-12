---@class love.physics
---Can simulate 2D rigid body physics in a realistic manner. This module is based on Box2D, and this API corresponds to the Box2D API as closely as possible.
local m = {}

--region Body
---@class Body : Object
---Bodies are objects with velocity and position.
local Body = {}
---Applies an angular impulse to a body. This makes a single, instantaneous addition to the body momentum.
---
---A body with with a larger mass will react less. The reaction does not depend on the timestep, and is equivalent to applying a force continuously for 1 second. Impulses are best used to give a single push to a body. For a continuous push to a body it is better to use Body:applyForce.
---@param impulse number @The impulse in kilogram-square meter per second.
function Body:applyAngularImpulse(impulse) end

---Apply force to a Body.
---
---A force pushes a body in a direction. A body with with a larger mass will react less. The reaction also depends on how long a force is applied: since the force acts continuously over the entire timestep, a short timestep will only push the body for a short time. Thus forces are best used for many timesteps to give a continuous push to a body (like gravity). For a single push that is independent of timestep, it is better to use Body:applyLinearImpulse.
---
---If the position to apply the force is not given, it will act on the center of mass of the body. The part of the force not directed towards the center of mass will cause the body to spin (and depends on the rotational inertia).
---
---Note that the force components and position must be given in world coordinates.
---@param fx number @The x component of force to apply to the center of mass.
---@param fy number @The y component of force to apply to the center of mass.
---@overload fun(fx:number, fy:number, x:number, y:number):void
function Body:applyForce(fx, fy) end

---Applies an impulse to a body. This makes a single, instantaneous addition to the body momentum.
---
---An impulse pushes a body in a direction. A body with with a larger mass will react less. The reaction does not depend on the timestep, and is equivalent to applying a force continuously for 1 second. Impulses are best used to give a single push to a body. For a continuous push to a body it is better to use Body:applyForce.
---
---If the position to apply the impulse is not given, it will act on the center of mass of the body. The part of the impulse not directed towards the center of mass will cause the body to spin (and depends on the rotational inertia).
---
---Note that the impulse components and position must be given in world coordinates.
---@param ix number @The x component of the impulse applied to the center of mass.
---@param iy number @The y component of the impulse applied to the center of mass.
---@overload fun(ix:number, iy:number, x:number, y:number):void
function Body:applyLinearImpulse(ix, iy) end

---Apply torque to a body.
---
---Torque is like a force that will change the angular velocity (spin) of a body. The effect will depend on the rotational inertia a body has.
---@param torque number @The torque to apply.
function Body:applyTorque(torque) end

---Explicitly destroys the Body. When you don't have time to wait for garbage collection, this function may be used to free the object immediately, but note that an error will occur if you attempt to use the object after calling this function.
function Body:destroy() end

---Get the angle of the body.
---
---The angle is measured in radians. If you need to transform it to degrees, use math.deg.
---
---A value of 0 radians will mean "looking to the right". Although radians increase counter-clockwise, the y-axis points down so it becomes clockwise from our point of view.
---@return number
function Body:getAngle() end

---Gets the Angular damping of the Body
---
---The angular damping is the rate of decrease of the angular velocity over time: A spinning body with no damping and no external forces will continue spinning indefinitely. A spinning body with damping will gradually stop spinning.
---
---Damping is not the same as friction - they can be modelled together. However, only damping is provided by Box2D (and LÖVE).
---
---Damping parameters should be between 0 and infinity, with 0 meaning no damping, and infinity meaning full damping. Normally you will use a damping value between 0 and 0.1.
---@return number
function Body:getAngularDamping() end

---Get the angular velocity of the Body.
---
---The angular velocity is the rate of change of angle over time.
---
---It is changed in World:update by applying torques, off centre forces/impulses, and angular damping. It can be set directly with Body:setAngularVelocity.
---
---If you need the rate of change of position over time, use Body:getLinearVelocity.
---@return number
function Body:getAngularVelocity() end

---Gets a list of all Contacts attached to the Body.
---@return table
function Body:getContactList() end

---Returns a table with all fixtures.
---@return table
function Body:getFixtureList() end

---Returns the gravity scale factor.
---@return number
function Body:getGravityScale() end

---Gets the rotational inertia of the body.
---
---The rotational inertia is how hard is it to make the body spin.
---@return number
function Body:getInertia() end

---Returns a table containing the Joints attached to this Body.
---@return table
function Body:getJointList() end

---Gets the linear damping of the Body.
---
---The linear damping is the rate of decrease of the linear velocity over time. A moving body with no damping and no external forces will continue moving indefinitely, as is the case in space. A moving body with damping will gradually stop moving.
---
---Damping is not the same as friction - they can be modelled together. However, only damping is provided by Box2D (and LÖVE).
---@return number
function Body:getLinearDamping() end

---Gets the linear velocity of the Body from its center of mass.
---
---The linear velocity is the rate of change of position over time.
---
---If you need the rate of change of angle over time, use Body:getAngularVelocity. If you need to get the linear velocity of a point different from the center of mass:
---
---Body:getLinearVelocityFromLocalPoint allows you to specify the point in local coordinates.
---
---Body:getLinearVelocityFromWorldPoint allows you to specify the point in world coordinates.
---@return number, number
function Body:getLinearVelocity() end

---Get the linear velocity of a point on the body.
---
---The linear velocity for a point on the body is the velocity of the body center of mass plus the velocity at that point from the body spinning.
---
---The point on the body must given in local coordinates. Use Body:getLinearVelocityFromWorldPoint to specify this with world coordinates.
---@param x number @The x position to measure velocity.
---@param y number @The y position to measure velocity.
---@return number, number
function Body:getLinearVelocityFromLocalPoint(x, y) end

---Get the linear velocity of a point on the body.
---
---The linear velocity for a point on the body is the velocity of the body center of mass plus the velocity at that point from the body spinning.
---
---The point on the body must given in world coordinates. Use Body:getLinearVelocityFromLocalPoint to specify this with local coordinates.
---@param x number @The x position to measure velocity.
---@param y number @The y position to measure velocity.
---@return number, number
function Body:getLinearVelocityFromWorldPoint(x, y) end

---Get the center of mass position in local coordinates.
---
---Use Body:getWorldCenter to get the center of mass in world coordinates.
---@return number, number
function Body:getLocalCenter() end

---Transform a point from world coordinates to local coordinates.
---@param worldX number @The x position in world coordinates.
---@param worldY number @The y position in world coordinates.
---@return number, number
function Body:getLocalPoint(worldX, worldY) end

---Transform a vector from world coordinates to local coordinates.
---@param worldX number @The vector x component in world coordinates.
---@param worldY number @The vector y component in world coordinates.
---@return number, number
function Body:getLocalVector(worldX, worldY) end

---Get the mass of the body.
---@return number
function Body:getMass() end

---Returns the mass, its center, and the rotational inertia.
---@return number, number, number, number
function Body:getMassData() end

---Get the position of the body.
---
---Note that this may not be the center of mass of the body.
---@return number, number
function Body:getPosition() end

---Returns the type of the body.
---@return BodyType
function Body:getType() end

---Returns the Lua value associated with this Body.
---@return any
function Body:getUserData() end

---Gets the World the body lives in.
---@return World
function Body:getWorld() end

---Get the center of mass position in world coordinates.
---
---Use Body:getLocalCenter to get the center of mass in local coordinates.
---@return number, number
function Body:getWorldCenter() end

---Transform a point from local coordinates to world coordinates.
---@param localX number @The x position in local coordinates.
---@param localY number @The y position in local coordinates.
---@return number, number
function Body:getWorldPoint(localX, localY) end

---Transforms multiple points from local coordinates to world coordinates.
---@param x1 number @The x position of the first point.
---@param y1 number @The y position of the first point.
---@param x2 number @The x position of the second point.
---@param y2 number @The y position of the second point.
---@param ... number @More x and y points.
---@return number, number, number, number, number
function Body:getWorldPoints(x1, y1, x2, y2, ...) end

---Transform a vector from local coordinates to world coordinates.
---@param localX number @The vector x component in local coordinates.
---@param localY number @The vector y component in local coordinates.
---@return number, number
function Body:getWorldVector(localX, localY) end

---Get the x position of the body in world coordinates.
---@return number
function Body:getX() end

---Get the y position of the body in world coordinates.
---@return number
function Body:getY() end

---Returns whether the body is actively used in the simulation.
---@return boolean
function Body:isActive() end

---Returns the sleep status of the body.
---@return boolean
function Body:isAwake() end

---Get the bullet status of a body.
---
---There are two methods to check for body collisions:
---
---at their location when the world is updated (default)
---
---using continuous collision detection (CCD)
---
---The default method is efficient, but a body moving very quickly may sometimes jump over another body without producing a collision. A body that is set as a bullet will use CCD. This is less efficient, but is guaranteed not to jump when moving quickly.
---
---Note that static bodies (with zero mass) always use CCD, so your walls will not let a fast moving body pass through even if it is not a bullet.
---@return boolean
function Body:isBullet() end

---Gets whether the Body is destroyed. Destroyed bodies cannot be used.
---@return boolean
function Body:isDestroyed() end

---Returns whether the body rotation is locked.
---@return boolean
function Body:isFixedRotation() end

---Returns the sleeping behaviour of the body.
---@return boolean
function Body:isSleepingAllowed() end

---Resets the mass of the body by recalculating it from the mass properties of the fixtures.
function Body:resetMassData() end

---Sets whether the body is active in the world.
---
---An inactive body does not take part in the simulation. It will not move or cause any collisions.
---@param active boolean @If the body is active or not.
function Body:setActive(active) end

---Set the angle of the body.
---
---The angle is measured in radians. If you need to transform it from degrees, use math.rad.
---
---A value of 0 radians will mean "looking to the right". Although radians increase counter-clockwise, the y-axis points down so it becomes clockwise from our point of view.
---
---It is possible to cause a collision with another body by changing its angle.
---@param angle number @The angle in radians.
function Body:setAngle(angle) end

---Sets the angular damping of a Body.
---
---See Body:getAngularDamping for a definition of angular damping.
---
---Angular damping can take any value from 0 to infinity. It is recommended to stay between 0 and 0.1, though. Other values will look unrealistic.
---@param damping number @The new angular damping.
function Body:setAngularDamping(damping) end

---Sets the angular velocity of a Body.
---
---The angular velocity is the rate of change of angle over time.
---
---This function will not accumulate anything; any impulses previously applied since the last call to World:update will be lost.
---@param w number @The new angular velocity, in radians per second
function Body:setAngularVelocity(w) end

---Wakes the body up or puts it to sleep.
---@param awake boolean @The body sleep status.
function Body:setAwake(awake) end

---Set the bullet status of a body.
---
---There are two methods to check for body collisions:
---
---at their location when the world is updated (default)
---
---using continuous collision detection (CCD)
---
---The default method is efficient, but a body moving very quickly may sometimes jump over another body without producing a collision. A body that is set as a bullet will use CCD. This is less efficient, but is guaranteed not to jump when moving quickly.
---
---Note that static bodies (with zero mass) always use CCD, so your walls will not let a fast moving body pass through even if it is not a bullet.
---@param status boolean @The bullet status of the body.
function Body:setBullet(status) end

---Set whether a body has fixed rotation.
---
---Bodies with fixed rotation don't vary the speed at which they rotate.
---@param fixed boolean @Whether the body should have fixed rotation.
function Body:setFixedRotation(fixed) end

---Sets a new gravity scale factor for the body.
---@param scale number @The new gravity scale factor.
function Body:setGravityScale(scale) end

---Set the inertia of a body.
---@param inertia number @The new moment of inertia, in kilograms per meter squared.
function Body:setInertia(inertia) end

---Sets the linear damping of a Body
---
---See Body:getLinearDamping for a definition of linear damping.
---
---Linear damping can take any value from 0 to infinity. It is recommended to stay between 0 and 0.1, though. Other values will make the objects look "floaty".
---@param ld number @The new linear damping.
function Body:setLinearDamping(ld) end

---Sets a new linear velocity for the Body.
---
---This function will not accumulate anything; any impulses previously applied since the last call to World:update will be lost.
---@param x number @The x component of the velocity vector.
---@param y number @The y component of the velocity vector.
function Body:setLinearVelocity(x, y) end

---Sets the mass in kilograms.
---@param mass number @The mass, in kilograms.
function Body:setMass(mass) end

---Overrides the calculated mass data.
---@param x number @The x component of the center of mass in local coordinates.
---@param y number @The y component of the center of mass in local coordinates.
---@param mass number @The mass, in kilograms.
---@param inertia number @The rotational inertia, in kilograms per squared meter.
function Body:setMassData(x, y, mass, inertia) end

---Set the position of the body.
---
---Note that this may not be the center of mass of the body.
---@param x number @The x position.
---@param y number @The y position.
function Body:setPosition(x, y) end

---Sets the sleeping behaviour of the body.
---@param allowed boolean @True if the body is allowed to sleep or false if not.
function Body:setSleepingAllowed(allowed) end

---Sets a new body type.
---@param type BodyType @The new type.
function Body:setType(type) end

---Associates a Lua value with the Body.
---
---To delete the reference, explicitly pass nil.
---@param value any @The Lua value to associate with the Body.
function Body:setUserData(value) end

---Set the x position of the body.
---@param x number @The x position.
function Body:setX(x) end

---Set the y position of the body.
---@param y number @The y position.
function Body:setY(y) end

--endregion Body
--region ChainShape
---@class ChainShape : Shape
---A ChainShape consists of multiple line segments. It can be used to create the boundaries of your terrain. The shape does not have volume and can only collide with PolygonShape and CircleShape.
---
---Unlike the PolygonShape, the ChainShape does not have a vertices limit or has to form a convex shape, but self intersections are not supported.
local ChainShape = {}
---Returns a child of the shape as an EdgeShape.
---@param index number @The index of the child.
---@return number
function ChainShape:getChildEdge(index) end

---Gets the vertex that establishes a connection to the next shape.
---
---Setting next and previous ChainShape vertices can help prevent unwanted collisions when a flat shape slides along the edge and moves over to the new shape.
---@param x number @The x-component of the vertex, or nil if ChainShape:setNextVertex hasn't been called.
---@param y number @The y-component of the vertex, or nil if ChainShape:setNextVertex hasn't been called.
function ChainShape:getNextVertex(x, y) end

---Returns a point of the shape.
---@param index number @The index of the point to return.
---@return number, number
function ChainShape:getPoint(index) end

---Returns all points of the shape.
---@return number, number, number, number, number
function ChainShape:getPoints() end

---Gets the vertex that establishes a connection to the previous shape.
---
---Setting next and previous ChainShape vertices can help prevent unwanted collisions when a flat shape slides along the edge and moves over to the new shape.
---@return number, number
function ChainShape:getPreviousVertex() end

---Returns the number of vertices the shape has.
---@return number
function ChainShape:getVertexCount() end

---Sets a vertex that establishes a connection to the next shape.
---
---This can help prevent unwanted collisions when a flat shape slides along the edge and moves over to the new shape.
---@param x number @The x component of the vertex.
---@param y number @The y component of the vertex.
function ChainShape:setNextVertex(x, y) end

---Sets a vertex that establishes a connection to the previous shape.
---
---This can help prevent unwanted collisions when a flat shape slides along the edge and moves over to the new shape.
---@param x number @The x component of the vertex.
---@param y number @The y component of the vertex.
function ChainShape:setPreviousVertex(x, y) end

--endregion ChainShape
--region CircleShape
---@class CircleShape : Shape
---Circle extends Shape and adds a radius and a local position.
local CircleShape = {}
---Gets the center point of the circle shape.
---@return number, number
function CircleShape:getPoint() end

---Gets the radius of the circle shape.
---@return number
function CircleShape:getRadius() end

---Sets the location of the center of the circle shape.
---@param x number @The x-component of the new center point of the circle.
---@param y number @The y-component of the new center point of the circle.
function CircleShape:setPoint(x, y) end

---Sets the radius of the circle.
---@param radius number @The radius of the circle.
function CircleShape:setRadius(radius) end

--endregion CircleShape
--region Contact
---@class Contact : Object
---Contacts are objects created to manage collisions in worlds.
local Contact = {}
---Gets the two Fixtures that hold the shapes that are in contact.
---@return Fixture, Fixture
function Contact:getFixtures() end

---Get the friction between two shapes that are in contact.
---@return number
function Contact:getFriction() end

---Get the normal vector between two shapes that are in contact.
---
---This function returns the coordinates of a unit vector that points from the first shape to the second.
---@return number, number
function Contact:getNormal() end

---Returns the contact points of the two colliding fixtures. There can be one or two points.
---@return number, number, number, number
function Contact:getPositions() end

---Get the restitution between two shapes that are in contact.
---@return number
function Contact:getRestitution() end

---Returns whether the contact is enabled. The collision will be ignored if a contact gets disabled in the preSolve callback.
---@return boolean
function Contact:isEnabled() end

---Returns whether the two colliding fixtures are touching each other.
---@return boolean
function Contact:isTouching() end

---Resets the contact friction to the mixture value of both fixtures.
function Contact:resetFriction() end

---Resets the contact restitution to the mixture value of both fixtures.
function Contact:resetRestitution() end

---Enables or disables the contact.
---@param enabled boolean @True to enable or false to disable.
function Contact:setEnabled(enabled) end

---Sets the contact friction.
---@param friction number @The contact friction.
function Contact:setFriction(friction) end

---Sets the contact restitution.
---@param restitution number @The contact restitution.
function Contact:setRestitution(restitution) end

--endregion Contact
--region EdgeShape
---@class EdgeShape : Shape
---A EdgeShape is a line segment. They can be used to create the boundaries of your terrain. The shape does not have volume and can only collide with PolygonShape and CircleShape.
local EdgeShape = {}
---Returns the local coordinates of the edge points.
---@return number, number, number, number
function EdgeShape:getPoints() end

---Gets the vertex that establishes a connection to the next shape.
---
---Setting next and previous EdgeShape vertices can help prevent unwanted collisions when a flat shape slides along the edge and moves over to the new shape.
---@return number, number
function EdgeShape:getNextVertex() end

---Gets the vertex that establishes a connection to the previous shape.
---
---Setting next and previous EdgeShape vertices can help prevent unwanted collisions when a flat shape slides along the edge and moves over to the new shape.
---@return number, number
function EdgeShape:getPreviousVertex() end

---Sets a vertex that establishes a connection to the next shape.
---
---This can help prevent unwanted collisions when a flat shape slides along the edge and moves over to the new shape.
---@param x number @The x-component of the vertex.
---@param y number @The y-component of the vertex.
function EdgeShape:setNextVertex(x, y) end

---Sets a vertex that establishes a connection to the previous shape.
---
---This can help prevent unwanted collisions when a flat shape slides along the edge and moves over to the new shape.
---@param x number @The x-component of the vertex.
---@param y number @The y-component of the vertex.
function EdgeShape:setPreviousVertex(x, y) end

--endregion EdgeShape
--region DistanceJoint
---@class DistanceJoint : Joint
---Keeps two bodies at the same distance.
local DistanceJoint = {}
---Gets the damping ratio.
---@return number
function DistanceJoint:getDampingRatio() end

---Gets the response speed.
---@return number
function DistanceJoint:getFrequency() end

---Gets the equilibrium distance between the two Bodies.
---@return number
function DistanceJoint:getLength() end

---Sets the damping ratio.
---@param ratio number @The damping ratio.
function DistanceJoint:setDampingRatio(ratio) end

---Sets the response speed.
---@param Hz number @The response speed.
function DistanceJoint:setFrequency(Hz) end

---Sets the equilibrium distance between the two Bodies.
---@param l number @The length between the two Bodies.
function DistanceJoint:setLength(l) end

--endregion DistanceJoint
--region Fixture
---@class Fixture : Object
---Fixtures attach shapes to bodies.
local Fixture = {}
---Destroys the fixture
function Fixture:destroy() end

---Returns the body to which the fixture is attached.
---@return Body
function Fixture:getBody() end

---Returns the points of the fixture bounding box. In case the fixture has multiple children a 1-based index can be specified. For example, a fixture will have multiple children with a chain shape.
---@param index number @A bounding box of the fixture.
---@return number, number, number, number
function Fixture:getBoundingBox(index) end

---Returns the categories the fixture belongs to.
---@return number, number, number
function Fixture:getCategory() end

---Returns the density of the fixture.
---@return number
function Fixture:getDensity() end

---Returns the filter data of the fixture. Categories and masks are encoded as the bits of a 16-bit integer.
---@return number, number, number
function Fixture:getFilterData() end

---Returns the friction of the fixture.
---@return number
function Fixture:getFriction() end

---Returns the group the fixture belongs to. Fixtures with the same group will always collide if the group is positive or never collide if it's negative. The group zero means no group.
---
---The groups range from -32768 to 32767.
---@return number
function Fixture:getGroupIndex() end

---Returns the category mask of the fixture.
---@return number, number, number
function Fixture:getMask() end

---Returns the mass, its center and the rotational inertia.
---@return number, number, number, number
function Fixture:getMassData() end

---Returns the restitution of the fixture.
---@return number
function Fixture:getRestitution() end

---Returns the shape of the fixture. This shape is a reference to the actual data used in the simulation. It's possible to change its values between timesteps.
---
---Do not call any functions on this shape after the parent fixture has been destroyed. This shape will point to an invalid memory address and likely cause crashes if you interact further with it.
---@return Shape
function Fixture:getShape() end

---Returns the Lua value associated with this fixture.
---
---Use this function in one thread only.
---@return any
function Fixture:getUserData() end

---Gets whether the Fixture is destroyed. Destroyed fixtures cannot be used.
---@return boolean
function Fixture:isDestroyed() end

---Returns whether the fixture is a sensor.
---@return boolean
function Fixture:isSensor() end

---Casts a ray against the shape of the fixture and returns the surface normal vector and the line position where the ray hit. If the ray missed the shape, nil will be returned.
---
---The ray starts on the first point of the input line and goes towards the second point of the line. The fourth argument is the maximum distance the ray is going to travel as a scale factor of the input line length.
---
---The childIndex parameter is used to specify which child of a parent shape, such as a ChainShape, will be ray casted. For ChainShapes, the index of 1 is the first edge on the chain. Ray casting a parent shape will only test the child specified so if you want to test every shape of the parent, you must loop through all of its children.
---
---The world position of the impact can be calculated by multiplying the line vector with the third return value and adding it to the line starting point.
---
---hitx, hity = x1 + (x2 - x1) * fraction, y1 + (y2 - y1) * fraction
---@param x1 number @The x position of the ray starting point.
---@param y1 number @The y position of the ray starting point.
---@param x2 number @The x position of the ray end point.
---@param y1 number @The y position of the ray end point.
---@param maxFraction number @The maximum distance the ray is going to travel as a number from 0 to 1.
---@param childIndex number @The index of the child the ray gets cast against.
---@return number, number, number
function Fixture:rayCast(x1, y1, x2, y1, maxFraction, childIndex) end

---Sets the categories the fixture belongs to. There can be up to 16 categories represented as a number from 1 to 16.
---@param category1 number @The first category.
---@param category2 number @The second category.
---@param ... number @Additional categories.
function Fixture:setCategory(category1, category2, ...) end

---Sets the density of the fixture. Call Body:resetMassData if this needs to take effect immediately.
---@param density number @The fixture density in kilograms per square meter.
function Fixture:setDensity(density) end

---Sets the filter data of the fixture.
---
---Groups, categories, and mask can be used to define the collision behaviour of the fixture.
---
---If two fixtures are in the same group they either always collide if the group is positive, or never collide if it's negative. If the group is zero or they do not match, then the contact filter checks if the fixtures select a category of the other fixture with their masks. The fixtures do not collide if that's not the case. If they do have each other's categories selected, the return value of the custom contact filter will be used. They always collide if none was set.
---
---There can be up to 16 categories. Categories and masks are encoded as the bits of a 16-bit integer.
---@param categories number @The categories as an integer from 0 to 65535.
---@param mask number @The mask as an integer from 0 to 65535.
---@param group number @The group as an integer from -32768 to 32767.
function Fixture:setFilterData(categories, mask, group) end

---Sets the friction of the fixture.
---@param friction number @The fixture friction.
function Fixture:setFriction(friction) end

---Sets the group the fixture belongs to. Fixtures with the same group will always collide if the group is positive or never collide if it's negative. The group zero means no group.
---
---The groups range from -32768 to 32767.
---@param group number @The group as an integer from -32768 to 32767.
function Fixture:setGroupIndex(group) end

---Sets the category mask of the fixture. There can be up to 16 categories represented as a number from 1 to 16.
---
---This fixture will collide with the fixtures that are in the selected categories if the other fixture also has a category of this fixture selected.
---@param mask1 number @The first category.
---@param mask2 number @The second category.
---@param ... number @Additional categories.
function Fixture:setMask(mask1, mask2, ...) end

---Sets the restitution of the fixture.
---@param restitution number @The fixture restitution.
function Fixture:setRestitution(restitution) end

---Sets whether the fixture should act as a sensor.
---
---Sensor do not produce collisions responses, but the begin and end callbacks will still be called for this fixture.
---@param sensor boolean @The sensor status.
function Fixture:setSensor(sensor) end

---Associates a Lua value with the fixture.
---
---Use this function in one thread only.
---@param value any @The Lua value associated with the fixture.
function Fixture:setUserData(value) end

---Checks if a point is inside the shape of the fixture.
---@param x number @The x position of the point.
---@param y number @The y position of the point.
---@return boolean
function Fixture:testPoint(x, y) end

--endregion Fixture
--region FrictionJoint
---@class FrictionJoint : Joint
---A FrictionJoint applies friction to a body.
local FrictionJoint = {}
---Gets the maximum friction force in Newtons.
---@return number
function FrictionJoint:getMaxForce() end

---Gets the maximum friction torque in Newton-meters.
---@return number
function FrictionJoint:getMaxTorque() end

---Sets the maximum friction force in Newtons.
---@param maxForce number @Max force in Newtons.
function FrictionJoint:setMaxForce(maxForce) end

---Sets the maximum friction torque in Newton-meters.
---@param torque number @Maximum torque in Newton-meters.
function FrictionJoint:setMaxTorque(torque) end

--endregion FrictionJoint
--region GearJoint
---@class GearJoint : Joint
---Keeps bodies together in such a way that they act like gears.
local GearJoint = {}
---Get the Joints connected by this GearJoint.
---@return Joint, Joint
function GearJoint:getJoints() end

---Get the ratio of a gear joint.
---@return number
function GearJoint:getRatio() end

---Set the ratio of a gear joint.
---@param ratio number @The new ratio of the joint.
function GearJoint:setRatio(ratio) end

--endregion GearJoint
--region Joint
---@class Joint : Object
---Attach multiple bodies together to interact in unique ways.
local Joint = {}
---Explicitly destroys the Joint. When you don't have time to wait for garbage collection, this function may be used to free the object immediately, but note that an error will occur if you attempt to use the object after calling this function.
function Joint:destroy() end

---Get the anchor points of the joint.
---@return number, number, number, number
function Joint:getAnchors() end

---Gets the bodies that the Joint is attached to.
---@return Body, Body
function Joint:getBodies() end

---Gets whether the connected Bodies collide.
---@return boolean
function Joint:getCollideConnected() end

---Gets the reaction force on Body 2 at the joint anchor.
---@return number, number
function Joint:getReactionForce() end

---Returns the reaction torque on the second body.
---@param invdt number @How long the force applies. Usually the inverse time step or 1/dt.
---@return number
function Joint:getReactionTorque(invdt) end

---Gets a string representing the type.
---@return JointType
function Joint:getType() end

---Returns the Lua value associated with this Joint.
---@return any
function Joint:getUserData() end

---Gets whether the Joint is destroyed. Destroyed joints cannot be used.
---@return boolean
function Joint:isDestroyed() end

---Associates a Lua value with the Joint.
---
---To delete the reference, explicitly pass nil.
---@param value any @The Lua value to associate with the Joint.
function Joint:setUserData(value) end

--endregion Joint
--region MotorJoint
---@class MotorJoint : Joint
---Controls the relative motion between two Bodies. Position and rotation offsets can be specified, as well as the maximum motor force and torque that will be applied to reach the target offsets.
local MotorJoint = {}
---Gets the target angular offset between the two Bodies the Joint is attached to.
---@return number
function MotorJoint:getAngularOffset() end

---Gets the target linear offset between the two Bodies the Joint is attached to.
---@return number, number
function MotorJoint:getLinearOffset() end

---Sets the target angluar offset between the two Bodies the Joint is attached to.
---@param angularoffset number @The target angular offset in radians: the second body's angle minus the first body's angle.
function MotorJoint:setAngularOffset(angularoffset) end

---Sets the target linear offset between the two Bodies the Joint is attached to.
---@param x number @The x component of the target linear offset, relative to the first Body.
---@param y number @The y component of the target linear offset, relative to the first Body.
function MotorJoint:setLinearOffset(x, y) end

--endregion MotorJoint
--region MouseJoint
---@class MouseJoint : Joint
---For controlling objects with the mouse.
local MouseJoint = {}
---Returns the damping ratio.
---@return number
function MouseJoint:getDampingRatio() end

---Returns the frequency.
---@return number
function MouseJoint:getFrequency() end

---Gets the highest allowed force.
---@return number
function MouseJoint:getMaxForce() end

---Gets the target point.
---@return number, number
function MouseJoint:getTarget() end

---Sets a new damping ratio.
---@param ratio number @The new damping ratio.
function MouseJoint:setDampingRatio(ratio) end

---Sets a new frequency.
---@param freq number @The new frequency in hertz.
function MouseJoint:setFrequency(freq) end

---Sets the highest allowed force.
---@param f number @The max allowed force.
function MouseJoint:setMaxForce(f) end

---Sets the target point.
---@param x number @The x component of the target.
---@param y number @The y component of the target.
function MouseJoint:setTarget(x, y) end

--endregion MouseJoint
--region PolygonShape
---@class PolygonShape : Shape
---Polygon is a convex polygon with up to 8 sides.
local PolygonShape = {}
---Get the local coordinates of the polygon's vertices.
---
---This function has a variable number of return values. It can be used in a nested fashion with love.graphics.polygon.
---
---This function may have up to 16 return values, since it returns two values for each vertex in the polygon. In other words, it can return the coordinates of up to 8 points.
---@return number, number, number, number, number
function PolygonShape:getPoints() end

--endregion PolygonShape
--region PrismaticJoint
---@class PrismaticJoint : Joint
---Restricts relative motion between Bodies to one shared axis.
local PrismaticJoint = {}
---Gets the world-space axis vector of the Prismatic Joint.
---@return number, number
function PrismaticJoint:getAxis() end

---Get the current joint angle speed.
---@return number
function PrismaticJoint:getJointSpeed() end

---Get the current joint translation.
---@return number
function PrismaticJoint:getJointTranslation() end

---Gets the joint limits.
---@return number, number
function PrismaticJoint:getLimits() end

---Gets the lower limit.
---@return number
function PrismaticJoint:getLowerLimit() end

---Gets the maximum motor force.
---@return number
function PrismaticJoint:getMaxMotorForce() end

---Get the current motor force.
---@return number
function PrismaticJoint:getMotorForce() end

---Gets the motor speed.
---@return number
function PrismaticJoint:getMotorSpeed() end

---Gets the upper limit.
---@return number
function PrismaticJoint:getUpperLimit() end

---Checks whether the limits are enabled.
---@return boolean
function PrismaticJoint:hasLimitsEnabled() end

---Checks whether the motor is enabled.
---@return boolean
function PrismaticJoint:isMotorEnabled() end

---Sets the limits.
---@param lower number @The lower limit, usually in meters.
---@param upper number @The upper limit, usually in meters.
function PrismaticJoint:setLimits(lower, upper) end

---Enables or disables the limits of the joint.
---@param enable boolean @True to enable, false to disable.
function PrismaticJoint:setLimitsEnabled(enable) end

---Sets the lower limit.
---@param lower number @The lower limit, usually in meters.
function PrismaticJoint:setLowerLimit(lower) end

---Set the maximum motor force.
---@param f number @The maximum motor force, usually in N.
function PrismaticJoint:setMaxMotorForce(f) end

---Starts or stops the joint motor.
---@param enable boolean @True to enable, false to disable.
function PrismaticJoint:setMotorEnabled(enable) end

---Sets the motor speed.
---@param s number @The motor speed, usually in meters per second.
function PrismaticJoint:setMotorSpeed(s) end

---Sets the upper limit.
---@param upper number @The upper limit, usually in meters.
function PrismaticJoint:setUpperLimit(upper) end

--endregion PrismaticJoint
--region PulleyJoint
---@class PulleyJoint : Joint
---Allows you to simulate bodies connected through pulleys.
local PulleyJoint = {}
---Get the total length of the rope.
---@return number
function PulleyJoint:getConstant() end

---Get the ground anchor positions in world coordinates.
---@return number, number, number, number
function PulleyJoint:getGroundAnchors() end

---Get the current length of the rope segment attached to the first body.
---@return number
function PulleyJoint:getLengthA() end

---Get the current length of the rope segment attached to the second body.
---@return number
function PulleyJoint:getLengthB() end

---Get the maximum lengths of the rope segments.
---@return number, number
function PulleyJoint:getMaxLengths() end

---Get the pulley ratio.
---@return number
function PulleyJoint:getRatio() end

---Set the total length of the rope.
---
---Setting a new length for the rope updates the maximum length values of the joint.
---@param length number @The new length of the rope in the joint.
function PulleyJoint:setConstant(length) end

---Set the maximum lengths of the rope segments.
---
---The physics module also imposes maximum values for the rope segments. If the parameters exceed these values, the maximum values are set instead of the requested values.
---@param max1 number @The new maximum length of the first segment.
---@param max2 number @The new maximum length of the second segment.
function PulleyJoint:setMaxLengths(max1, max2) end

---Set the pulley ratio.
---@param ratio number @The new pulley ratio of the joint.
function PulleyJoint:setRatio(ratio) end

--endregion PulleyJoint
--region RevoluteJoint
---@class RevoluteJoint : Joint
---Allow two Bodies to revolve around a shared point.
local RevoluteJoint = {}
---Enables or disables the joint limits.
---@param enable boolean @True to enable, false to disable.
function RevoluteJoint:setLimitsEnabled(enable) end

---Starts or stops the joint motor.
---@param enable boolean @True to enable, false to disable.
function RevoluteJoint:setMotorEnabled(enable) end

---Get the current joint angle.
---@return number
function RevoluteJoint:getJointAngle() end

---Get the current joint angle speed.
---@return number
function RevoluteJoint:getJointSpeed() end

---Gets the joint limits.
---@return number, number
function RevoluteJoint:getLimits() end

---Gets the lower limit.
---@return number
function RevoluteJoint:getLowerLimit() end

---Gets the maximum motor force.
---@return number
function RevoluteJoint:getMaxMotorTorque() end

---Gets the motor speed.
---@return number
function RevoluteJoint:getMotorSpeed() end

---Get the current motor force.
---@return number
function RevoluteJoint:getMotorTorque() end

---Gets the upper limit.
---@return number
function RevoluteJoint:getUpperLimit() end

---Checks whether limits are enabled.
---@return boolean
function RevoluteJoint:hasLimitsEnabled() end

---Checks whether the motor is enabled.
---@return boolean
function RevoluteJoint:isMotorEnabled() end

---Sets the limits.
---@param lower number @The lower limit, in radians.
---@param upper number @The upper limit, in radians.
function RevoluteJoint:setLimits(lower, upper) end

---Sets the lower limit.
---@param lower number @The lower limit, in radians.
function RevoluteJoint:setLowerLimit(lower) end

---Set the maximum motor force.
---@param f number @The maximum motor force, in Nm.
function RevoluteJoint:setMaxMotorTorque(f) end

---Sets the motor speed.
---@param s number @The motor speed, radians per second.
function RevoluteJoint:setMotorSpeed(s) end

---Sets the upper limit.
---@param upper number @The upper limit, in radians.
function RevoluteJoint:setUpperLimit(upper) end

--endregion RevoluteJoint
--region RopeJoint
---@class RopeJoint : Joint
---The RopeJoint enforces a maximum distance between two points on two bodies. It has no other effect.
local RopeJoint = {}
---Gets the maximum length of a RopeJoint.
---@return number
function RopeJoint:getMaxLength() end

--endregion RopeJoint
--region Shape
---@class Shape : Object
---Shapes are solid 2d geometrical objects used in love.physics.
---
---Shapes are attached to a Body via a Fixture. The Shape object is copied when this happens. Shape position is relative to Body position.
local Shape = {}
---Returns the points of the bounding box for the transformed shape.
---@param tx number @The translation of the shape on the x-axis.
---@param ty number @The translation of the shape on the y-axis.
---@param tr number @The shape rotation.
---@param childIndex number @The index of the child to compute the bounding box of.
---@return number, number, number, number
function Shape:computeAABB(tx, ty, tr, childIndex) end

---Computes the mass properties for the shape with the specified density.
---@param density number @The shape density.
---@return number, number, number, number
function Shape:computeMass(density) end

---Returns the number of children the shape has.
---@return number
function Shape:getChildCount() end

---Gets the radius of the shape.
---@return number
function Shape:getRadius() end

---Gets a string representing the Shape. This function can be useful for conditional debug drawing.
---@return ShapeType
function Shape:getType() end

---Casts a ray against the shape and returns the surface normal vector and the line position where the ray hit. If the ray missed the shape, nil will be returned. The Shape can be transformed to get it into the desired position.
---
---The ray starts on the first point of the input line and goes towards the second point of the line. The fourth argument is the maximum distance the ray is going to travel as a scale factor of the input line length.
---
---The childIndex parameter is used to specify which child of a parent shape, such as a ChainShape, will be ray casted. For ChainShapes, the index of 1 is the first edge on the chain. Ray casting a parent shape will only test the child specified so if you want to test every shape of the parent, you must loop through all of its children.
---
---The world position of the impact can be calculated by multiplying the line vector with the third return value and adding it to the line starting point.
---
---hitx, hity = x1 + (x2 - x1) * fraction, y1 + (y2 - y1) * fraction
---@param x1 number @The x position of the input line starting point.
---@param y1 number @The y position of the input line starting point.
---@param x2 number @The x position of the input line end point.
---@param y2 number @The y position of the input line end point.
---@param maxFraction number @Ray length parameter.
---@param tx number @The translation of the shape on the x-axis.
---@param ty number @The translation of the shape on the y-axis.
---@param tr number @The shape rotation.
---@param childIndex number @The index of the child the ray gets cast against.
---@return number, number, number
function Shape:rayCast(x1, y1, x2, y2, maxFraction, tx, ty, tr, childIndex) end

---Checks whether a point lies inside the shape. This is particularly useful for mouse interaction with the shapes. By looping through all shapes and testing the mouse position with this function, we can find which shapes the mouse touches.
---@param x number @The x component of the point.
---@param y number @The y component of the point.
---@return boolean
function Shape:testPoint(x, y) end

--endregion Shape
--region WeldJoint
---@class WeldJoint : Joint
---A WeldJoint essentially glues two bodies together.
local WeldJoint = {}
---Returns the damping ratio of the joint.
---@return number
function WeldJoint:getDampingRatio() end

---Returns the frequency.
---@return number
function WeldJoint:getFrequency() end

---The new damping ratio.
---@param ratio number @The new damping ratio.
function WeldJoint:setDampingRatio(ratio) end

---Sets a new frequency.
---@param freq number @The new frequency in hertz.
function WeldJoint:setFrequency(freq) end

--endregion WeldJoint
--region WheelJoint
---@class WheelJoint : Joint
---Restricts a point on the second body to a line on the first body.
local WheelJoint = {}
---Gets the world-space axis vector of the Wheel Joint.
---@return number, number
function WheelJoint:getAxis() end

---Returns the current joint translation speed.
---@return number
function WheelJoint:getJointSpeed() end

---Returns the current joint translation.
---@return number
function WheelJoint:getJointTranslation() end

---Returns the maximum motor torque.
---@return number
function WheelJoint:getMaxMotorTorque() end

---Returns the speed of the motor.
---@return number
function WheelJoint:getMotorSpeed() end

---Returns the current torque on the motor.
---@param invdt number @How long the force applies. Usually the inverse time step or 1/dt.
---@return number
function WheelJoint:getMotorTorque(invdt) end

---Returns the damping ratio.
---@return number
function WheelJoint:getSpringDampingRatio() end

---Returns the spring frequency.
---@return number
function WheelJoint:getSpringFrequency() end

---Sets a new maximum motor torque.
---@param maxTorque number @The new maximum torque for the joint motor in newton meters.
function WheelJoint:setMaxMotorTorque(maxTorque) end

---Starts and stops the joint motor.
---@param enable boolean @True turns the motor on and false turns it off.
function WheelJoint:setMotorEnabled(enable) end

---Sets a new speed for the motor.
---@param speed number @The new speed for the joint motor in radians per second.
function WheelJoint:setMotorSpeed(speed) end

---Sets a new damping ratio.
---@param ratio number @The new damping ratio.
function WheelJoint:setSpringDampingRatio(ratio) end

---Sets a new spring frequency.
---@param freq number @The new frequency in hertz.
function WheelJoint:setSpringFrequency(freq) end

--endregion WheelJoint
--region World
---@class World : Object
---A world is an object that contains all bodies and joints.
local World = {}
---Destroys the world, taking all bodies, joints, fixtures and their shapes with it.
---
---An error will occur if you attempt to use any of the destroyed objects after calling this function.
function World:destroy() end

---Get the number of bodies in the world.
---@return number
function World:getBodyCount() end

---Returns a table with all bodies.
---@return table
function World:getBodyList() end

---Returns functions for the callbacks during the world update.
---@return function, function, function, function
function World:getCallbacks() end

---Returns the number of contacts in the world.
---@return number
function World:getContactCount() end

---Returns the function for collision filtering.
---@return function
function World:getContactFilter() end

---Returns a table with all contacts.
---@return table
function World:getContactList() end

---Get the gravity of the world.
---@return number, number
function World:getGravity() end

---Get the number of joints in the world.
---@return number
function World:getJointCount() end

---Returns a table with all joints.
---@return table
function World:getJointList() end

---Gets whether the World is destroyed. Destroyed worlds cannot be used.
---@return boolean
function World:isDestroyed() end

---Returns if the world is updating its state.
---
---This will return true inside the callbacks from World:setCallbacks.
---@return boolean
function World:isLocked() end

---Returns the sleep behaviour of the world.
---@return boolean
function World:isSleepingAllowed() end

---Calls a function for each fixture inside the specified area.
---@param topLeftX number @The x position of the top-left point.
---@param topLeftY number @The y position of the top-left point.
---@param bottomRightX number @The x position of the bottom-right point.
---@param bottomRightY number @The y position of the bottom-right point.
---@param callback function @This function gets passed one argument, the fixture, and should return a boolean. The search will continue if it is true or stop if it is false.
function World:queryBoundingBox(topLeftX, topLeftY, bottomRightX, bottomRightY, callback) end

---Casts a ray and calls a function for each fixtures it intersects.
---@param x1 number @The x position of the starting point of the ray.
---@param y1 number @The y position of the starting point of the ray.
---@param x2 number @The x position of the end point of the ray.
---@param y2 number @The y position of the end point of the ray.
---@param callback function @This function gets six arguments and should return a number.
function World:rayCast(x1, y1, x2, y2, callback) end

---Sets functions for the collision callbacks during the world update.
---
---Four Lua functions can be given as arguments. The value nil removes a function.
---
---When called, each function will be passed three arguments. The first two arguments are the colliding fixtures and the third argument is the Contact between them. The PostSolve callback additionally gets the normal and tangent impulse for each contact point.
---@param beginContact function @Gets called when two fixtures begin to overlap. 
---@param endContact function @Gets called when two fixtures cease to overlap.
---@param preSolve function @Gets called before a collision gets resolved.
---@param postSolve function @Gets called after the collision has been resolved.
function World:setCallbacks(beginContact, endContact, preSolve, postSolve) end

---Sets a function for collision filtering.
---
---If the group and category filtering doesn't generate a collision decision, this function gets called with the two fixtures as arguments. The function should return a boolean value where true means the fixtures will collide and false means they will pass through each other.
---@param filter function @The function handling the contact filtering.
function World:setContactFilter(filter) end

---Set the gravity of the world.
---@param x number @The x component of gravity.
---@param y number @The y component of gravity.
function World:setGravity(x, y) end

---Set the sleep behaviour of the world.
---
---A sleeping body is much more efficient to simulate than when awake.
---
---If sleeping is allowed, any body that has come to rest will sleep.
---@param allowSleep boolean @True if the bodies are allowed to sleep or false if not.
function World:setSleepingAllowed(allowSleep) end

---Translates the World's origin. Useful in large worlds where floating point precision issues become noticeable at far distances from the origin.
---@param x number @The x component of the new origin with respect to the old origin.
---@param y number @The y component of the new origin with respect to the old origin.
function World:translateOrigin(x, y) end

---Update the state of the world.
---@param dt number @The time (in seconds) to advance the physics simulation.
function World:update(dt) end

--endregion World
---The types of a Body.
BodyType = {
	---Static bodies do not move.
	['static'] = 1,
	---Dynamic bodies collide with all bodies.
	['dynamic'] = 2,
	---Kinematic bodies only collide with dynamic bodies.
	['kinematic'] = 3,
}
---Different types of joints.
JointType = {
	---A DistanceJoint.
	['distance'] = 1,
	---A GearJoint.
	['gear'] = 2,
	---A MouseJoint.
	['mouse'] = 3,
	---A PrismaticJoint.
	['prismatic'] = 4,
	---A PulleyJoint.
	['pulley'] = 5,
	---A RevoluteJoint.
	['revolute'] = 6,
	---A FrictionJoint.
	['friction'] = 7,
	---A WeldJoint.
	['weld'] = 8,
	---A RopeJoint.
	['rope'] = 9,
}
---The different types of Shapes, as returned by Shape:getType.
ShapeType = {
	---The Shape is a CircleShape.
	['circle'] = 1,
	---The Shape is a PolygonShape.
	['polygon'] = 2,
	---The Shape is a EdgeShape.
	['edge'] = 3,
	---The Shape is a ChainShape.
	['chain'] = 4,
}
---Returns the two closest points between two fixtures and their distance.
---@param fixture1 Fixture @The first fixture.
---@param fixture2 Fixture @The second fixture.
---@return number, number, number, number, number
function m.getDistance(fixture1, fixture2) end

---Get the scale of the world.
---
---The world scale is the number of pixels per meter. Try to keep your shape sizes less than 10 times this scale.
---
---This is important because the physics in Box2D is tuned to work well for objects of size 0.1m up to 10m. All physics coordinates are divided by this number for the physics calculations.
---@return number
function m.getMeter() end

---Creates a new body.
---
---There are three types of bodies. Static bodies do not move, have a infinite mass, and can be used for level boundaries. Dynamic bodies are the main actors in the simulation, they collide with everything. Kinematic bodies do not react to forces and only collide with dynamic bodies.
---
---The mass of the body gets calculated when a Fixture is attached or removed, but can be changed at any time with Body:setMass or Body:resetMassData.
---@param world World @The world to create the body in.
---@param x number @The x position of the body.
---@param y number @The y position of the body.
---@param type BodyType @The type of the body.
---@return Body
function m.newBody(world, x, y, type) end

---Creates a new ChainShape.
---@param loop boolean @If the chain should loop back to the first point.
---@param x1 number @The x position of the first point.
---@param y1 number @The y position of the first point.
---@param x2 number @The x position of the second point.
---@param y2 number @The y position of the second point.
---@param ... number @Additional point positions.
---@return ChainShape
---@overload fun(loop:boolean, points:table):ChainShape
function m.newChainShape(loop, x1, y1, x2, y2, ...) end

---Creates a new CircleShape.
---@param radius number @The radius of the circle.
---@return CircleShape
---@overload fun(x:number, y:number, radius:number):CircleShape
function m.newCircleShape(radius) end

---Create a distance joint between two bodies.
---
---This joint constrains the distance between two points on two bodies to be constant. These two points are specified in world coordinates and the two bodies are assumed to be in place when this joint is created. The first anchor point is connected to the first body and the second to the second body, and the points define the length of the distance joint.
---@param body1 Body @The first body to attach to the joint.
---@param body2 Body @The second body to attach to the joint.
---@param x1 number @The x position of the first anchor point (world space).
---@param y1 number @The y position of the first anchor point (world space).
---@param x2 number @The x position of the second anchor point (world space).
---@param y2 number @The y position of the second anchor point (world space).
---@param collideConnected boolean @Specifies whether the two bodies should collide with each other.
---@return DistanceJoint
function m.newDistanceJoint(body1, body2, x1, y1, x2, y2, collideConnected) end

---Creates a edge shape.
---@param x1 number @The x position of the first point.
---@param y1 number @The y position of the first point.
---@param x2 number @The x position of the second point.
---@param y2 number @The y position of the second point.
---@return EdgeShape
function m.newEdgeShape(x1, y1, x2, y2) end

---Creates and attaches a Fixture to a body.
---@param body Body @The body which gets the fixture attached.
---@param shape Shape @The shape of the fixture.
---@param density number @The density of the fixture.
---@return Fixture
function m.newFixture(body, shape, density) end

---Create a friction joint between two bodies. A FrictionJoint applies friction to a body.
---@param body1 Body @The first body to attach to the joint.
---@param body2 Body @The second body to attach to the joint.
---@param x number @The x position of the anchor point.
---@param y number @The y position of the anchor point.
---@param collideConnected boolean @Specifies whether the two bodies should collide with eachother.
---@return FrictionJoint
function m.newFrictionJoint(body1, body2, x, y, collideConnected) end

---Create a gear joint connecting two joints.
---
---The gear joint connects two joints that must be either prismatic or revolute joints. Using this joint requires that the joints it uses connect their respective bodies to the ground and have the ground as the first body. When destroying the bodies and joints you must make sure you destroy the gear joint before the other joints.
---
---The gear joint has a ratio the determines how the angular or distance values of the connected joints relate to each other. The formula coordinate1 + ratio * coordinate2 always has a constant value that is set when the gear joint is created.
---@param joint1 Joint @The first joint to connect with a gear joint.
---@param joint2 Joint @The second joint to connect with a gear joint.
---@param ratio number @The gear ratio.
---@param collideConnected boolean @Specifies whether the two bodies should collide with each other.
---@return GearJoint
function m.newGearJoint(joint1, joint2, ratio, collideConnected) end

---Creates a joint between two bodies which controls the relative motion between them.
---
---Position and rotation offsets can be specified once the MotorJoint has been created, as well as the maximum motor force and torque that will be be applied to reach the target offsets.
---@param body1 Body @The first body to attach to the joint.
---@param body2 Body @The second body to attach to the joint.
---@param correctionFactor number @The joint's initial position correction factor, in the range of [0, 1].
---@return MotorJoint
---@overload fun(body1:Body, body2:Body, correctionFactor:number, collideConnected:boolean):MotorJoint
function m.newMotorJoint(body1, body2, correctionFactor) end

---Create a joint between a body and the mouse.
---
---This joint actually connects the body to a fixed point in the world. To make it follow the mouse, the fixed point must be updated every timestep (example below).
---
---The advantage of using a MouseJoint instead of just changing a body position directly is that collisions and reactions to other joints are handled by the physics engine.
---@param body Body @The body to attach to the mouse.
---@param x number @The x position of the connecting point.
---@param y number @The y position of the connecting point.
---@return MouseJoint
function m.newMouseJoint(body, x, y) end

---Creates a new PolygonShape.
---
---This shape can have 8 vertices at most, and must form a convex shape.
---@param x1 number @The position of first point on the x-axis.
---@param y1 number @The position of first point on the y-axis.
---@param x2 number @The position of second point on the x-axis.
---@param y2 number @The position of second point on the y-axis.
---@param ... number @You can continue passing more point positions to create the PolygonShape.
---@return PolygonShape
---@overload fun(vertices:table):PolygonShape
function m.newPolygonShape(x1, y1, x2, y2, ...) end

---Create a prismatic joints between two bodies.
---
---A prismatic joint constrains two bodies to move relatively to each other on a specified axis. It does not allow for relative rotation. Its definition and operation are similar to a revolute joint, but with translation and force substituted for angle and torque.
---@param body1 Body @The first body to connect with a prismatic joint.
---@param body2 Body @The second body to connect with a prismatic joint.
---@param x number @The x coordinate of the anchor point.
---@param y number @The y coordinate of the anchor point.
---@param ax number @The x coordinate of the axis unit vector.
---@param ay number @The y coordinate of the axis unit vector.
---@param collideConnected boolean @Specifies whether the two bodies should collide with each other.
---@return PrismaticJoint
---@overload fun(body1:Body, body2:Body, x1:number, y1:number, x2:number, y2:number, ax:number, ay:number, collideConnected:boolean):PrismaticJoint
---@overload fun(body1:Body, body2:Body, x1:number, y1:number, x2:number, y2:number, ax:number, ay:number, collideConnected:boolean, referenceAngle:number):PrismaticJoint
function m.newPrismaticJoint(body1, body2, x, y, ax, ay, collideConnected) end

---Create a pulley joint to join two bodies to each other and the ground.
---
---The pulley joint simulates a pulley with an optional block and tackle. If the ratio parameter has a value different from one, then the simulated rope extends faster on one side than the other. In a pulley joint the total length of the simulated rope is the constant length1 + ratio * length2, which is set when the pulley joint is created.
---
---Pulley joints can behave unpredictably if one side is fully extended. It is recommended that the method setMaxLengths  be used to constrain the maximum lengths each side can attain.
---@param body1 Body @The first body to connect with a pulley joint.
---@param body2 Body @The second body to connect with a pulley joint.
---@param gx1 number @The x coordinate of the first body's ground anchor.
---@param gy1 number @The y coordinate of the first body's ground anchor.
---@param gx2 number @The x coordinate of the second body's ground anchor.
---@param gy2 number @The y coordinate of the second body's ground anchor.
---@param x1 number @The x coordinate of the pulley joint anchor in the first body.
---@param y1 number @The y coordinate of the pulley joint anchor in the first body.
---@param x2 number @The x coordinate of the pulley joint anchor in the second body.
---@param y2 number @The y coordinate of the pulley joint anchor in the second body.
---@param ratio number @The joint ratio.
---@param collideConnected boolean @Specifies whether the two bodies should collide with each other.
---@return PulleyJoint
function m.newPulleyJoint(body1, body2, gx1, gy1, gx2, gy2, x1, y1, x2, y2, ratio, collideConnected) end

---Shorthand for creating rectangular PolygonShapes.
---
---By default, the local origin is located at the center of the rectangle as opposed to the top left for graphics.
---@param width number @The width of the rectangle.
---@param height number @The height of the rectangle.
---@return PolygonShape
---@overload fun(x:number, y:number, width:number, height:number, angle:number):PolygonShape
function m.newRectangleShape(width, height) end

---Creates a pivot joint between two bodies.
---
---This joint connects two bodies to a point around which they can pivot.
---@param body1 Body @The first body.
---@param body2 Body @The second body.
---@param x number @The x position of the connecting point.
---@param y number @The y position of the connecting point.
---@param collideConnected boolean @Specifies whether the two bodies should collide with each other.
---@return RevoluteJoint
---@overload fun(body1:Body, body2:Body, x1:number, y1:number, x2:number, y2:number, collideConnected:boolean, referenceAngle:number):RevoluteJoint
function m.newRevoluteJoint(body1, body2, x, y, collideConnected) end

---Create a joint between two bodies. Its only function is enforcing a max distance between these bodies.
---@param body1 Body @The first body to attach to the joint.
---@param body2 Body @The second body to attach to the joint.
---@param x1 number @The x position of the first anchor point.
---@param y1 number @The y position of the first anchor point.
---@param x2 number @The x position of the second anchor point.
---@param y2 number @The y position of the second anchor point.
---@param maxLength number @The maximum distance for the bodies.
---@param collideConnected boolean @Specifies whether the two bodies should collide with each other.
---@return RopeJoint
function m.newRopeJoint(body1, body2, x1, y1, x2, y2, maxLength, collideConnected) end

---Creates a constraint joint between two bodies. A WeldJoint essentially glues two bodies together. The constraint is a bit soft, however, due to Box2D's iterative solver.
---@param body1 Body @The first body to attach to the joint.
---@param body2 Body @The second body to attach to the joint.
---@param x number @The x position of the anchor point (world space).
---@param y number @The y position of the anchor point (world space).
---@param collideConnected boolean @Specifies whether the two bodies should collide with each other.
---@return WeldJoint
---@overload fun(body1:Body, body2:Body, x1:number, y1:number, x2:number, y2:number, collideConnected:boolean):WeldJoint
---@overload fun(body1:Body, body2:Body, x1:number, y1:number, x2:number, y2:number, collideConnected:boolean, referenceAngle:number):WeldJoint
function m.newWeldJoint(body1, body2, x, y, collideConnected) end

---Creates a wheel joint.
---@param body1 Body @The first body.
---@param body2 Body @The second body.
---@param x number @The x position of the anchor point.
---@param y number @The y position of the anchor point.
---@param ax number @The x position of the axis unit vector.
---@param ay number @The y position of the axis unit vector.
---@param collideConnected boolean @Specifies whether the two bodies should collide with each other.
---@return WheelJoint
function m.newWheelJoint(body1, body2, x, y, ax, ay, collideConnected) end

---Creates a new World.
---@param xg number @The x component of gravity.
---@param yg number @The y component of gravity.
---@param sleep boolean @Whether the bodies in this world are allowed to sleep.
---@return World
function m.newWorld(xg, yg, sleep) end

---Sets the pixels to meter scale factor.
---
---All coordinates in the physics module are divided by this number and converted to meters, and it creates a convenient way to draw the objects directly to the screen without the need for graphics transformations.
---
---It is recommended to create shapes no larger than 10 times the scale. This is important because Box2D is tuned to work well with shape sizes from 0.1 to 10 meters. The default meter scale is 30.
---
---love.physics.setMeter does not apply retroactively to created objects. Created objects retain their meter coordinates but the scale factor will affect their pixel coordinates.
---@param scale number @The scale factor as an integer.
function m.setMeter(scale) end

return m