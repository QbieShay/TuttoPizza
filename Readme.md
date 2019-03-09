# Game architecture

## Flow:

Game starts with main scene. 
From the main scene, a small intro is played and then we proceed to the game scene.  
The game scene is the 3D scene with the monitor.  
The monitor has a system (VirtualOS/Screen.gd) that control what is displayed by it.   
At the moment two scenes are instanced one after the other:
First the 'boot' scene, and then the `res://VirtualOS/Desktop/Desktop.tscn`. 

The desktop scene is the one where the whole 2D game will live.

### Main menu

All starts from here.

### Intro

A scene to play the introduction of the game

### VirtualDesk

The 3D scene that contains the desk with the computer. 

### Boot

The booting scene of the virtual pc.

### Desktop

The scene where all the 2D part of the game takes place.