                                                                      Synopsis
------------------------------------------------------------------------------

Name
	Trader
Version
	v0.6.3 (2006-10-21)
Author
        Chris Olstrom
License
        Apache 2.0
Description
	A simple game of economics.
WWW
	http://colstrom.downloadspark.com/trader/

                                                                     Changelog
------------------------------------------------------------------------------

v0.0.0 - Skeleton
v0.0.1 - Added debugging for subroutine entry

v0.1.0 - Added command input
v0.1.1 - Added exit command.
v0.1.2 - Added debugging return values
v0.1.3 - Added debugging support to the debug routine

v0.2.0 - Added inventory

v0.3.0 - Added market

v0.4.0 - Added score
v0.4.1 - Inventory populates from market data

v0.5.0 - Added buy support

v0.6.0 - Added sell support
v0.6.1 - Market can adjust now
v0.6.2 - Improved market adjustment to rise, instead of linear fall
v0.6.3 - Improved appearance of score/inv/market


                                                                 Documentation
------------------------------------------------------------------------------

Explanation of version numbers, for those who question them.

vX.Y.Z
	X - Major version, for completion (1.0) and/or total overhauls.
	Y - Minor version, for features added
	Z - Patch version, for any tweaks.

The object of Trader is to make as much money as possible. All players start 
with $1000, and no materials. Buy and sell minerals to make money. Each time 
a turn ends, prices adjust on all minerals. The price variation can be up to 
a maximum of the value of the mineral, and is completely random. The more 
valuable a mineral is, the more subject it is to extreme fluctuations.

                                                                      Commands
------------------------------------------------------------------------------

help
	Will display help text when it exists.

exit
	Exits the game.

score
	Shows your score, in total resources held [TRH], and raw resources [$]

inv
	Displays your inventory, which contains any minerals you hold.

buy <mineral> <amount>
	Purchases <amount> of <mineral>, if you can afford to.

sell <mineral> <amount>
	Sells <amount> of <mineral>, if you have enough to sell.

market
	Begins a new turn, and displays the current status of the market.
