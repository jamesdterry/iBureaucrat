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
#import "BCTextFieldCell.h"

@class FKScrollField;


@interface BCTextViewCell : BCAbstractCell
{
    UITextView* _textView;
}

@property (nonatomic) BOOL editable;
@property (nonatomic, strong, readonly) UITextView* textView;

@end