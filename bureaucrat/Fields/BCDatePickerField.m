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



#import "BCDatePickerField.h"
#import "BCAbstractCell.h"
#import "BCTextFieldCell.h"
#import <objc/message.h>


@implementation BCDatePickerField

/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (id)initWithLabel:(NSString*)label cellColor:(UIColor*)cellColor selectedCellColor:(UIColor*)selectedCellColor
  sectionTitleColor:(UIColor*)sectionTitleColor
{
  self = [super initWithLabel:label cellColor:cellColor selectedCellColor:selectedCellColor sectionTitleColor:sectionTitleColor];
  if (self)
  {
    [self initPickerView];
  }
  return self;
}

/* ====================================================================================================================================== */
#pragma mark - Interface Methods


/* ====================================================================================================================================== */
#pragma mark Override

- (BCAbstractCell*)createCellInstance
{
  BCTextFieldCell* cell = [[BCTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
  cell.editable = NO;
  [cell.label setText:self.label];
  [cell.label setFrame:CGRectMake(cell.label.frame.origin.x, cell.label.frame.origin.y, 100, cell.label.frame.size.height)];
  cell.textField.inputView = _pickerView;
  cell.backgroundColor = self.cellColor;
  cell.label.textColor = self.textColor;
  cell.textField.textColor = self.textColor;
  return cell;
}

- (BCTextFieldCell*)cell
{
  return (BCTextFieldCell*) [super cell];
}

- (NSString*)textValue
{
  return self.cell.textField.text;
}

- (void)setValue:(id <NSObject>)value
{
  [super setValue:value];
  
  NSDate *dateValue = (NSDate *)value;

  _pickerView.date = dateValue;
}

- (void)formCellWasFocused:(BCAbstractCell*)cell
{
  [super formCellWasFocused:cell];
  if (!_hasValue)
  {
    [self setValue:[NSDate date]];
    _hasValue = YES;
  }
  cell.textField.delegate = self;
  cell.textField.inputView = _pickerView;
  [cell.textField performSelectorOnMainThread:@selector(becomeFirstResponder) withObject:nil waitUntilDone:YES];
}

- (void)formCellLostFocus:(BCAbstractCell*)cell
{
  [super formCellLostFocus:cell];
}

/* ====================================================================================================================================== */
- (void)textFieldDidBeginEditing:(UITextField*)textField
{
  
}


/* ====================================================================================================================================== */

- (void) dateChanged:(id)sender{
  _value = [_pickerView date];
}

/* ====================================================================================================================================== */
#pragma mark - Private Methods

- (void)initPickerView
{
  _pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 260, 320, 216)];
  _pickerView.datePickerMode = UIDatePickerModeDate;
  [_pickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
}

- (NSString*)displayValueFor:(id <NSObject>)value
{
  SEL displayFieldSelector = _displayField == nil ? @selector(description) : _displayField;
  NSString* displayValue = objc_msgSend(value, displayFieldSelector);
  return displayValue;
}


@end