import("CoreLibs/object")
import("CoreLibs/graphics")
import("CoreLibs/sprites")
import("CoreLibs/timer")

-- NOTE: Because it's local, you'll have to do it in every .lua source file.
local gfx <const> = playdate.graphics

local playerSprite = nil
local bullets = {}

function setup()
	local playerImage = gfx.image.new("Images/player")
	assert(playerImage)

	playerSprite = gfx.sprite.new(playerImage)
	playerSprite:moveTo(200, 120) -- this is where the center of the sprite is placed; (200,120) is the center of the Playdate screen
	playerSprite:add()

	-- We want an environment displayed behind our sprite.
	-- There are generally two ways to do this:
	-- 1) Use setBackgroundDrawingCallback() to draw a background image. (This is what we're doing below.)
	-- 2) Use a tilemap, assign it to a sprite with sprite:setTilemap(tilemap),
	--       and call :setZIndex() with some low number so the background stays behind
	--       your other sprites.

	local backgroundImage = gfx.image.new("Images/background")
	assert(backgroundImage)

	gfx.sprite.setBackgroundDrawingCallback(function(x, y, width, height)
		-- x,y,width,height is the updated area in sprite-local coordinates
		-- The clip rect is already set to this area, so we don't need to set it ourselves
		backgroundImage:draw(0, 0)
	end)
end

setup()

-- `playdate.update()` is the heart of every Playdate game.
-- This function is called right before every frame is drawn onscreen.
-- Use this function to poll input, run game logic, and move sprites.

function playdate.update()
	if playdate.buttonIsPressed(playdate.kButtonUp) then
		playerSprite:moveBy(0, -2)
	end
	if playdate.buttonIsPressed(playdate.kButtonRight) then
		playerSprite:moveBy(2, 0)
	end
	if playdate.buttonIsPressed(playdate.kButtonDown) then
		playerSprite:moveBy(0, 2)
	end
	if playdate.buttonIsPressed(playdate.kButtonLeft) then
		playerSprite:moveBy(-2, 0)
	end

	-- Call the functions below in playdate.update() to draw sprites and keep
	-- timers updated. (We aren't using timers in this example, but in most
	-- average-complexity games, you will.)

	gfx.sprite.update()
	playdate.timer.updateTimers()
end
