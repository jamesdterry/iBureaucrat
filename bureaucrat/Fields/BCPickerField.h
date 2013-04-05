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


@interface BCPickerField : BCAbstractField <UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView* _pickerView;
    NSMutableArray* _options;
    BOOL _hasValue;
}

/**
* The field used to display an option value - must return an NSString. If this value is nil, 'description' will be used.
*/
@property (nonatomic) SEL displayField;

- (BCTextFieldFormCell*)cell;

/**
* Adds an option.
*/
- (void)addOption:(id<NSObject>*)option;

/**
* Adds options.
*/
- (void)addOptions:(NSArray*)options;

/**
* Sets options to the contents of the supplied array (erasing any previous options).
*/
- (void)setOptions:(NSArray*)options;

@end