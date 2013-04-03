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
#import "BCAbstractField.h"

@class BCTextFieldFormCell;
@class BCFormSection;

@interface BCTextField : BCAbstractField <UITextFieldDelegate>

@property(nonatomic, strong, readonly) UITextField* textField;


@end