--[[ Generator function for the time bar.
for i=0, 99, 1 do
  print("--frame " .. i + 1)
  print("{")
  print("      x= 0,")
  print("      y= 0,")
  print("      width = " .. 500 - (500/100) * i ..",")
  print("      height = 41")
  print("},")
 end
]]

local graphics = require("graphics")

local t = {}
local mt = {__index = t}

local sequence = {};
--------------------------------------------------------------------------------
		----------------------- Cafeteria things -----------------------
--------------------------------------------------------------------------------
local function setBarSequence(m) -- Generate sequence data for time bar
	sequence = {
				name = "timeBar",
				start = 1,
				count = m,
				loopCount = 1,
						-- 1 minute
				time = (1000 * 60)
}
end

local function getBarSequence() -- Get sequence for time bar
	return sequence;
end

local function getBarFrames() -- get bar frames
	local options =  {
	frames = 
	{
		--frame 1
		{
		      x= 0,
		      y= 0,
		      width = 500,
		      height = 41
		},
		--frame 2
		{
		      x= 0,
		      y= 0,
		      width = 495,
		      height = 41
		},
		--frame 3
		{
		      x= 0,
		      y= 0,
		      width = 490,
		      height = 41
		},
		--frame 4
		{
		      x= 0,
		      y= 0,
		      width = 485,
		      height = 41
		},
		--frame 5
		{
		      x= 0,
		      y= 0,
		      width = 480,
		      height = 41
		},
		--frame 6
		{
		      x= 0,
		      y= 0,
		      width = 475,
		      height = 41
		},
		--frame 7
		{
		      x= 0,
		      y= 0,
		      width = 470,
		      height = 41
		},
		--frame 8
		{
		      x= 0,
		      y= 0,
		      width = 465,
		      height = 41
		},
		--frame 9
		{
		      x= 0,
		      y= 0,
		      width = 460,
		      height = 41
		},
		--frame 10
		{
		      x= 0,
		      y= 0,
		      width = 455,
		      height = 41
		},
		--frame 11
		{
		      x= 0,
		      y= 0,
		      width = 450,
		      height = 41
		},
		--frame 12
		{
		      x= 0,
		      y= 0,
		      width = 445,
		      height = 41
		},
		--frame 13
		{
		      x= 0,
		      y= 0,
		      width = 440,
		      height = 41
		},
		--frame 14
		{
		      x= 0,
		      y= 0,
		      width = 435,
		      height = 41
		},
		--frame 15
		{
		      x= 0,
		      y= 0,
		      width = 430,
		      height = 41
		},
		--frame 16
		{
		      x= 0,
		      y= 0,
		      width = 425,
		      height = 41
		},
		--frame 17
		{
		      x= 0,
		      y= 0,
		      width = 420,
		      height = 41
		},
		--frame 18
		{
		      x= 0,
		      y= 0,
		      width = 415,
		      height = 41
		},
		--frame 19
		{
		      x= 0,
		      y= 0,
		      width = 410,
		      height = 41
		},
		--frame 20
		{
		      x= 0,
		      y= 0,
		      width = 405,
		      height = 41
		},
		--frame 21
		{
		      x= 0,
		      y= 0,
		      width = 400,
		      height = 41
		},
		--frame 22
		{
		      x= 0,
		      y= 0,
		      width = 395,
		      height = 41
		},
		--frame 23
		{
		      x= 0,
		      y= 0,
		      width = 390,
		      height = 41
		},
		--frame 24
		{
		      x= 0,
		      y= 0,
		      width = 385,
		      height = 41
		},
		--frame 25
		{
		      x= 0,
		      y= 0,
		      width = 380,
		      height = 41
		},
		--frame 26
		{
		      x= 0,
		      y= 0,
		      width = 375,
		      height = 41
		},
		--frame 27
		{
		      x= 0,
		      y= 0,
		      width = 370,
		      height = 41
		},
		--frame 28
		{
		      x= 0,
		      y= 0,
		      width = 365,
		      height = 41
		},
		--frame 29
		{
		      x= 0,
		      y= 0,
		      width = 360,
		      height = 41
		},
		--frame 30
		{
		      x= 0,
		      y= 0,
		      width = 355,
		      height = 41
		},
		--frame 31
		{
		      x= 0,
		      y= 0,
		      width = 350,
		      height = 41
		},
		--frame 32
		{
		      x= 0,
		      y= 0,
		      width = 345,
		      height = 41
		},
		--frame 33
		{
		      x= 0,
		      y= 0,
		      width = 340,
		      height = 41
		},
		--frame 34
		{
		      x= 0,
		      y= 0,
		      width = 335,
		      height = 41
		},
		--frame 35
		{
		      x= 0,
		      y= 0,
		      width = 330,
		      height = 41
		},
		--frame 36
		{
		      x= 0,
		      y= 0,
		      width = 325,
		      height = 41
		},
		--frame 37
		{
		      x= 0,
		      y= 0,
		      width = 320,
		      height = 41
		},
		--frame 38
		{
		      x= 0,
		      y= 0,
		      width = 315,
		      height = 41
		},
		--frame 39
		{
		      x= 0,
		      y= 0,
		      width = 310,
		      height = 41
		},
		--frame 40
		{
		      x= 0,
		      y= 0,
		      width = 305,
		      height = 41
		},
		--frame 41
		{
		      x= 0,
		      y= 0,
		      width = 300,
		      height = 41
		},
		--frame 42
		{
		      x= 0,
		      y= 0,
		      width = 295,
		      height = 41
		},
		--frame 43
		{
		      x= 0,
		      y= 0,
		      width = 290,
		      height = 41
		},
		--frame 44
		{
		      x= 0,
		      y= 0,
		      width = 285,
		      height = 41
		},
		--frame 45
		{
		      x= 0,
		      y= 0,
		      width = 280,
		      height = 41
		},
		--frame 46
		{
		      x= 0,
		      y= 0,
		      width = 275,
		      height = 41
		},
		--frame 47
		{
		      x= 0,
		      y= 0,
		      width = 270,
		      height = 41
		},
		--frame 48
		{
		      x= 0,
		      y= 0,
		      width = 265,
		      height = 41
		},
		--frame 49
		{
		      x= 0,
		      y= 0,
		      width = 260,
		      height = 41
		},
		--frame 50
		{
		      x= 0,
		      y= 0,
		      width = 255,
		      height = 41
		},
		--frame 51
		{
		      x= 0,
		      y= 0,
		      width = 250,
		      height = 41
		},
		--frame 52
		{
		      x= 0,
		      y= 0,
		      width = 245,
		      height = 41
		},
		--frame 53
		{
		      x= 0,
		      y= 0,
		      width = 240,
		      height = 41
		},
		--frame 54
		{
		      x= 0,
		      y= 0,
		      width = 235,
		      height = 41
		},
		--frame 55
		{
		      x= 0,
		      y= 0,
		      width = 230,
		      height = 41
		},
		--frame 56
		{
		      x= 0,
		      y= 0,
		      width = 225,
		      height = 41
		},
		--frame 57
		{
		      x= 0,
		      y= 0,
		      width = 220,
		      height = 41
		},
		--frame 58
		{
		      x= 0,
		      y= 0,
		      width = 215,
		      height = 41
		},
		--frame 59
		{
		      x= 0,
		      y= 0,
		      width = 210,
		      height = 41
		},
		--frame 60
		{
		      x= 0,
		      y= 0,
		      width = 205,
		      height = 41
		},
		--frame 61
		{
		      x= 0,
		      y= 0,
		      width = 200,
		      height = 41
		},
		--frame 62
		{
		      x= 0,
		      y= 0,
		      width = 195,
		      height = 41
		},
		--frame 63
		{
		      x= 0,
		      y= 0,
		      width = 190,
		      height = 41
		},
		--frame 64
		{
		      x= 0,
		      y= 0,
		      width = 185,
		      height = 41
		},
		--frame 65
		{
		      x= 0,
		      y= 0,
		      width = 180,
		      height = 41
		},
		--frame 66
		{
		      x= 0,
		      y= 0,
		      width = 175,
		      height = 41
		},
		--frame 67
		{
		      x= 0,
		      y= 0,
		      width = 170,
		      height = 41
		},
		--frame 68
		{
		      x= 0,
		      y= 0,
		      width = 165,
		      height = 41
		},
		--frame 69
		{
		      x= 0,
		      y= 0,
		      width = 160,
		      height = 41
		},
		--frame 70
		{
		      x= 0,
		      y= 0,
		      width = 155,
		      height = 41
		},
		--frame 71
		{
		      x= 0,
		      y= 0,
		      width = 150,
		      height = 41
		},
		--frame 72
		{
		      x= 0,
		      y= 0,
		      width = 145,
		      height = 41
		},
		--frame 73
		{
		      x= 0,
		      y= 0,
		      width = 140,
		      height = 41
		},
		--frame 74
		{
		      x= 0,
		      y= 0,
		      width = 135,
		      height = 41
		},
		--frame 75
		{
		      x= 0,
		      y= 0,
		      width = 130,
		      height = 41
		},
		--frame 76
		{
		      x= 0,
		      y= 0,
		      width = 125,
		      height = 41
		},
		--frame 77
		{
		      x= 0,
		      y= 0,
		      width = 120,
		      height = 41
		},
		--frame 78
		{
		      x= 0,
		      y= 0,
		      width = 115,
		      height = 41
		},
		--frame 79
		{
		      x= 0,
		      y= 0,
		      width = 110,
		      height = 41
		},
		--frame 80
		{
		      x= 0,
		      y= 0,
		      width = 105,
		      height = 41
		},
		--frame 81
		{
		      x= 0,
		      y= 0,
		      width = 100,
		      height = 41
		},
		--frame 82
		{
		      x= 0,
		      y= 0,
		      width = 95,
		      height = 41
		},
		--frame 83
		{
		      x= 0,
		      y= 0,
		      width = 90,
		      height = 41
		},
		--frame 84
		{
		      x= 0,
		      y= 0,
		      width = 85,
		      height = 41
		},
		--frame 85
		{
		      x= 0,
		      y= 0,
		      width = 80,
		      height = 41
		},
		--frame 86
		{
		      x= 0,
		      y= 0,
		      width = 75,
		      height = 41
		},
		--frame 87
		{
		      x= 0,
		      y= 0,
		      width = 70,
		      height = 41
		},
		--frame 88
		{
		      x= 0,
		      y= 0,
		      width = 65,
		      height = 41
		},
		--frame 89
		{
		      x= 0,
		      y= 0,
		      width = 60,
		      height = 41
		},
		--frame 90
		{
		      x= 0,
		      y= 0,
		      width = 55,
		      height = 41
		},
		--frame 91
		{
		      x= 0,
		      y= 0,
		      width = 50,
		      height = 41
		},
		--frame 92
		{
		      x= 0,
		      y= 0,
		      width = 45,
		      height = 41
		},
		--frame 93
		{
		      x= 0,
		      y= 0,
		      width = 40,
		      height = 41
		},
		--frame 94
		{
		      x= 0,
		      y= 0,
		      width = 35,
		      height = 41
		},
		--frame 95
		{
		      x= 0,
		      y= 0,
		      width = 30,
		      height = 41
		},
		--frame 96
		{
		      x= 0,
		      y= 0,
		      width = 25,
		      height = 41
		},
		--frame 97
		{
		      x= 0,
		      y= 0,
		      width = 20,
		      height = 41
		},
		--frame 98
		{
		      x= 0,
		      y= 0,
		      width = 15,
		      height = 41
		},
		--frame 99
		{
		      x= 0,
		      y= 0,
		      width = 10,
		      height = 41
		},
		--frame 100
		{
		      x= 0,
		      y= 0,
		      width = 5,
		      height = 41
		}
	}
  } -- end Options.
	setBarSequence(100) -- generate sequence data
	return options; -- return options
