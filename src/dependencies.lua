require "src.globals"
-- require "src.utils"

Class = require "src.libraries.class"
Push = require "src.libraries.push"

App = require "src.App"

Assets = require "src.managers.AssetManager"
Quads = require "src.managers.QuadManager"
Timer = require "src.libraries.knife.timer"
require "src.managers.StateManager"
require "src.managers.AnimationManager"
require "src.managers.CameraManager"
TileMap = require "src.managers.TileMapGenerator"


require "src.states.BaseState"
require "src.states.StartState"
require "src.states.player.PlayerIdleState"
require "src.states.player.PlayerRunningState"
require "src.states.player.PlayerFallingState"
require "src.states.player.PlayerJumpingState"

require "objects.GameObject"
require "objects.Level"
require "objects.Tile"
require "objects.Character"
require "objects.Hitbox"
require "objects.Block"
