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



#import "BCPasswordField.h"
#import "BCTextFieldFormCell.h"
#import "BCPasswordFormCell.h"
#import "UITextField+AbstractFormCell.h"
#import "CKUITools.h"


@implementation BCPasswordField

- (BCAbstractFormCell*)createCellInstance;
{
    BCPasswordFormCell* cell = [[BCPasswordFormCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell.label setText:self.label];
    cell.label.width = 100;
    cell.textField.returnKeyType = UIReturnKeyDefault;
    cell.textField.delegate = self;
    cell.textField.formCell = cell;
    return cell;
}

@end