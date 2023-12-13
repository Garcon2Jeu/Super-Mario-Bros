require "src.globals"

Class = require "src.libraries.class"
Push = require "src.libraries.push"
-- Timer = require "src.libraries.knife.timer"

require "src.components.Input"
App = require "src.App"
require "src.StateMachine"

Assets = require "src.managers.AssetManager"
Quads = require "src.managers.QuadManager"
-- require "src.managers.AnimationManager"
-- require "src.managers.CameraManager"
-- TileMap = require "src.managers.TileMapGenerator"


require "src.states.BaseState"
require "src.states.StartState"

require "src.states.player.PlayerIdleState"
require "src.states.player.PlayerRunState"
require "src.states.player.PlayerFallState"
require "src.states.player.PlayerJumpState"

require "src.components.GameObject"
require "src.components.GravityBundle"
require "src.components.MoveBundle"

require "objects.PlayerCharacter"
-- require "objects.Level"
-- require "objects.Tile"
-- require "objects.Hitbox"
-- require "objects.Block"
