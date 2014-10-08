//
//  AttackViewController.m
//  MCMS
//
//  Created by Taylor Wright-Sanson on 10/8/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "AttackViewController.h"

@interface AttackViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *vsLabel;

@end

@implementation AttackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.opponentOne = [self.attackLineup objectAtIndex:0];
    self.opponentTwo = [self.attackLineup objectAtIndex:1];

    self.leftImage.image = self.opponentOne.image;
    self.rightImage.image = self.opponentTwo.image;
    
    self.leftTitleLabel.text = self.opponentOne.name;
    self.rightTitleLabel.text = self.opponentTwo.name;
}

- (void)viewWillAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionAutoreverse animations:^ {
        self.leftImage.center = CGPointMake(self.view.center.y - (self.leftImage.frame.size.height/2), self.leftImage.center.x);
        self.rightImage.center = CGPointMake(self.view.center.y + (self.rightImage.frame.size.height/2), self.rightImage.center.x);
    }
    completion:^(BOOL finished) {
        // get random number betwen 0 and 1
        double winner = drand48();
        if (winner < .5)
        {
            winner = 1;
            [self whoWon:1];
        }
        else
        {
            [self whoWon:0];
        }
    }];
}

- (void)whoWon:(int)winner
{
    MagicalCreature *winningCreature = [self.attackLineup objectAtIndex:winner];
    self.vsLabel.text = [NSString stringWithFormat:@"%@ WINS!", winningCreature.name];

    if ([winningCreature isEqual:self.opponentOne]) {

        [UIView animateWithDuration:1.0 animations:^{
            self.rightImage.hidden = YES;
            self.rightTitleLabel.hidden = YES;
        }];
    }
}

- (IBAction)onDoneButtonPressed:(id)sender
{
    self.opponentTwo = nil;
    self.opponentTwo = nil;
    self.leftImage = nil;
    self.rightTitleLabel = nil;
    self.leftTitleLabel = nil;
    self.rightImage = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
