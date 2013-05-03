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

/**
* Provides a color-scheme model for a form. To implement a shared color scheme throughout an application a class-method category can be
* implemented on this class.
*/
@interface BCColorScheme : NSObject

@property(nonatomic, strong) UIColor* cellColor;
@property(nonatomic, strong) UIColor* selectedCellColor;
@property(nonatomic, strong) UIColor* sectionTitleColor;
@property(nonatomic, strong) UIColor* defaultTextColor;
@property(nonatomic, strong) UIColor* selectedTextColor;
@property(nonatomic, strong) UIColor* buttonTintColor;

+ (instancetype)defaultColorScheme;

+ (instancetype)schemeWithCellColor:(UIColor*)cellColor selectedCellColor:(UIColor*)selectedCellColor
        sectionTitleColor:(UIColor*)sectionTitleColor defaultTextColor:(UIColor*)defaultTextColor
        selectedTextColor:(UIColor*)selectedTextColor buttonTintColor:(UIColor*)buttonTintColor;

- (id)initWithCellColor:(UIColor*)cellColor selectedCellColor:(UIColor*)selectedCellColor sectionTitleColor:(UIColor*)sectionTitleColor
        defaultTextColor:(UIColor*)defaultTextColor selectedTextColor:(UIColor*)selectedTextColor buttonTintColor:(UIColor*)buttonTintColor;


@end