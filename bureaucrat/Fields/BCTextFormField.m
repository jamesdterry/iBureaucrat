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


#import "BCTextFormField.h"
#import "BCTextFieldFormCell.h"
#import "BCFormInputAccessoryView.h"
#import "BCFormSection.h"
#import "BCFormView.h"
#import "UITextField+AbstractFormCell.h"
#import "BCForm.h"
#import "CKUITools.h"


@implementation BCTextFormField


- (UITextField*)textField
{
    return self.cell.textField;
}

/* ====================================================================================================================================== */
#pragma mark - Override

- (BCAbstractFormCell*)createCellInstance;
{
    BCTextFieldFormCell* cell = [[BCTextFieldFormCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell.label setText:self.label];
    cell.label.width = 100;
    cell.textField.returnKeyType = UIReturnKeyDefault;
    cell.textField.delegate = self;
    cell.textField.formCell = cell;
    cell.label.textColor = [UIColor redColor];
    return cell;
}

- (NSString*)textValue
{
    return self.cell.textField.text;
}

- (void)setValue:(NSString*)value
{
    self.cell.textField.text = value;
}

- (void)setInputAccessoryView:(BCFormInputAccessoryView*)inputAccessoryView
{
    self.cell.textField.inputAccessoryView = inputAccessoryView;
}

- (void)formCellWasFocused:(BCAbstractFormCell*)cell
{
    [super formCellWasFocused:cell];
}

/* ====================================================================================================================================== */
#pragma mark <UITextFieldDelegate>

- (void)textFieldDidBeginEditing:(UITextField*)textField
{
    [self.section.parent.view textFieldDidBeginEditing:textField];
}

- (void)textFieldDidEndEditing:(UITextField*)textField
{
    [self.section.parent.view textFieldDidEndEditing:textField];
}

@end