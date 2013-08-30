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



#import "BCFormSection.h"
#import "BCAbstractField.h"
#import "BCForm.h"
#import "BCColorScheme.h"


@implementation BCFormSection

/* ====================================================================================================================================== */
#pragma mark - Class Methods

+ (id)sectionWithTitle:(NSString*)title
{
    return [[self alloc] initWithTitle:title cellColor:nil selectedCellColor:nil sectionTitleColor:nil];
}

+ (id)sectionWithTitle:(NSString*)title cellColor:(UIColor*)cellColor selectedCellColor:(UIColor*)selectedCellColor
        sectionTitleColor:(UIColor*)sectionTitleColor
{
    return [[self alloc] initWithTitle:title cellColor:cellColor selectedCellColor:selectedCellColor sectionTitleColor:sectionTitleColor];
}

/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (id)initWithTitle:(NSString*)title cellColor:(UIColor*)cellColor selectedCellColor:(UIColor*)selectedCellColor
        sectionTitleColor:(UIColor*)sectionTitleColor
{
    self = [super init];
    if (self)
    {
        _fields = [[NSMutableArray alloc] init];
        _title = title;
        _cellColor = cellColor;
        _selectedCellColor = selectedCellColor;
        _sectionTitleColor = sectionTitleColor;
    }
    return self;
}

/* ====================================================================================================================================== */
#pragma mark - Interface Methods

- (NSArray*)fields
{
    return [_fields copy];
}

- (void)addField:(BCAbstractField*)field
{
    [field setSection:self];
    [_fields addObject:field];
}

- (void)addFields:(NSArray*)fields
{
    for (BCAbstractField* field in fields)
    {
        [self addField:field];
    }
}

- (BCForm*)parent
{
    return _parent;
}

- (void)setParent:(BCForm*)parent
{
    _parent = parent;
}


/* ====================================================================================================================================== */
#pragma mark - Override

- (UIColor*)cellColor
{
    return _cellColor == nil ? [_parent.colorScheme cellColor] : _cellColor;
}

- (UIColor*)selectedCellColor
{
    return _selectedCellColor == nil ? [_parent.colorScheme selectedCellColor] : _cellColor;
}

- (UIColor*)sectionTitleColor
{
    return _sectionTitleColor == nil ? [_parent.colorScheme sectionTitleColor] : _sectionTitleColor;
}

- (UIColor*)textColor
{
    return _textColor == nil ? [_parent.colorScheme defaultTextColor] : _textColor;
}

- (UIColor*)selectedTextColor
{
    return _selectedTextColor == nil ? [_parent.colorScheme selectedTextColor] : _selectedTextColor;
}


/* ====================================================================================================================================== */
#pragma mark - Utility Methods

- (NSString*)description
{
    return [NSString stringWithFormat:@"BCForm Section: title=%@", _title];
}


@end