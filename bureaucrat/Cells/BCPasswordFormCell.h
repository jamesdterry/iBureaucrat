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




#import <Foundation/Foundation.h>
#import "BCTextFieldFormCell.h"


@interface BCPasswordFormCell : BCTextFieldFormCell
{
    UIImageView* _checker;
}

- (void)setAuthenticated:(BOOL)authenticated;

@end