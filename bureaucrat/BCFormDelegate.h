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

#import <Foundation/Foundation.h>
#import "BCInputAccessoryDelegate.h"

@class BCAbstractField;

@protocol BCFormDelegate <BCInputAccessoryDelegate>

- (void)fieldReceivedFocus:(BCAbstractField*)field;

- (void)fieldLostFocus:(BCAbstractField*)field;

@end