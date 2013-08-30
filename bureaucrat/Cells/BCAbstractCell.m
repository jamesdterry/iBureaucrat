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


#import "BCAbstractCell.h"
#import "BCCellDelegate.h"
#import "BCAbstractField.h"


@implementation BCAbstractCell

/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    return [self init];
}

/* ====================================================================================================================================== */
#pragma mark - Interface Methods

- (void)setFocused:(BOOL)focused
{
    if (focused)
    {
        [self setBackgroundColor:_field.selectedCellColor];
        [[self textLabel] setTextColor:_field.selectedTextColor];
        [_delegate formCellWasFocused:self];
    }
    else
    {
        [self setBackgroundColor:_field.cellColor];
        [[self textLabel] setTextColor:_field.textColor];
        if (_focused)
        {
            [_delegate formCellLostFocus:self];
        }
    }
    _focused = focused;
}

- (UITextField*)textField
{
    return nil;
}


- (CGFloat)preferredHeight
{
    return 44.0;
}



@end