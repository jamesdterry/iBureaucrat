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
#import "BCFormInputAccessoryViewDelegate.h"

@class BCFormInputAccessoryView;
@class BCFormSection;
@class BCAbstractFormCell;
@class BCForm;


@interface BCFormView : UIView<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, BCFormInputAccessoryViewDelegate>
{
    UIView* _backgroundView;
    UITableView* _tableView;
    BCFormInputAccessoryView* _formNavigationAccessory;

    CGFloat _currentScrollAmount;


    NSIndexPath* _selectedIndexPath;
    UITextField* _currentlyEditingField;
    BCAbstractFormCell* _currentlyEditingCell;
}

@property (nonatomic, strong, readonly) UIView* contentView;

@property (nonatomic, strong) BCForm* form;
@property (nonatomic, strong) UIView* backgroundView;


- (CGRect)onScreenKeyboardFrame;

@end