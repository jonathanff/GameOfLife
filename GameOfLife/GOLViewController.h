//
//  ViewController.h
//  GameOfLife
//
//  Created by Jonathan Fuentes Flores on 10/30/14.
//  Copyright (c) 2014 Jonathan Fuentes Flores. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kGOLStartMutation;
extern NSString *const kGOLStopMutation;
extern NSString *const kGOLResetMutation;

@interface GOLViewController : UIViewController

@property (strong, nonatomic) NSMutableDictionary *gameBoard;
@property (strong, nonatomic) NSTimer *timer;

@end

