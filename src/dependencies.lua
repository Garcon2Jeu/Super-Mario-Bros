require "src.globals"

-- Libraries
Class = require "libraries.class"
Push  = require "libraries.push"
Timer = require "libraries.knife.timer"
Chain = require "libraries.knife.chain"
require "libraries.tableUtils"


-- Managers
Assets  = require "managers.AssetManager"
Quads   = require "managers.QuadManager"
Modules = require "managers.ModuleManager"
require "managers.StateMachine"
require "managers.TileMapGenerator"
require "managers.BlockMapGenerator"
require "managers.EnnemiGenerator"


-- Modules
require "modules.CoordinatesModule"
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
require "modules.AsymmetricModule"
require "modules.EnnemiManagerModule"
require "modules.MapPointerModule"
require "modules.PlayerModule"


-- States
require "states.BaseState"

require "states.main.StartState"
require "states.main.PlayState"
require "states.main.OverState"

require "states.objects.ObjectsFallState"

require "states.player.BasePlayerState"
require "states.player.PlayerIdleState"
require "states.player.PlayerRunState"
require "states.player.PlayerFallState"
require "states.player.PlayerJumpState"
require "states.player.PlayerHurtState"

require "states.blob.BlobIdleState"
require "states.blob.BlobChaseState"
require "states.blob.BlobDeadState"

require "states.goal.FlagLockedState"
require "states.goal.FlagUnlockedState"
require "states.goal.FlagAttainnedState"


-- Objects
App = require "objects.App"
require "objects.BaseObject"
require "objects.Avatar"
require "objects.Level"
require "objects.Tile"
require "objects.JumpBlock"
require "objects.Coin"
require "objects.TileTopper"
require "objects.Blob"
require "objects.Background"
require "objects.Goal"
require "objects.Flag"
