//
//  ViewController.m
//  GameOfLife
//
//  Created by Jonathan Fuentes Flores on 10/30/14.
//  Copyright (c) 2014 Jonathan Fuentes Flores. All rights reserved.
//

#import "GOLViewController.h"
#import "CellButton.h"
#import "UIColor+GOLColors.h"

NSString *const kGOLStartMutation = @"startMutating";
NSString *const kGOLStopMutation = @"stopMutating";
NSString *const kGOLResetMutation = @"resetMutation";

@interface GOLViewController ()

@property (strong, nonatomic) IBOutlet UIView *boardView;
@property (strong, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation GOLViewController

- (void)viewDidLoad;
{
    [super viewDidLoad];
    
    // Get the number of columns and rows depending on the screen size
    NSInteger columnsNumber = self.view.frame.size.width / cellSize + 1;
    NSInteger rowsNumber = self.view.frame.size.height / cellSize + 1;
    
    //Create the necessary cellButton to fill the screen
    self.gameBoard = [[NSMutableDictionary alloc] init];
    for (int rowsCounter = 0; rowsCounter < rowsNumber; rowsCounter++) {
        for (int columnsCounter = 0; columnsCounter < columnsNumber; columnsCounter++) {
            CellButton *cellButton = [[CellButton alloc] initWithFrame:CGRectMake(cellSize * columnsCounter,
                                                                                  cellSize * rowsCounter,
                                                                                  cellSize,
                                                                                  cellSize)];

            [cellButton addTarget:self action:@selector(updateCellState:) forControlEvents:UIControlEventTouchUpInside];
            [self.gameBoard setObject:cellButton forKey:[NSValue valueWithCGPoint:cellButton.frame.origin]];
            cellButton.boardCellPositions = self.gameBoard;
            [self.boardView addSubview:cellButton];
        }
    }
}

- (void)didReceiveMemoryWarning;
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startGame;
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(startMutating) userInfo:nil repeats:YES];
}

- (void)stopGame;
{
    [self.timer invalidate];
}

- (void)startMutating;
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGOLStartMutation object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kGOLStopMutation object:nil];
}

- (void)updateCellState:(CellButton *)button;
{
    button.selected = !button.selected;
    
    if (button.selected) {
        button.backgroundColor = [UIColor GOLOrange];
        button.alive = YES;
    } else {
        button.backgroundColor = [UIColor GOLPurple];
        button.alive = NO;
    }
}

#pragma mark - IBOutlets
- (IBAction)resetBoard:(id)sender;
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGOLResetMutation object:nil];
}

- (IBAction)changeState:(id)sender;
{
    UIButton *startButton = (UIButton *)sender;
    startButton.selected = !startButton.selected;
    
    if (startButton.selected) {
        [startButton setTitle:@"Stop" forState:UIControlStateSelected];
        [self startGame];
    } else if (!startButton.selected) {
        [startButton setTitle:@"Start" forState:UIControlStateNormal];
        [self stopGame];
    }
}

- (BOOL)prefersStatusBarHidden;
{
    return YES;
}

@end
