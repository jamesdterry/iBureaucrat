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


#import "BCPasswordCell.h"


@implementation BCPasswordCell

/* ============================================================ Initializers ============================================================ */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [_textField setSecureTextEntry:YES];
        [self initChecker];
    }
    return self;
}


/* ========================================================== Interface Methods ========================================================= */
- (void)setAuthenticated:(BOOL)authenticated
{
    _checker.hidden = !authenticated;
    if (authenticated)
    {
        [_checker setHidden:NO];
        [self setUserInteractionEnabled:NO];
        [_textField resignFirstResponder];
    }
    else
    {
        [_checker setHidden:YES];
        [self setUserInteractionEnabled:YES];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGPoint myPosition = self.frame.origin;
    CGSize mySize = self.frame.size;
    _checker.frame = CGRectMake(myPosition.x + mySize.width - 85, 15, _checker.frame.size.width, _checker.frame.size.height);
}


/* ============================================================ Private Methods ========================================================= */
- (void)initChecker
{
    _checker = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green_checker"]];
    [_checker setBackgroundColor:[UIColor clearColor]];
    _checker.frame = CGRectMake(0, 0, 26, 18);
    _checker.hidden = YES;
    [self addSubview:_checker];
}

@end