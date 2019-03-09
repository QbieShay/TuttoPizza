# Repository guide

1. Nobody is allowed to push to master, pull request workflow is required

# Game architecture

## Flow:

Game starts with main scene. 
From the main scene, a small intro is played and then we proceed to the game scene.
The game scene is the 3D scene with the monitor.
The monitor has a system (VirtualOS/Screen.gd) that control what is displayed by it. 
At the moment two scenes are instanced one after the other:
First the 'boot' scene, and then the `res://VirtualOS/Desktop/Desktop.tscn`. 

The desktop scene is the one where the whole 2D game will live.