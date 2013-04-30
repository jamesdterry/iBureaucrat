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
#import "BCInputAccessoryDelegate.h"

@class BCDefaultInputAccessory;
@class BCFormSection;
@class BCAbstractCell;
@class BCForm;


@interface BCFormView : UIView<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, BCInputAccessoryDelegate>
{
    UIView* _backgroundView;
    UITableView* _tableView;
    BCDefaultInputAccessory* _formNavigationAccessory;

    CGFloat _currentScrollAmount;


    NSIndexPath* _selectedIndexPath;
    UITextField* _currentlyEditingField;
    BCAbstractCell* _currentlyEditingCell;
}

@property (nonatomic, strong, readonly) UIView* contentView;


@property (nonatomic, strong, readonly) BCDefaultInputAccessory* formNavigationAccessory;
@property (nonatomic, strong) BCForm* form;
@property (nonatomic, strong) UIView* backgroundView;


- (CGRect)keyboardFrame;

@end