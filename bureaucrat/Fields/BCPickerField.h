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


@interface BCPickerField : BCAbstractField <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
{
    UIPickerView* _pickerView;
    NSMutableArray* _options;
    NSMutableArray* _option_codes;
    BOOL _hasValue;
    BOOL _shouldInitPicker;
    id<NSObject> _code;
}

/**
* The field used to display an option value - must return an NSString. If this value is nil, 'description' will be used.
*/
@property (nonatomic) SEL displayField;

- (BCTextFieldCell*)cell;

/**
 * Clear all options and codes.
 */
- (void)clearOptions;

/**
* Adds an option.
*/
- (void)addOption:(id<NSObject>)option;

/**
 * Adds an option with a code
 */
- (void)addOption:(id<NSObject>)option withCode:(id<NSObject>)codeß;

/**
* Adds options.
*/
- (void)addOptions:(NSArray*)options;

/**
* Sets options to the contents of the supplied array (erasing any previous options).
*/
- (void)setOptions:(NSArray*)options;

/**
 * Returns the selected/set code.
 */
- (id<NSObject>)code;

@end