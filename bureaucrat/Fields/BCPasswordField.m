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
#import "BCTextFieldCell.h"
#import "BCPasswordCell.h"
#import "UITextField+AbstractFormCell.h"


@implementation BCPasswordField

- (BCAbstractCell*)createCellInstance;
{
    BCPasswordCell* cell = [[BCPasswordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell.label setText:self.label];
    [cell.label setFrame:CGRectMake(cell.label.frame.origin.x, cell.label.frame.origin.y, 100, cell.label.frame.size.height)];
    cell.textField.returnKeyType = UIReturnKeyDefault;
    cell.textField.delegate = self;
    cell.textField.formCell = cell;
    return cell;
}

@end