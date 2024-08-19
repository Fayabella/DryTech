require "/scripts/liquid/liquidSensor.lua"


function init()
	if storage == nil then
		storage = {}
	end

	-- Load the digits once on init so we don't fetch it OVER AND OVER
	storage.displayDigits = {}
	storage.displayDigits.d1 = config.getParameter("displayDigits.d1", false)
	storage.displayDigits.d2 = config.getParameter("displayDigits.d2", false)
	storage.displayDigits.d3 = config.getParameter("displayDigits.d3", false)
	storage.displayDigits.d4 = config.getParameter("displayDigits.d4", false)
	storage.displayDigits.d5 = config.getParameter("displayDigits.d5", false)
	storage.displayDigits.d6 = config.getParameter("displayDigits.d6", false)
	storage.displayDigits.d7 = config.getParameter("displayDigits.d7", false)
	storage.displayDigits.d8 = config.getParameter("displayDigits.d8", false)
	storage.displayDigits.d9 = config.getParameter("displayDigits.d9", false)
	storage.formattedPressure = "69420"
end

function update(dt)
	local active = (object.isInputNodeConnected(0)) or object.getInputNodeLevel(0)
	local compressed = storage.displayCompressionLevel and storage.liquidCompressionLevel

	if compressed and active then
		-- storage.liquidCompressionLevel <= storage.pressureMax then
		if true then
			if storage.liquidCompressionLevel > 999999999 then
				storage.formattedPressure = string.sub(string.format("%.2E", storage.displayCompressionLevel), 0, string.find(string.format("%.2E", storage.displayCompressionLevel),"+"))..string.format("%03.f", string.sub(string.format("%.2E", storage.displayCompressionLevel),-3))
			else
				storage.formattedPressure = storage.displayCompressionLevel
			end
			setDigit("d1", string.sub(storage.formattedPressure,-1))
			setDigit("d2", string.sub(storage.formattedPressure,-2,-2))
			setDigit("d3", string.sub(storage.formattedPressure,-3,-3))
			setDigit("d4", string.sub(storage.formattedPressure,-4,-4))
			setDigit("d5", string.sub(storage.formattedPressure,-5,-5))
			setDigit("d6", string.sub(storage.formattedPressure,-6,-6))
			setDigit("d7", string.sub(storage.formattedPressure,-7,-7))
			setDigit("d8", string.sub(storage.formattedPressure,-8,-8))
			setDigit("d9", string.sub(storage.formattedPressure,-9,-9))

		else
			setDigit("d1", "excess")
			setDigit("d2", "excess")
			setDigit("d3", "excess")
			setDigit("d4", "excess")
			setDigit("d5", "excess")
			setDigit("d6", "excess")
			setDigit("d7", "excess")
			setDigit("d8", "excess")
			setDigit("d9", "excess")
		end
	else
		setDigit("d1", "invalid")
		setDigit("d2", "invalid")
		setDigit("d3", "invalid")
		setDigit("d4", "invalid")
		setDigit("d5", "invalid")
		setDigit("d6", "invalid")
		setDigit("d7", "invalid")
		setDigit("d8", "invalid")
		setDigit("d9", "invalid")
	end
end

function setDigit(digit, value)
	local hasDigit = storage.displayDigits[digit]

	if hasDigit then
		if value ~= "0" and value ~= "1" and value ~= "2" and value ~= "3" and value ~= "4" and value ~= "5" and value ~= "6" and value ~= "7" and value ~= "8" and value ~= "9" and value ~= "excess" and value ~= "invalid" and value ~= "+" and value ~= "E" and value ~= "." then
			animator.setAnimationState(digit, "invalid")
		else
			animator.setAnimationState(digit, value)
		end
	end
end