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


#import "BCTextField.h"
#import "BCTextFieldCell.h"
#import "BCDefaultInputAccessory.h"
#import "BCFormSection.h"
#import "BCFormView.h"
#import "UITextField+AbstractFormCell.h"
#import "BCForm.h"


@implementation BCTextField


- (UITextField*)textField
{
    return self.cell.textField;
}

/* ====================================================================================================================================== */
#pragma mark - Override

- (BCAbstractCell*)createCellInstance;
{
    BCTextFieldCell* cell = [[BCTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell.label setText:self.label];
    [cell.label setFrame:CGRectMake(cell.label.frame.origin.x, cell.label.frame.origin.y, 100, cell.label.frame.size.height)];
    cell.textField.returnKeyType = UIReturnKeyDefault;
    cell.textField.delegate = self;
    cell.textField.formCell = cell;
    cell.label.textColor = [UIColor redColor];
  
  
    if(self.label == nil){
      cell.labelHidden = YES;
    }
    return cell;
}

- (NSString*)textValue
{
    return self.cell.textField.text;
}

- (void)setValue:(NSString*)value
{
    [super setValue:value];
    self.cell.textField.text = value;
}

- (void)setInputAccessoryView:(BCDefaultInputAccessory*)inputAccessoryView
{
    self.cell.textField.inputAccessoryView = inputAccessoryView;
}

- (void)formCellWasFocused:(BCAbstractCell*)cell
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