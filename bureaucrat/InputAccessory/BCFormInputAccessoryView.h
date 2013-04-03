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

@protocol BCFormInputAccessoryViewDelegate;


@interface BCFormInputAccessoryView : UIToolbar
{
    __weak id<BCFormInputAccessoryViewDelegate> _accessoryViewDelegate;
}

@property (nonatomic, strong, readonly) UIBarButtonItem* doneButton;
@property (nonatomic, strong, readonly) UIBarButtonItem* previousButton;
@property (nonatomic, strong, readonly) UIBarButtonItem* nextButton;


+ (BCFormInputAccessoryView*)viewWithDelegate:(id<BCFormInputAccessoryViewDelegate>)delegate;

@end