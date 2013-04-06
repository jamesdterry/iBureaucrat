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
#import "BCInputAccessoryDelegate.h"


@implementation BCForm

/* =========================================================== Class Methods ============================================================ */
+ (id)formWithCellColor:(UIColor*)cellColor selectedCellColor:(UIColor*)selectedCellColor sectionTitleColor:(UIColor*)sectionTitleColor
        textColor:(UIColor*)textColor selectedTextColor:(UIColor*)selectedTextColor;
{
    return [[self alloc]
            initWithCellColor:cellColor selectedCellColor:selectedCellColor sectionTitleColor:sectionTitleColor textColor:textColor
            selectedTextColor:selectedTextColor];
}


/* ============================================================ Initializers ============================================================ */
- (id)initWithCellColor:(UIColor*)cellColor selectedCellColor:(UIColor*)selectedCellColor sectionTitleColor:(UIColor*)sectionTitleColor
        textColor:(UIColor*)textColor selectedTextColor:(UIColor*)selectedTextColor
{
    self = [super init];
    if (self)
    {
        _sections = [[NSMutableArray alloc] init];
        _cellColor = cellColor;
        _selectedCellColor = selectedCellColor;
        _sectionTitleColor = sectionTitleColor;
        _textColor = textColor;
        _selectedTextColor = selectedTextColor;
    }
    return self;
}

- (id)init
{
    return [self initWithCellColor:[UIColor whiteColor] selectedCellColor:[UIColor colorWithRed:0.639 green:0.831 blue:0.486 alpha:1.0]
            sectionTitleColor:[UIColor colorWithRed:0.639 green:0.831 blue:0.486 alpha:1.0] textColor:[UIColor darkGrayColor]
            selectedTextColor:[UIColor colorWithRed:51 green:51 blue:51 alpha:1.0]];
}

/* ========================================================== Interface Methods ========================================================= */
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


/* ============================================================ Utility Methods ========================================================= */
- (NSString*)description
{
    NSMutableString* description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.sections=%@", self.sections];
    [description appendString:@">"];
    return description;
}


@end