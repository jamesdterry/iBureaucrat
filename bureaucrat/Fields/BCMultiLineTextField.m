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



#import "BCMultiLineTextField.h"
#import "BCTextViewCell.h"
#import "UITextField+AbstractFormCell.h"


@implementation BCMultiLineTextField

- (BCAbstractCell*)createCellInstance;
{
  BCTextViewCell* cell = [[BCTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
  [cell.label setText:self.label];
  cell.textField.returnKeyType = UIReturnKeyDefault;
  cell.textField.delegate = self;
  cell.textField.formCell = cell;
  cell.textView.backgroundColor = [UIColor darkGrayColor];
  return cell;
}

- (void)setValue:(NSString*)value
{
    BCTextViewCell* cell = (BCTextViewCell*) self.cell;
    cell.textView.text = value;
}

- (void)setAttributedString:(NSAttributedString *)value
{
  BCTextViewCell* cell = (BCTextViewCell*) self.cell;
  cell.textView.attributedText = value;
}

- (CGFloat)preferredHeight
{
  return 200;
}

@end