end

local function getFruitImages()
	local options = 
			{
				frames = 
				{
					-- 1: Sandwich
					{
						x = 5,
						y = 2,
						width = 166,
						height = 180
					},
					-- 2: Apple
					{
						x = 233,
						y = 52,
						width = 111,
						height = 109
					},
					-- 3: Bean
					{
						x = 364,
						y = 39,
						width = 107,
						height = 156
					},
					-- 4: cracker
					{
						x = 489,
						y = 25,
						width = 122,
						height = 140
					},
					-- 5: Spoooooooon
					{
						x = 44,
						y = 244,
						width = 154,
						height = 178
					},
					-- 6: Theres a fly in my soup!
					{
						x = 236,
						y = 195,
						width = 96,
						height = 101
					},
					-- 7: Grapes of wrath
					{
						x = 477,
						y = 174,
						width = 166,
						height = 117
					},
					-- 8: Spider
					{
						x = 231,
						y = 319,
						width = 230,
						height = 98
					},
					-- 9: Candy bar
					{
						x = 477,
						y = 308,
						width = 175,
						height = 113
					}
				} -- End frames
			}; -- End options.

	local cafeItemSheet = graphics.newImageSheet("arts/foodspritesheet.png", options)
	return cafeItemSheet;
end

--------------------------------------------------------------------------------
		----------------------- Class things -----------------------
--------------------------------------------------------------------------------
local function getRedGreenSprite()
	local options =
			{
				frames =
					{
						{	-- Red
							x = 7,
							y = 9,
							width = 159,
							height = 167
						},
						{ -- Green
							x = 240,
							y = 19,
							width = 155,
							height = 157
						}
					}
			}
	local rgImageSheet = graphics.newImageSheet("arts/squaresspritesheet.png", options);
	local sequenceData = 
			{
				{name = "red", start = 1, count = 1 },
				{name = "green", start = 2, count = 1}
			}
	local rgSprite = display.newSprite(rgImageSheet, sequenceData)
	return rgSprite;
end


t.getRedGreenSprite = getRedGreenSprite;
t.getBarFrames = getBarFrames;
t.getBarSequence = getBarSequence;
t.getFruitImages = getFruitImages;
return t;

