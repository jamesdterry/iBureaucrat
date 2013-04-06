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

@class BCFormSection;
@class BCFormView;
@class BCDefaultInputAccessory;
@protocol BCInputAccessoryDelegate;
@protocol BCFormDelegate;


@interface BCForm : NSObject
{
    NSMutableArray* _sections;
    UIColor* _cellColor;
    UIColor* _selectedCellColor;
    UIColor* _sectionTitleColor;
    UIColor* _textColor;
    UIColor* _selectedTextColor;
}

@property(nonatomic, readonly) NSArray* sections;

@property(nonatomic, strong) UIColor* cellColor;
@property(nonatomic, strong) UIColor* selectedCellColor;
@property(nonatomic, strong) UIColor* sectionTitleColor;
@property(nonatomic, strong) UIColor* textColor;
@property(nonatomic, strong) UIColor* selectedTextColor;


@property(nonatomic, weak) BCFormView* view;
@property(nonatomic, weak) id<BCFormDelegate> delegate;

+ (id)formWithCellColor:(UIColor*)cellColor selectedCellColor:(UIColor*)selectedCellColor sectionTitleColor:(UIColor*)sectionTitleColor
        textColor:(UIColor*)textColor selectedTextColor:(UIColor*)selectedTextColor;

- (BCFormSection*)addSection:(BCFormSection*)section;

@end