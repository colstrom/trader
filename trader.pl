#!/usr/bin/env perl

#######################################
# Trader, a simple game of economics. #
#######################################
#
# Copyright (C) 2006 Chris Olstrom
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
#######################################

use warnings;
use strict;

# Settings

our $APPNAME = 'Trader';
our $VERSION = '0.6.3';
our $RELEASEDATE = '20061021';

our $DEBUG_LEVEL = 0;

our ( %inventory,%market,$resources );

# Core

Setup_All();
Main();
Exit();

# Initial setup

sub Setup_All {
	DebugMessage(1,"Setup_All(@_);");

	my $errorCount = 0;
	$errorCount += Setup_Market();
	$errorCount += Setup_Inventory();

	DebugMessage(2,$errorCount);
	return $errorCount;
}

sub Setup_Inventory {
	DebugMessage(1,"Setup_Inventory(@_);");
	
	$resources			= 1000;

	foreach my $item ( keys %market ) {
		$inventory{$item} = 0;
	}

	DebugMessage(2,0);
	return 0;
}

sub Setup_Market {
	DebugMessage(1,"Setup_Market(@_);");

	$market{'Stone'}	= 2;
	$market{'Wood'}		= 6;
	$market{'Iron'}		= 10;
	$market{'Steel'}	= 18;
	$market{'Silver'}	= 22;
	$market{'Gold'}		= 54;
	$market{'Platinum'}	= 58;
	$market{'Diamond'}	= 162;

	DebugMessage(2,0);
	return 0;
}

sub Example {
	DebugMessage(1,"Example(@_);");

	DebugMessage(2,0);
	return 0;
}
# Main Routine

sub Main {
	DebugMessage(1,"Main(@_);");

	my $command = '';
	while ( $command ne 'exit' ) {
		$command = GetInput('Command');
		if ( ValidateCommand($command) == 1 ) {
			if ( $command eq 'help' ) { Help(); }
			if ( $command eq 'version' ) { Version(); }
			if ( $command eq 'inv' ) { Inventory(); }
			if ( $command eq 'score' ) { Score(); }
			if ( $command eq 'market' ) { MarketAdjust(); MarketShow(); }
			if ( $command =~ m/^buy (.+) (.+)$/i ) { Buy($1,$2); }
			if ( $command =~ m/^sell (.+) (.+)$/i ) { Sell($1,$2); }
		}
	}
	
	DebugMessage(2,0);
	return 0;
}

# In-Game Functions

sub MarketAdjust {
	DebugMessage(1,"Adjust_Market(@_);");

	foreach my $item ( keys %market ) {
		my $adjustment = int(rand($market{$item}));
		if ( int(rand(2)) == 1 ) {
			$adjustment *= -1;
		}
		$market{$item} += $adjustment;
	}

	DebugMessage(2,0);
	return 0;
}

sub MarketShow {
	DebugMessage(1,"Adjust_Market(@_);");

	print "\n---- Market ----";
	foreach my $item ( keys %market ) {
		print "\n$item\t$market{$item}";
	}
	print "\n";

	DebugMessage(2,0);
	return 0;
}

# Commands

sub Buy {
	DebugMessage(1,"Buy(@_);");
	my ( $item,$units) = @_;

	my $cost = $market{$item} * $units;
	if ( $cost <= $resources ) {
		$resources -= $cost;
		$inventory{$item} += $units;
		print "\n(BUY) Purchased $units $item at $cost ( $market{$item} each ).\n";
	} else {
		print "\n(BUY) Cannot afford transaction.\n";
	}

	DebugMessage(2,$cost);
	return $cost;
}

sub Exit {
	DebugMessage(1,"Exit(@_);");

	print "\nApplication terminated.\n";
	exit;
}

sub Help {
	DebugMessage(1,"Help(@_);");
}

sub Inventory {
	DebugMessage(1,"Inventory(@_);");

	my @inventory_i	= keys %inventory;
	my @inventory_a	= values %inventory;
	print "\n---- Inventory ----";
	for ( my $counter = 0; $counter < @inventory_i; $counter++ ) {
		print "\n$inventory_i[$counter]\t$inventory_a[$counter]";
	}
	print "\n";
}

sub Score {
	DebugMessage(1,"Score(@_);");

	my $score = $resources;
	print "\n---- Score ----\n".'[$$$]'."\t $score";
	foreach my $item ( keys %inventory ) {
		$score += $market{$item} * $inventory{$item};
	}
	print "\n".'[TRH]'."\t $score\n";

	DebugMessage(2,$score);
	return $score;
}

sub Sell {
	DebugMessage(1,"Sell(@_);");
	my ( $item,$units) = @_;

	my $cost = $market{$item} * $units;
	if ( $units <= $inventory{$item} ) {
		$inventory{$item} -= $units;
		$resources += $cost;
		print "\n(SELL) Sold $units $item at $cost ( $market{$item} each ).\n";
	} else {
		print "\n(SELL) Insufficient units for transaction.\n";
	}

	DebugMessage(2,$cost);
	return $cost;
}

sub Version {
	DebugMessage(1,"Version(@_);");
	print "\n $APPNAME $VERSION ( $RELEASEDATE ) \n";
}

# Command input and validation

sub GetInput {
	DebugMessage(1,"GetInput(@_);");
	my ( $prompt ) = @_;

	print "\n$prompt: ";
		my $input = <STDIN>;
	chomp $input;

	DebugMessage(2,$input);
	return $input;
}

sub ValidateCommand {
	DebugMessage(1,"ValidateCommand(@_);");
	my $command = @_;
	
	my $isValidCommand = 1;
	DebugMessage(2,$isValidCommand);
	return $isValidCommand;
}

# Debugging
# 0 - None
# 1 - Subroutine calls and arguments
# 2 - Return values
# 8 - Verbosity increased
# 9 - Debug debugging code

sub DebugMessage {
	print "DebugMessage(@_);" unless ( $DEBUG_LEVEL < 9 );
	my ($threshold,$message) = @_;

	if ( $DEBUG_LEVEL >= 8 ) {
		if ( $threshold == 1 ) { $message = 'SUB__'.$message; }
		if ( $threshold == 2 ) { $message = 'RET__'.$message; }
	}
	print "$message\t" unless ( $DEBUG_LEVEL < $threshold) ;

	print $DEBUG_LEVEL unless ( $DEBUG_LEVEL < 9 );
	return $DEBUG_LEVEL;
}


