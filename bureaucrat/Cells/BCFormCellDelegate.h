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

@class BCAbstractFormCell;

@protocol BCFormCellDelegate <NSObject>

- (void)formCellWasFocused:(BCAbstractFormCell*)cell;

- (void)formCellLostFocus:(BCAbstractFormCell*)cell;

@end