////////////////////////////////////////////////////////////////////////////////
//
//  JASPER BLUES
//  Copyright 2013 Jasper Blues
//  All Rights Reserved.
//
//  NOTICE: Jasper Blues permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////



#import "BCForm.h"
#import "BCFormSection.h"
#import "BCColorScheme.h"


@implementation BCForm

/* ====================================================================================================================================== */
#pragma mark - Class Methods

+ (id)formWithColorScheme:(BCColorScheme*)colorScheme
{
    return [[self alloc] initWithColorScheme:colorScheme];
}


/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (id)initWithColorScheme:(BCColorScheme*)colorScheme;
{
    self = [super init];
    if (self)
    {
        _sections = [[NSMutableArray alloc] init];
        _colorScheme = colorScheme;
    }
    return self;
}

- (id)init
{
    return [self initWithColorScheme:[BCColorScheme defaultColorScheme]];
}

/* ====================================================================================================================================== */
#pragma mark - Interface Methods

- (NSArray*)sections
{
    return [_sections copy];
}

- (BCFormSection*)addSection:(BCFormSection*)section
{
    section.parent = self;
    [_sections addObject:section];
    return section;
}

- (void)build
{

}

/* ====================================================================================================================================== */
#pragma mark - Utility Methods

- (NSString*)description
{
    NSMutableString* description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.sections=%@", self.sections];
    [description appendString:@">"];
    return description;
}


@end