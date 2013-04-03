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

@class BCPickerField;
@class BCTextField;

@interface BureaucraticFormViewController : UIViewController

@property (nonatomic, strong, readonly) BCPickerField* countryCode;
@property (nonatomic, strong, readonly) BCTextField* mobileId;

@property (nonatomic, strong, readonly) BCTextField* amountToSend;
@property (nonatomic, strong, readonly) BCPickerField* currency;
@property (nonatomic, strong, readonly) BCTextField* referenceIdField;

@end
