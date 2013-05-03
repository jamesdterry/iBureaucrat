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
@class BCColorScheme;


@interface BCForm : NSObject
{
    NSMutableArray* _sections;
}

@property(nonatomic, strong, readonly) NSArray* sections;
@property(nonatomic, strong, readonly) BCColorScheme* colorScheme;

@property(nonatomic, weak) BCFormView* view;
@property(nonatomic, weak) id <BCFormDelegate> delegate;

+ (id)formWithColorScheme:(BCColorScheme*)colorScheme;

- (BCFormSection*)addSection:(BCFormSection*)section;

@end