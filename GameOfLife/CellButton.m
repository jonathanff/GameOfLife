//
//  CellButton.m
//  GameOfLife
//
//  Created by Jonathan Fuentes Flores on 10/30/14.
//  Copyright (c) 2014 Jonathan Fuentes Flores. All rights reserved.
//

#import "CellButton.h"
#import "GOLViewController.h"
#import "UIColor+GOLColors.h"

@implementation CellButton

- (id)initWithFrame:(CGRect)frame;
{
    if (self = [super initWithFrame:frame]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(startMutation)
                                                     name:kGOLStartMutation
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(stopMutation)
                                                     name:kGOLStopMutation
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(resetMutation)
                                                     name:kGOLResetMutation
                                                   object:nil];
        
        //Configure the style of the cell
        self.backgroundColor = [UIColor GOLPurple];
        self.layer.borderColor = [UIColor yellowColor].CGColor;
        self.layer.borderWidth = 0.3;
    }
    
    return self;
}

- (void)dealloc;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)startMutation;
{
    //Start looking for living neighbors cells
    NSUInteger livingNeighbors = 0;
    CGPoint cellPosition = self.frame.origin;
    
    if ([self.boardCellPositions[[NSValue valueWithCGPoint:CGPointMake(cellPosition.x - cellSize, cellPosition.y - cellSize)]] alive])
        livingNeighbors++;
    
    if ([self.boardCellPositions[[NSValue valueWithCGPoint:CGPointMake(cellPosition.x, cellPosition.y - cellSize)]] alive])
        livingNeighbors++;
    
    if ([self.boardCellPositions[[NSValue valueWithCGPoint:CGPointMake(cellPosition.x + cellSize, cellPosition.y - cellSize)]] alive])
        livingNeighbors++;
    
    if ([self.boardCellPositions[[NSValue valueWithCGPoint:CGPointMake(cellPosition.x - cellSize, cellPosition.y)]] alive])
        livingNeighbors++;
    
    if ([self.boardCellPositions[[NSValue valueWithCGPoint:CGPointMake(cellPosition.x + cellSize, cellPosition.y)]] alive])
        livingNeighbors++;
    
    if ([self.boardCellPositions[[NSValue valueWithCGPoint:CGPointMake(cellPosition.x - cellSize, cellPosition.y + cellSize)]] alive])
        livingNeighbors++;
    
    if ([self.boardCellPositions[[NSValue valueWithCGPoint:CGPointMake(cellPosition.x, cellPosition.y + cellSize)]] alive])
        livingNeighbors++;
    
    if ([self.boardCellPositions[[NSValue valueWithCGPoint:CGPointMake(cellPosition.x + cellSize, cellPosition.y + cellSize)]] alive])
        livingNeighbors++;
    
    //Apply the rules of the game
    if (self.alive) {
        if (livingNeighbors < 2 || livingNeighbors > 3) {
            self.futureAlive = NO;
        } else if (livingNeighbors == 2 || livingNeighbors == 3) {
            self.futureAlive = YES;
        }
    } else if (livingNeighbors == 3) {
        self.futureAlive = YES;
    }
}

- (void)stopMutation;
{
    self.alive = self.futureAlive;
    self.futureAlive = NO;
    [self updateUI];
}

- (void)resetMutation;
{
    self.alive = NO;
    self.futureAlive = NO;
    [self updateUI];
}

- (void)updateUI;
{
    self.selected = self.alive;
    
    if (self.alive) {
        self.backgroundColor = [UIColor GOLOrange];
    } else {
        self.backgroundColor = [UIColor GOLPurple];
    }
}

@end
