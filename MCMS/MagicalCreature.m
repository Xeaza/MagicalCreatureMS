//
//  MagicalCreature.m
//  MCMS
//
//  Created by Taylor Wright-Sanson on 10/7/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "MagicalCreature.h"

@implementation MagicalCreature

- (instancetype)init
{
    [NSException raise:NSInvalidArgumentException format:@"Magcal Creature must have a name, call initWithName:"];
    return nil;
}

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self)
    {
        if (name.length == 0)
        {
            [NSException raise:NSInvalidArgumentException format:@"Magcal Creature must have a name, call initWithName:"];
        }
        self.name = name;
        self.accessories = [[NSMutableArray alloc] init];
    }
    return self;
}


@end
