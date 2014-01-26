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

@class BCTextFieldCell;


@interface BCDatePickerField : BCAbstractField <UITextFieldDelegate>
{
  UIDatePicker* _pickerView;
  BOOL _hasValue;
}

/**
 * The field used to display an option value - must return an NSString. If this value is nil, 'description' will be used.
 */
@property (nonatomic) SEL displayField;

- (BCTextFieldCell*)cell;


@end