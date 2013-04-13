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



#import "FundsTransferView.h"
#import "BCFormView.h"
#import "CKUITools.h"


@implementation FundsTransferView

/* ============================================================ Initializers ============================================================ */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initBackground];
        [self initFormView];
        [self initNavigationBar];
    }
    return self;
}

/* ========================================================== Interface Methods ========================================================= */
- (void)layoutSubviews
{
    [super layoutSubviews];
    _backgroundView.frame = self.bounds;
    _navigationBar.width = self.width;
    _formView.frame = CGRectMake(0, 50, self.width, self.height - 60);
    NSLog(@"Formview frame: %@", NSStringFromCGRect(_formView.frame));
}


/* ============================================================ Private Methods ========================================================= */
- (void)initBackground
{
    _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background-gradient"]];
    [self addSubview:_backgroundView];
}

- (void)initNavigationBar
{
    _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _navigationBar.barStyle = UIBarStyleBlackTranslucent;

    UINavigationItem* navigationItem = [UINavigationItem alloc];
    navigationItem.title = @"Funds Transfer";
    [_navigationBar pushNavigationItem:navigationItem animated:false];
    [self addSubview:_navigationBar];

    UIBarButtonItem* doneButton =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(goPressed)];
    [doneButton setTintColor:[UIColor colorWithRed:0.639 green:0.831 blue:0.486 alpha:1.0]];
    navigationItem.rightBarButtonItem = doneButton;
}

- (void)initFormView
{
    _formView = [[BCFormView alloc] initWithFrame:CGRectZero];
    [self addSubview:_formView];
}

- (void)goPressed
{
    NSLog(@"Go pressed! Hook me up to a block or delegate");
}

@end