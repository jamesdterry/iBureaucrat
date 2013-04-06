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
#import "CKUITools.h"
#import <objc/message.h>


@implementation BCPickerField

/* ============================================================ Initializers ============================================================ */
- (id)initWithLabel:(NSString*)label cellColor:(UIColor*)cellColor selectedCellColor:(UIColor*)selectedCellColor
        sectionTitleColor:(UIColor*)sectionTitleColor
{
    self = [super initWithLabel:label cellColor:cellColor selectedCellColor:selectedCellColor sectionTitleColor:sectionTitleColor];
    if (self)
    {
        _options = [[NSMutableArray alloc] init];
        [self initPickerView];
    }
    return self;
}

/* ========================================================== Interface Methods ========================================================= */


- (void)addOption:(id <NSObject>)option
{
    [_options addObject:option];
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
    cell.label.width = 100;
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
    NSUInteger row = [_options indexOfObject:value];
    [self pickerView:_pickerView didSelectRow:row inComponent:0];
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


/* =========================================================== Protocol Methods ========================================================= */
#pragma mark - <UIPickerViewDelegate>

- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString* selected = [self displayValueFor:[_options objectAtIndex:row]];
    self.cell.textField.text = selected;
}

- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_options count];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}


- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self displayValueFor:[_options objectAtIndex:row]];
}


- (CGFloat)pickerView:(UIPickerView*)pickerView widthForComponent:(NSInteger)component
{
    return self.cell.width - 20;
}


/* ============================================================ Private Methods ========================================================= */
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