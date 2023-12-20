require "src.globals"

-- Libraries
Class = require "libraries.class"
Push  = require "libraries.push"
Timer = require "libraries.knife.timer"


-- Managers
Assets  = require "managers.AssetManager"
Quads   = require "managers.QuadManager"
Modules = require "managers.ModuleManager"
require "managers.StateMachine"
require "managers.TileMapGenerator"
require "managers.BlockMapGenerator"


-- Modules
require "modules.PositionModule"
require "modules.DimensionsModule"
require "modules.TextureModule"
require "modules.GravityModule"
require "modules.StateMachineModule"
require "modules.HitboxModule"
require "modules.MoveModule"
require "modules.InputModule"
require "modules.BaseMapModule"
require "modules.TileMapModule"
require "modules.BlockMapModule"
require "modules.CoinMapModule"
require "modules.AnimationModule"
require "modules.CameraModule"
require "modules.CollidableModule"
require "modules.ConsummableModule"


-- States
require "states.BaseState"
require "states.StartState"

require "states.player.BasePlayerState"
require "states.player.PlayerIdleState"
require "states.player.PlayerRunState"
require "states.player.PlayerFallState"
require "states.player.PlayerJumpState"


-- Objects
App = require "objects.App"
require "objects.BaseObject"
require "objects.PlayerCharacter"
require "objects.Level"
require "objects.Tile"
require "objects.JumpBlock"
require "objects.Coin"
require "objects.TileTopper"
