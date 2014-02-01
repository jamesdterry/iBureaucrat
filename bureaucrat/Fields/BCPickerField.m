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



#import "BCPickerField.h"
#import "BCAbstractCell.h"
#import "BCTextFieldCell.h"
#import <objc/message.h>


@implementation BCPickerField

/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (id)initWithLabel:(NSString*)label cellColor:(UIColor*)cellColor selectedCellColor:(UIColor*)selectedCellColor
        sectionTitleColor:(UIColor*)sectionTitleColor
{
    self = [super initWithLabel:label cellColor:cellColor selectedCellColor:selectedCellColor sectionTitleColor:sectionTitleColor];
    if (self)
    {
        [self clearOptions];
        [self initPickerView];
    }
    return self;
}

/* ====================================================================================================================================== */
#pragma mark - Interface Methods

- (void)clearOptions
{
  _shouldInitPicker = YES;
  _options = [[NSMutableArray alloc] init];
  _option_codes = [[NSMutableArray alloc] init];
  if (_pickerView) [_pickerView reloadAllComponents];
}

- (void)addOption:(id <NSObject>)option
{
  [_options addObject:option];
  if (_pickerView) [_pickerView reloadAllComponents];
}

- (void)addOption:(id<NSObject>)option withCode:(id<NSObject>)code
{
  [_options addObject:option];
  [_option_codes addObject:code];
  if (_pickerView) [_pickerView reloadAllComponents];
}


- (void)addOptions:(NSArray*)options
{
    for (id <NSObject> option in options)
    {
        [self addOption:option];
    }
}

- (void)setOptions:(NSArray*)options
{
    _options = [options copy];
}


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

- (id<NSObject>)code
{
  return _code;
}

- (NSString*)textValue
{
    return self.cell.textField.text;
}

- (void)setValue:(id <NSObject>)value
{
    [super setValue:value];
    NSUInteger row = [_options indexOfObject:value];
    if (row != NSNotFound) {
      [self pickerView:_pickerView didSelectRow:row inComponent:0];
    }
}

- (void)formCellWasFocused:(BCAbstractCell*)cell
{
    [super formCellWasFocused:cell];
    if (!_hasValue && [_options count] > 0)
    {
        [self setValue:[_options objectAtIndex:0]];
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
#pragma mark - Protocol Methods
#pragma mark - <UIPickerViewDelegate>

- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([_options count] > 0)
    {
        NSString* selected = [self displayValueFor:[_options objectAtIndex:row]];
        self.cell.textField.text = selected;
        _value = [_options objectAtIndex:row];
      if ([_option_codes count] > row) {
        _code = [_option_codes objectAtIndex:row];
      }
    }
}

- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_options count] == 0 ? 1 : [_options count];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}


- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([_options count] == 0)
    {
        return @"";
    }
    else
    {
        return [self displayValueFor:[_options objectAtIndex:row]];
    }
}


- (CGFloat)pickerView:(UIPickerView*)pickerView widthForComponent:(NSInteger)component
{
    return self.cell.frame.size.width - 20;
}


/* ====================================================================================================================================== */
#pragma mark - Private Methods

- (void)initPickerView
{
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 260, 320, 216)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.showsSelectionIndicator = YES;
}

- (NSString*)displayValueFor:(id <NSObject>)value
{
    SEL displayFieldSelector = _displayField == nil ? @selector(description) : _displayField;
    NSString* displayValue = objc_msgSend(value, displayFieldSelector);
    return displayValue;
}


@end