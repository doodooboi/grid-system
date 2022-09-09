local GridX = 9
local GridY = 9

local function MakeGrid(Width, Height)
	local TestGrid = {}

	for Y = 1, Height do
		TestGrid[Y] = {}
		for X = 1, Width do
			TestGrid[Y][X] = {1}
		end 
	end

	return TestGrid
end

local function PrintGrid(grid)
	for Index, Value in ipairs(grid) do
		local blah = {}
		for Index2, Value2 in ipairs(Value) do
			table.insert(blah, Value2[1])
		end 
		print(Index..":", table.concat(blah, " "))
	end 
end

local OriginalGrid = MakeGrid(GridX,GridY)
local Limit = 100
local Visited = {}

local function CellsAreSame(cell1, cell2) 
	if #cell1 ~= #cell2 then return false end

	for Index, _ in ipairs(cell1) do
		if cell1[Index] ~= cell2[Index] then return false end
	end 

	return true
end

local function SetVisited(StartY,StartX,CurrentY,CurrentX)
	if not Visited[StartY] then
		Visited[StartY] = {}
	elseif not Visited[CurrentY] then
		Visited[CurrentY] = {}
	end

	Visited[CurrentY][CurrentX] = true
	Visited[StartY][StartX] = true
end

local function LimitXY()

local function GreedyMesh(StartY, StartX, RecursiveData)

	RecursiveData = RecursiveData or {}
	
	if RecursiveData.Recurse and RecursiveData.Recurse > Limit then
		warn("Recursion Limit")
		return
	end
	
	local MaxX = RecursiveData.XLimit or GridX
	local MaxY = RecursiveData.YLimit or GridY
	
	local SizeX = RecursiveData.SizeX or 1
	local SizeY = RecursiveData.SizeY or 1

	local CurrentX = StartX
	local CurrentY = StartY

	local Direction = "X"

	local CurrentCell = OriginalGrid[CurrentY][CurrentX]
	local NeighboringCell = nil
	
	if CurrentX + 1 > MaxX then
		if OriginalGrid[CurrentY+1] then
			CurrentY = StartY+1
			CurrentX = RecursiveData.OriginalX or CurrentX
			
			Direction = "Y"
		else
			return RecursiveData
		end
	elseif CurrentY + 1 > MaxY and (CurrentX + 1 > MaxX) then
		return RecursiveData
	end

	if Direction == "X" then
		CurrentX += 1
	end
	
	NeighboringCell = OriginalGrid[CurrentY][CurrentX]
	
	--warn(StartY,StartX)
	--warn(CurrentY, CurrentX)
	--warn(Direction)
	--warn(CurrentCell, NeighboringCell)
	--warn(RecursiveData)
	--print()
	
	if not CurrentCell or not NeighboringCell then
		return RecursiveData
	end

	if CellsAreSame(CurrentCell, NeighboringCell) then
		if Direction == "X" then
			SizeX += 1
		elseif Direction == "Y" then
			SizeY += 1
		end
		
		SetVisited(StartY, StartX, CurrentY, CurrentX)
		
		SizeX = math.min(SizeX, MaxX)
		SizeY = math.min(SizeY, MaxY)
		
		local RecurseData = {
			["SizeY"] = SizeY,
			["SizeX"] = SizeX,
			["Recurse"] = if RecursiveData.Recurse then RecursiveData.Recurse + 1 else 1,
			["XLimit"] = RecursiveData.XLimit,
			["YLimit"] = RecursiveData.YLimit,
			
			["OriginalX"] = RecursiveData.OriginalX,
		}
		
		
		if not RecursiveData.OriginalX then -- Our first recursion
			RecurseData["OriginalX"] = StartX
		end
	
		return GreedyMesh(CurrentY, CurrentX, RecurseData)
	else
		local RecurseData = {
			["SizeY"] = SizeY,
			["SizeX"] = SizeX,
			["Recurse"] = if RecursiveData.Recurse then RecursiveData.Recurse + 1 else 1,
			["XLimit"] = CurrentX - 1,
			["YLimit"] = RecursiveData.YLimit,

			["OriginalX"] = RecursiveData.OriginalX,
		}
		
		if not RecursiveData.OriginalX then -- Our first recursion
			RecurseData["OriginalX"] = StartX
		end
		
		return GreedyMesh(CurrentY, CurrentX-1, RecurseData)
	end
end

local FinishedGreedyMeshing = false
local XOffset = 1
local YOffset = 1

OriginalGrid[3][5] = {0}

PrintGrid(OriginalGrid)

for Y = 1, GridY do
	for X = 1, GridX do
		if Visited[Y] and Visited[Y][X] then continue end
		
		local Data = GreedyMesh(Y,X)
		
		print(Y,X, Data)
	end
end

--print(OriginalGrid)

--local Data = GreedyMesh(1,1)

--print(Data.SizeY, Data.SizeX)
