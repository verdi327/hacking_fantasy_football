hacking_fantasy_football
========================

## What is this?

I wanted to know what the optimal draft strategy would have been during the 2013 season if I knew who the top scorers on season were.

This is not as easy as just picking the top scoring QB, RB, WR etc... because when I draft, those players may not be available.

Therefore, there is no 1 optimal draft strategy but 12 (or how ever many members there are in you FF league).

## Where is the data from?

I used data provided by ESPN.  In particular I used...

#### Avg Draft Order List
This is an aggregation of all the drafts held on ESPN.  They determined the top 200 most drafted players.

## How To Use

To run the simulation, go into the draft_simulator.rb file and update how many ppl are in your league and at which position you will be drafting in.

For example, if in your league their are 12 players and you are drafting at the 5th spot, you would call the following

`league = League.new(12,5)`

Then just run the file

`ruby draft_simulator.rb`


