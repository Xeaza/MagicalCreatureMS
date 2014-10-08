//
//  AttackViewController.h
//  MCMS
//
//  Created by Taylor Wright-Sanson on 10/8/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagicalCreature.h"

@interface AttackViewController : UIViewController

@property NSMutableArray *attackLineup;

@property MagicalCreature *opponentOne;
@property MagicalCreature *opponentTwo;

@end
