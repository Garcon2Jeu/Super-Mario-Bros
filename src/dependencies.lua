require "src.globals"

Class  = require "src.libraries.class"
Push   = require "src.libraries.push"
Timer  = require "src.libraries.knife.timer"

Assets = require "src.managers.AssetManager"
Quads  = require "src.managers.QuadManager"

require "src.components.Input"
require "src.components.GameObject"
require "src.components.GravityBundle"
require "src.components.MoveBundle"
require "src.components.Animation"
require "src.components.Hitbox"
require "src.components.Camera"
require "src.components.BaseMap"
require "src.components.Collidable"
require "src.components.Consummable"
require "src.components.ObjectStateMachine"

require "src.components.TileMap"
require "src.components.BlockMap"


App = require "src.App"
require "src.StateMachine"


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
