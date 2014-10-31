//
//  CellButton.h
//  GameOfLife
//
//  Created by Jonathan Fuentes Flores on 10/30/14.
//  Copyright (c) 2014 Jonathan Fuentes Flores. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSInteger cellSize = 20;

@interface CellButton : UIButton

@property BOOL alive;
@property BOOL futureAlive;

@property (strong, nonatomic) NSDictionary *boardCellPositions;

@end
