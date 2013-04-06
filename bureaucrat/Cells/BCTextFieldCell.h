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
#import "BCAbstractCell.h"

@class SettingsView;


@interface BCTextFieldCell : BCAbstractCell
{
    UILabel* _label;
    UITextField *_textField;
    UILabel *_readOnlyField;
}

@property (nonatomic, strong, readonly) UILabel* label;
@property (nonatomic, strong, readonly) UITextField *textField;
@property (nonatomic) BOOL editable;



@end