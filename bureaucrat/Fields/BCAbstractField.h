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
#import "BCCellDelegate.h"

@class BCDefaultInputAccessory;
@class BCAbstractCell;
@class BCFormSection;

/**
* This is a base class that it designed to be extended to add new types of form fields. The key method to implement is:
*
* -createCell Sub-classes must return an instance of BCAbstractCell.
*/
@interface BCAbstractField : NSObject<BCCellDelegate>
{
    BCAbstractCell* _cell;

    UIColor* _cellColor;
    UIColor* _selectedCellColor;
    UIColor* _sectionTitleColor;
    UIColor* _textColor;
    UIColor* _selectedTextColor;

    id<NSObject> _value;
}


/**
* The section that owns this field.
*/
@property(nonatomic, weak) BCFormSection* section;

/**
* Label for the field.
*/
@property(nonatomic, strong, readonly) NSString* label;

/**
* Overrides the property in BCForm or BCFormSection, for this specific field.
*/
@property(nonatomic, strong) UIColor* cellColor;

/**
* Overrides the property in BCForm or BCFormSection, for this specific field.
*/
@property(nonatomic, strong) UIColor* selectedCellColor;

/**
* Overrides the property in BCForm or BCFormSection, for this specific field.
*/
@property(nonatomic, strong) UIColor* sectionTitleColor;

/**
* Overrides the property in BCForm or BCFormSection, for this specific field.
*/
@property(nonatomic, strong) UIColor* textColor;

/**
* Overrides the property in BCForm or BCFormSection, for this specific field.
*/
@property(nonatomic, strong) UIColor* selectedTextColor;

/**
* Sets whether the field is writable or readonly.
*/
@property(nonatomic) BOOL editable;

#pragma mark - Factory methods

+ (id)fieldWithLabel:(NSString*)label;

+ (id)fieldWithLabel:(NSString*)label cellColor:(UIColor*)cellColor selectedCellColor:(UIColor*)selectedCellColor
        sectionTitleColor:(UIColor*)sectionTitleColor;

- (id)initWithLabel:(NSString*)label cellColor:(UIColor*)cellColor selectedCellColor:(UIColor*)selectedCellColor
        sectionTitleColor:(UIColor*)sectionTitleColor;

/**
* Returns the created cell instance.
* @see createCellInstance
*/
- (BCAbstractCell*)cell;

#pragma mark - Abstract methods

/**
* The key method to be implemented by sub-classes. This is the appropriate place to also specify a custom input view. To do this set
* `cell.textField.inputView = <your input view>` . . . this of course requires a text-field to capture the input, but the text field need
* not be a visible part of the cell.
*/
- (BCAbstractCell*)createCellInstance;

/**
* Returns the selected/set value as a string.
*/
- (NSString*)textValue;

/**
* Returns the selected/set value.
*/
- (id<NSObject>)value;

/**
* Sets the value.
*/
- (void)setValue:(id<NSObject>)value;

@end