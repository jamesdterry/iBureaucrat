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


#import <UIKit/UIKit.h>
#import "BCFormDelegate.h"

@class BCPickerField;
@class BCTextField;
@class BCForm;
@class BCPasswordField;
@class BCMultiLineTextField;

@interface FundsTransferViewController : UIViewController<BCFormDelegate>
{
    BCForm* _form;
}

@property (nonatomic, strong, readonly) BCPickerField* sendBy;
@property (nonatomic, strong, readonly) BCMultiLineTextField* notes;

@property (nonatomic, strong, readonly) BCTextField* amountToSend;
@property (nonatomic, strong, readonly) BCPickerField* currency;
@property (nonatomic, strong, readonly) BCTextField* referenceIdField;
@property (nonatomic, strong, readonly) BCTextField* anotherField;

@property (nonatomic, strong, readonly) BCPasswordField* password;
@property (nonatomic, strong, readonly) BCPasswordField* secretInstructions;

@end
