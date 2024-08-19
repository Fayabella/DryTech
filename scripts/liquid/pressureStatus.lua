pressureStatus={
	oldinit = init,
	oldupdate = update
}

function init()
	sb.logInfo("drown innit")
	self.pressure = {}
	if pressureStatus.oldinit then pressureStatus.oldinit() end
end

function dupdate(dt)
	if pressureStatus.oldupdate then pressureStatus.oldupdate(dt) end

	--variable storage is in self.pressure table.... probably unnecessary but too late now...
	self.pressure.relativeBoundBox = mcontroller.boundBox()
	self.pressure.position = mcontroller.position()
	self.pressure.worldBoundBox = {self.pressure.position[1]+self.pressure.relativeBoundBox[1],self.pressure.position[2]+self.pressure.relativeBoundBox[2],self.pressure.position[1]+self.pressure.relativeBoundBox[3],self.pressure.position[2]+self.pressure.relativeBoundBox[4]}


	self.pressure.corners = {{self.pressure.worldBoundBox[1],self.pressure.worldBoundBox[2]},{self.pressure.worldBoundBox[3],self.pressure.worldBoundBox[2]},{self.pressure.worldBoundBox[1],self.pressure.worldBoundBox[4]},{self.pressure.worldBoundBox[3],self.pressure.worldBoundBox[4]}}
	self.pressure.projectile = {}

	table.insert(self.pressure.projectile,{
		action = "particle",
		["repeat"] = false,
		time= 0,
		specification = {
			type = "ember", 
			layer = "front", 
			color = {0,255,0,255}, 
			fullbright = true, 
			collidesForeground = false, 
			collidesLiquid = false, 
			destructionAction = "fade", 
			destructionTime = 0.01, 
			timeToLive = 0.01, 
			size = 1, 
			position = {0,0}
		}
	})

	self.pressure.projectile2 = {}

	table.insert(self.pressure.projectile2,{
		action = "particle",
		["repeat"] = false,
		time= 0,
		specification = {
			type = "ember", 
			layer = "front", 
			color = {255,255,0,96}, 
			fullbright = true, 
			collidesForeground = false, 
			collidesLiquid = false, 
			destructionAction = "fade", 
			destructionTime = 0.01, 
			timeToLive = 0.01, 
			size = 8, 
			position = {0,0}
		}
	})

	for _, pos in ipairs(self.pressure.corners) do
		world.spawnProjectile("invisibleprojectile", pos, entity.id(), {0,0}, false, {
		damageTeam = {type = "ghostly"},
		timeToLive = 0.1,
		speed = 0,
		collisionEnabled = false,
		periodicActions = self.pressure.projectile
		})
	end

	for _, pos in ipairs(self.pressure.corners) do
		world.spawnProjectile("invisibleprojectile", {pos[1]//1+0.5,pos[2]//1+0.5}, entity.id(), {0,0}, false, {
		damageTeam = {type = "ghostly"},
		timeToLive = 0.1,
		speed = 0,
		collisionEnabled = false,
		periodicActions = self.pressure.projectile2
		})
	end
 
	if world.liquidAt(self.pressure.position)[2] > 2 then
		world.spawnProjectile("invisibleprojectile", self.pressure.position, entity.id(), {0,0}, false, {
			damageTeam = {type = "ghostly"},
			timeToLive = 0.1,
			speed = 0,
			collisionEnabled = false,
			periodicActions = self.pressure.projectile2
			})
	end

	local liquidLevel = world.liquidAt({math.floor(self.pressure.position[1]), math.floor(self.pressure.position[2])})
	sb.logInfo("brugh: %s %s", liquidLevel, {math.floor(self.pressure.position[1]), math.floor(self.pressure.position[2])})
	if liquidLevel and liquidLevel[2] then
		self.pressure.amount = math.floor(liquidLevel and liquidLevel[2] or 0)
		if self.pressure.amount then sb.logInfo("average fluid pressure: %s", self.pressure.amount) end
		sb.logInfo("that one fucking tile: %s", world.liquidAt({709, 1041})[2])
	end
end