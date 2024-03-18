require "/scripts/liquid/liquidSensor.lua"


function init()
	if storage == nil then
		storage = {}
	end

	-- Load the digits once on init so we don't fetch it OVER AND OVER
	storage.displayDigits = {}
	storage.displayDigits.one                = config.getParameter("displayDigits.one", false)
	storage.displayDigits.ten                = config.getParameter("displayDigits.ten", false)
	storage.displayDigits.hundred            = config.getParameter("displayDigits.hundred", false)
	storage.displayDigits.thousand           = config.getParameter("displayDigits.thousand", false)
	storage.displayDigits.tenThousand        = config.getParameter("displayDigits.tenThousand", false)
	storage.displayDigits.hundredThousand    = config.getParameter("displayDigits.hundredThousand", false)
	storage.displayDigits.million            = config.getParameter("displayDigits.million", false)
	storage.displayDigits.tenMillion         = config.getParameter("displayDigits.tenMillion", false)
	storage.displayDigits.hundredMillion     = config.getParameter("displayDigits.hundredMillion", false)
	storage.displayDigits.billion            = config.getParameter("displayDigits.billion", false)
	storage.displayDigits.tenBillion         = config.getParameter("displayDigits.tenBillion", false)
	storage.displayDigits.hundredBillion     = config.getParameter("displayDigits.hundredBillion", false)
	storage.displayDigits.trillion           = config.getParameter("displayDigits.trillion", false)
	storage.displayDigits.tenTrillion        = config.getParameter("displayDigits.tenTrillion", false)
	storage.displayDigits.hundredTrillion    = config.getParameter("displayDigits.hundredTrillion", false)
	storage.displayDigits.quadrillion        = config.getParameter("displayDigits.quadrillion", false)
	storage.displayDigits.tenQuadrillion     = config.getParameter("displayDigits.tenQuadrillion", false)
	storage.displayDigits.hundredQuadrillion = config.getParameter("displayDigits.hundredQuadrillion", false)
	storage.displayDigits.quintillion        = config.getParameter("displayDigits.quintillion", false)
	storage.displayDigits.tenQuintillion     = config.getParameter("displayDigits.tenQuintillion", false)


	-- Same with the pressure maximum
	storage.pressureMax = config.getParameter("pressureMax", 9)
end


function update(dt)
	local active = (object.isInputNodeConnected(0)) or object.getInputNodeLevel(0)
	local compressed = storage.displayCompressionLevel and storage.liquidCompressionLevel

	if compressed and active then
		-- storage.liquidCompressionLevel <= storage.pressureMax then
		if true then
			setDigit("one", string.sub(storage.displayCompressionLevel,-1))
                        setDigit("ten", string.sub(storage.displayCompressionLevel,-2,-2))
                        setDigit("hundred", string.sub(storage.displayCompressionLevel,-3,-3))
                        setDigit("thousand", string.sub(storage.displayCompressionLevel,-4,-4))
                        setDigit("tenThousand", string.sub(storage.displayCompressionLevel,-5,-5))
                        setDigit("hundredThousand", string.sub(storage.displayCompressionLevel,-6,-6))
                        setDigit("million", string.sub(storage.displayCompressionLevel,-7,-7))
                        setDigit("tenMillion", string.sub(storage.displayCompressionLevel,-8,-8))
                        setDigit("hundredMillion", string.sub(storage.displayCompressionLevel,-9,-9))
                        setDigit("billion", string.sub(storage.displayCompressionLevel,-10,-10))
                        setDigit("tenBillion", string.sub(storage.displayCompressionLevel,-11,-11))
                        setDigit("hundredBillion", string.sub(storage.displayCompressionLevel,-12,-12))
                        setDigit("trillion", string.sub(storage.displayCompressionLevel,-13,-13))
                        setDigit("tenTrillion", string.sub(storage.displayCompressionLevel,-14,-14))
                        setDigit("hundredTrillion", string.sub(storage.displayCompressionLevel,-15,-15))
                        setDigit("quadrillion", string.sub(storage.displayCompressionLevel,-16,-16))
                        setDigit("tenQuadrillion", string.sub(storage.displayCompressionLevel,-17,-17))
                        setDigit("hundredQuadrillion", string.sub(storage.displayCompressionLevel,-18,-18))
                        setDigit("quintillion", string.sub(storage.displayCompressionLevel,-19,-19))
                        setDigit("tenQuintillion", string.sub(storage.displayCompressionLevel,-20,-20))


		else
			setDigit("one", "excess")
			setDigit("ten", "excess")
			setDigit("hundred", "excess")
			setDigit("thousand", "excess")
			setDigit("tenThousand", "excess")
			setDigit("hundredThousand", "excess")
			setDigit("million", "excess")
			setDigit("tenMillion", "excess")
			setDigit("hundredMillion", "excess")
			setDigit("billion", "excess")
			setDigit("tenBillion", "excess")
			setDigit("hundredBillion", "excess")
			setDigit("trillion", "excess")
			setDigit("tenTrillion", "excess")
			setDigit("hundredTrillion", "excess")
			setDigit("quadrillion", "excess")
			setDigit("tenQuadrillion", "excess")
			setDigit("hundredQuadrillion", "excess")
			setDigit("quintillion", "excess")
			setDigit("tenQuintillion", "excess")

		end
	else
		setDigit("one", "invalid")
		setDigit("ten", "invalid")
		setDigit("hundred", "invalid")
		setDigit("thousand", "invalid")
		setDigit("tenThousand", "invalid")
		setDigit("hundredThousand", "invalid")
		setDigit("million", "invalid")
		setDigit("tenMillion", "invalid")
		setDigit("hundredMillion", "invalid")
		setDigit("billion", "invalid")
		setDigit("tenBillion", "invalid")
		setDigit("hundredBillion", "invalid")
		setDigit("trillion", "invalid")
		setDigit("tenTrillion", "invalid")
		setDigit("hundredTrillion", "invalid")
		setDigit("quadrillion", "invalid")
		setDigit("tenQuadrillion", "invalid")
		setDigit("hundredQuadrillion", "invalid")
		setDigit("quintillion", "invalid")
		setDigit("tenQuintillion", "invalid")

	end
end

function setDigit(digit, value)
	local hasDigit = storage.displayDigits[digit]

	if hasDigit then
		if value ~= "0" and value ~= "1" and value ~= "2" and value ~= "3" and value ~= "4" and value ~= "5" and value ~= "6" and value ~= "7" and value ~= "8" and value ~= "9" and value ~= "excess" and value ~= "invalid" then
			animator.setAnimationState(digit, "invalid")
		else
			animator.setAnimationState(digit, value)
		end
	end
end