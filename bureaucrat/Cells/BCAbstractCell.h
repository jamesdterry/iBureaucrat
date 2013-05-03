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

@protocol BCCellDelegate;
@class BCAbstractField;

/**
* An abstract cell, designed to be sub-classed.
*/
@interface BCAbstractCell : UITableViewCell
{
    __weak BCAbstractField* _field;
    UILabel* _label;
    BOOL _focused;
}

@property(nonatomic, strong, readonly) UILabel* label;

/**
* The index path of this cell, within the form.
*/
@property(nonatomic, strong) NSIndexPath* indexPath;

/**
* A weak reference to the delegate for this cell.
*/
@property (nonatomic, weak) id<BCCellDelegate>delegate;

/**
* A weak reference to the field corresponding to this cell.
*/
@property (nonatomic, weak) BCAbstractField* field;


/**
* Updates the background color on focus, and calls the delegate's formCellWasFocused method. This method can be overriddn to perform
* additional work.
*/
- (void)setFocused:(BOOL)focused;

/**
* Returns the text-field for this cell. All cells must have a UITextField member, though the UITextField need not be a visible part of the
* cell. The reason for including a text field is that:
* - it provides a convenient way to call `becomeFirstResponder`
* - it provides a convenient way to provide a custom input view, other than the regular keyboards.
*/
- (UITextField*)textField;

- (CGFloat)preferredHeight;

@end