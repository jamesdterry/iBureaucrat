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

@class BCFormView;
@class BCAbstractField;
@class BCForm;


@interface BCFormSection : NSObject
{
    __weak BCForm* _parent;
    NSMutableArray* _fields;

    UIColor* _cellColor;
    UIColor* _selectedCellColor;
    UIColor* _sectionTitleColor;
    UIColor* _textColor;
    UIColor* _selectedTextColor;
}

@property(nonatomic, weak) BCForm* parent;
@property(nonatomic, strong, readonly) NSString* title;

/**
* Overrides the property in BCForm, for this specific section, if not set returns the BCForm's corresponding property.
*/
@property(nonatomic, strong) UIColor* cellColor;

/**
* Overrides the property in BCForm, for this specific section, if not set returns the BCForm's corresponding property.
*/
@property(nonatomic, strong) UIColor* selectedCellColor;

/**
* Overrides the property in BCForm, for this specific section, if not set returns the BCForm's corresponding property.
*/
@property(nonatomic, strong) UIColor* sectionTitleColor;

/**
* Overrides the property in BCForm, for this specific section, if not set returns the BCForm's corresponding property.
*/
@property(nonatomic, strong) UIColor* textColor;

/**
* Overrides the property in BCForm, for this specific section, if not set returns the BCForm's corresponding property.
*/
@property(nonatomic, strong) UIColor* selectedTextColor;



+ (id)sectionWithTitle:(NSString*)title;

+ (id)sectionWithTitle:(NSString*)title cellColor:(UIColor*)cellColor selectedCellColor:(UIColor*)selectedCellColor
        sectionTitleColor:(UIColor*)sectionTitleColor;


- (NSArray*)fields;

- (void)addField:(BCAbstractField*)field;

- (void)addFields:(NSArray*)fields;

@end