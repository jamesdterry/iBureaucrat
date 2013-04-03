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



#import "BCPasswordFormField.h"
#import "BCTextFieldFormCell.h"
#import "BCPasswordFormCell.h"
#import "UITextField+AbstractFormCell.h"
#import "CKUITools.h"


@implementation BCPasswordFormField

- (BCAbstractFormCell*)createCellInstance;
{
    BCPasswordFormCell* cell = [[BCPasswordFormCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell.label setText:@"Country code"];
    cell.label.width = 100;
    cell.textField.returnKeyType = UIReturnKeyDefault;
    cell.textField.delegate = self;
    cell.textField.formCell = cell;
    return cell;
}

@end