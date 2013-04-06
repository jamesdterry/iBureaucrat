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




#import <Foundation/Foundation.h>

@protocol BCCellDelegate;
@class BCAbstractField;


@interface BCAbstractCell : UITableViewCell
{
    __weak BCAbstractField* _field;
}


@property(nonatomic, strong) NSIndexPath* indexPath;

@property (nonatomic, weak) id<BCCellDelegate>delegate;
@property (nonatomic, weak) BCAbstractField* field;


- (void)setFocused:(BOOL)focused;

- (UITextField*)textField;


@end