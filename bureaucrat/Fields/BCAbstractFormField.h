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
#import "BCFormCellDelegate.h"

@class BCFormInputAccessoryView;
@class BCAbstractFormCell;
@class BCFormSection;


@interface BCAbstractFormField : NSObject<BCFormCellDelegate>
{
    BCAbstractFormCell* _cell;

    UIColor* _cellColor;
    UIColor* _selectedCellColor;
    UIColor* _sectionTitleColor;
    UIColor* _textColor;
    UIColor* _selectedTextColor;
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

#pragma mark - Abstract methods

- (BCAbstractFormCell*)createCellInstance;

- (BCAbstractFormCell*)cell;

- (NSString*)textValue;

- (void)setValue:(NSString*)value;

@end