# Inspiration

Looking at the incredible flutter community and what people have done and achieved was the sole inspiration for us to implement something unique and try and learn something new and different, at least something we have not done before and maybe even give back to the flutter community.


# What it does

It’s a standard sliding puzzle with a twist.

We wanted to make a **3D puzzle** game that looked beautiful and that had a soothing atmosphere. That way we could have an interesting terrain and an interesting game mechanic.

This is a sliding puzzle game where we have pillars instead of tiles of varying height to be sorted in a particular order. 

The idea is to solve the **3D puzzle** based on the height of the pillars.
Hence the name **Slide Z (pronounced: Slide Zee)**

We are displaying **Voxel **models created in magicavoxel for some of the environment.

We are using Mind AR to run the app in **AR mode**.

**Inputs:**

**View controls:** we can view the board from any angle using the gyro, touch input or mouse coordinates and keyboard.

**Pillar Controls:** we can move the pillars by touching the desired block to be moved via mouse, touch or use the keyboard arrow keys

The game can be played in 3D or AR modes.

**3D:** here gyro would be used to allow the player to view the board from any angles to identify the pillar of various heights.

**AR:** here the player can move freely around the board instead of being restricted by the screen space, giving a whole new level of immersion into the game, allowing the player to better differentiate the various block heights.

The terrain would be auto generated with various elements, with a good looking and well sounding environment.


# How we built it

Instead of tiles, we would have pillars/blocks that we wanted the puzzle to be sorted by height.The player would be able to view the board from any angle, and he would be able to play the game in 3D and in AR using touch and gyro controls or keyboard and mouse controls.

## 3DCube:



* We started by building a simple 3D cube, for this we used a square widget and transformed and rotated it from its center for each side of a cube.

	



* We placed objects in 3d space.on a 3x3 grid. We started experimenting with cuboids of varying sizes and heights.
* Since this **cuboid is made up of faces which is a widget** we can place anything on the face, e.g. images or custom shapes etc.

These cubes would be the main pillars of the game.

## AR:

Since the puzzle was based on height we wanted the player to view the board from any angle, so we wanted to give AR as an option.

This would be Implemented on android and ios.



* To achieve this we needed an AR framework that allowed us to place flutter widgets on top of it.
* We found Mind AR as a good solution.
* So we hosted Mind AR in Web view on flutter and retrieved the transform positions from there and parsed their position data. We could then use this position data to transform our flutter widgets ie the platform and the pillars onto it.
* As a result **we can place any widget on the AR space**

## Voxels:

We wanted to try adding various elements or models into the game that would make it look better and make it easier to add whatever we wanted.



* So we tried exploring with voxels
* We built a simple voxel model viewer and a parser that would allow us to **import and display (.VOX) voxel models (from magicavoxel) as widgets in flutter**.
* This allowed us to create interesting levels and variations.


# Challenges we ran into

We ran into a lot of issues and challenges during the development of this game.

## 3DCubes:

While making the 3D  cubes the main issue was to avoid the widgets clipping into each other.



* So Identifying the draw order based on the perspective was the way to go.
* We Calculate the distance between the player camera and each of the cubes widgets and sort them based on what is furthest from the camera. Anything far would be drawn first and anything near would be drawn last.
* This is done for each side of the cube and for all 8 cubes.
* Also to save on performance we would avoid drawing the bottom face of the cube.

## AR:

We found no proper AR plugin in flutter that satisfied our needs.



* So we had to build a custom solution for the game, therefore we used Mind AR.
* Also we had to find a way to send the position and translate their position data into one that could be easily worked on by us on the flutter side.
* Accurately drawing and transforming flutter widgets onto the given position data was challenging. 

## Voxels:



* There were no packages that could parse magicavoxel models on flutter so we had to build our own parser on flutter.
* Parsing the .VOX models proved challenging and once we did, drawing so many cubes resulted in horrible performance. We had to find a way to save on performance.
* We implemented a greedy meshing algorithm to combine similar blocks into a single block, this helps a lot in improving performance.


# Accomplishments that we’er proud of

We are happy with what we were able to learn, implement and achieve in the past couple of days during the competition.

We implemented 3D, Voxels and AR in flutter! For us it was an exhilarating experience.

All the packages we have made will be published on pub.dev


# What we Learnt

Got to learn new things in implementing 3D widgets, Voxels and AR  in flutter would love to explore more and build on what we have achieved .


# What’s next for Slide Z

Make more levels for the game.

Complete the AR plugin (DreamXR package) and release the package

For Voxels better optimisations, more features and implement a complete robust voxel engine in flutter.

We plan to release a complete voxel engine package for flutter soon.

All the packages we have made will be published on pub.dev

## Try out [https://slidez.dsi.dev/](https://slidez.dsi.dev/)

## thank you for the wonderful opportunity ! 
