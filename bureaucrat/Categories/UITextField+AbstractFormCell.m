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



#import "UITextField+AbstractFormCell.h"
#import "BCAbstractCell.h"

static char const* const formCellKey;

@implementation UITextField (AbstractFormCell)

- (BCAbstractCell*)formCell
{
    return objc_getAssociatedObject(self, &formCellKey);
}


- (void)setFormCell:(BCAbstractCell*)formCell
{
    objc_setAssociatedObject(self, &formCellKey, formCell, OBJC_ASSOCIATION_ASSIGN);
}

@end