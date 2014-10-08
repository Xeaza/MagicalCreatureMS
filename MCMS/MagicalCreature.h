//
//  MagicalCreature.h
//  MCMS
//
//  Created by Taylor Wright-Sanson on 10/7/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MagicalCreature : NSObject

@property NSString *name;
@property NSString *weaponOfChoice;
@property UIImage *image;
@property NSMutableArray *accessories;

- (instancetype)initWithName:(NSString *)name;

@end
