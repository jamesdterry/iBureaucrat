////////////////////////////////////////////////////////////////////////////////
//
//  INFRAXIS
//  Copyright 2013 Infraxis
//  All Rights Reserved.
//
//  NOTICE: Infraxis permits you to use, modify, and distribute this file
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
//    [cell.label setText:self.label];
//    cell.label.width = 100;
    cell.textField.returnKeyType = UIReturnKeyDefault;
    cell.textField.delegate = self;
    cell.textField.formCell = cell;
    return cell;
}

@end