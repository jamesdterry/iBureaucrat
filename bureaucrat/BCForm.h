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

/**
* Models a form for presentation in a BCFormView. As well as being used directly - adding fields and sections, this class can be
* sub-classed, in order to encapsulate UIView elements. It provides the abstract build method, which can be over-ridden to build a custom
* form.
*/
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

/**
* Abstract method - can be overwritten in sub-classes to build a form. This allows UIView components from the form to be encapsulated
* within the sub-class.
*/
- (void)build;

@end