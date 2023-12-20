require "src.globals"

Class = require "src.libraries.class"
Push  = require "src.libraries.push"
Timer = require "src.libraries.knife.timer"


Assets        = require "src.managers.AssetManager"
Quads         = require "src.managers.QuadManager"
ModuleManager = require "src.ModuleManager"

-- Done
require "objects.BaseObject"
require "src.modules.PositionModule"
require "src.modules.DimensionsModule"
require "src.modules.TextureModule"
require "src.modules.GravityModule"
require "src.modules.StateMachineModule"
require "src.modules.HitboxModule"
require "src.modules.MoveModule"
require "src.modules.InputModule"
require "src.modules.BaseMapModule"
require "src.modules.TileMapModule"
require "src.modules.BlockMapModule"
require "src.modules.CoinMapModule"
require "src.modules.AnimationModule"

-- Doing
require "src.modules.CameraModule"

--TODO
require "src.components.Collidable"
require "src.components.Consummable"
require "src.components.GameObject"



App = require "src.App"
require "src.StateMachine"

require "objects.Test"


require "src.managers.TileMapGenerator"
require "src.managers.BlockMapGenerator"


require "src.states.BaseState"
require "src.states.StartState"

require "src.states.player.BasePlayerState"
require "src.states.player.PlayerIdleState"
require "src.states.player.PlayerRunState"
require "src.states.player.PlayerFallState"
require "src.states.player.PlayerJumpState"


require "objects.PlayerCharacter"
require "objects.Level"
require "objects.Tile"
require "objects.JumpBlock"
require "src.components.TileTopper"
require "objects.Coin"
