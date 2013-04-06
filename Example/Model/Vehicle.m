////////////////////////////////////////////////////////////////////////////////
//
//  INFRAXIS
//  Copyright 2013 Infraxis
//  All Rights Reserved.
//
//  NOTICE: Infraxis permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import "Vehicle.h"


@implementation Vehicle

+ (id)vehicleWithName:(NSString*)name traits:(NSString*)traits
{
    return [[self alloc] initWithName:name traits:traits];
}

- (id)initWithName:(NSString*)name traits:(NSString*)traits
{
    self = [super init];
    if (self)
    {
        _name = name;
        _traits = traits;
    }
    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ - (%@)", _name, _traits];
}

@end