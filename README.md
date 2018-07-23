# Kirasu 1st Show

One Eyed Jacks  
July 21st, 2018

## installing libraries
You will need to install a few libraries

* controlp5
* processing movie
* [Gif](https://github.com/01010101/GifAnimation)
* minim*
* keystone (I made some edits to this one)

## controls

### play / pause

Press the space bar

### song change

To change to a different song hold ']' and a number / key specified below. Current set list (in order):

1 - "When the Moon Comes"  
2 - "Dirty"  
3 - "Fifty Fifty"  
4 - "Crush Proof"  
5 - "Cycles"  
6 - "WizRock"  
7 - "Violate Expectations"  
8 - "Mood \#2"  
9 - "Delta Waves"  
0 - "Song for M"  
'-' - "Ellon"  
'=' - "Rite of Spring"  
'q' - "Lollies"  
'w' - "Egrets"  

### projection surfaces

'c' to toggle the draggable edges  
's' to save the current surfaces

## editing cues

To add a cue to a song, first add a Cue object to the "cues" array inside of the init() functions below. A Cue is initialized with

* a timestamp (when the cue starts in the song)
* a type ('v' for visual, 'm' for movie, 'g' for gif, ...)
* for movies, the time in the movie that should start playing (or a 0 if it's a gif, etc.)
* for gifs, which number of the file in the "data/scenes/[name]/[number].gif" that should play

For example, the following movie will start playing when the song is at 28.2 seconds, and will start skip to 2.0 seconds into the video:

* cues[1] = new Cue(28.2, 'v', 2.0, 0);  

The following cue will play at 38 seconds. It will be gif "data/scenes/[name]/0.gif"

* cues[2] = new Cue(38, 'g', 0.0, 0);

If you want to play a video at any point during the song, it will have to be loaded with initVid("scenes/crush/movies/[name].mp4". I currently only have this working for one vid at a time, but can change this. See initCrush() for an example.

Once you've edited the cues in the init() functions, skip down to the display() functions. For a given cue (e.g. case 0 or the first cue), specify what you want to happen - check out displayCrush() for an example.

See the "testing()" function on the first tab for examples of other functions you can try.
