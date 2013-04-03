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



#import "BCFormInputAccessoryView.h"
#import "BCFormInputAccessoryViewDelegate.h"


@implementation BCFormInputAccessoryView

+ (BCFormInputAccessoryView*)viewWithDelegate:(id<BCFormInputAccessoryViewDelegate>)delegate;
{
    BCFormInputAccessoryView* view = [[[self class] alloc] initWithFrame:CGRectMake(0.0, 0.0, 310.0, 40.0)];
    [view setAccessoryViewDelegate:delegate];
    return view;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBarStyle:UIBarStyleBlackOpaque];

        _previousButton = [[UIBarButtonItem alloc]
                initWithTitle:@"Prev" style:UIBarButtonItemStyleBordered target:self action:@selector(previousPressed)];

        _nextButton = [[UIBarButtonItem alloc]
                initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextPressed)];

        UIBarButtonItem* flexibleSpaceLeft =
                [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        _doneButton =
                [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed)];
        _doneButton.tintColor = [UIColor colorWithRed:0.639 green:0.831 blue:0.486 alpha:1.0];

        [self setItems:@[_previousButton, _nextButton, flexibleSpaceLeft, _doneButton]];
    }

    return self;
}

/* ============================================================ Private Methods ========================================================= */
- (void)donePressed
{
   [_accessoryViewDelegate didSelectDone];
}

- (void)previousPressed
{
    [_accessoryViewDelegate didSelectPreviousField];
}

- (void)nextPressed
{
    [_accessoryViewDelegate didSelectNextField];
}

- (void)setAccessoryViewDelegate:(id<BCFormInputAccessoryViewDelegate>)delegate
{
    _accessoryViewDelegate = delegate;
}

@end