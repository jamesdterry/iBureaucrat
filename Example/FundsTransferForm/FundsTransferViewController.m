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


#import "FundsTransferViewController.h"
#import "FundsTransferView.h"
#import "BCTextField.h"
#import "BCFormSection.h"
#import "BCPickerField.h"
#import "BCForm.h"
#import "BCFormView.h"
#import "Vehicle.h"

@interface FundsTransferViewController ()

@end

@implementation FundsTransferViewController

- (void)loadView
{
    self.view = [[FundsTransferView alloc] initWithFrame:CGRectZero];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    FundsTransferView* view = (FundsTransferView*) self.view;

    BCForm* form = [BCForm new]; //Using default colors.
    BCFormSection* destinationPhoneSection = [form addSection:[BCFormSection sectionWithTitle:@"Transport Details"]];

    _countryCode = [BCPickerField fieldWithLabel:@"Send by"];
    [_countryCode addOption:[Vehicle vehicleWithName:@"Horse" traits:@"grain tax"]];
    [_countryCode addOption:[Vehicle vehicleWithName:@"Scoundrel" traits:@"reliable"]];
    [_countryCode addOption:[Vehicle vehicleWithName:@"Ship" traits:@"not good over-land"]];

    _mobileId = [BCTextField fieldWithLabel:@"Number"];
    _mobileId.textField.keyboardType = UIKeyboardTypePhonePad;
    [destinationPhoneSection addFields:@[_countryCode, _mobileId]];

    BCFormSection* detailsSection = [form addSection:[BCFormSection sectionWithTitle:@"Details"]];

    _amountToSend = [BCTextField fieldWithLabel:@"Amount"];
    _amountToSend.textField.keyboardType = UIKeyboardTypeNumberPad;
    _currency = [BCPickerField fieldWithLabel:@"Currency"];
    [_currency addOption:@"Gold"];
    [_currency addOption:@"Pieces of Eight"];
    [_currency addOption:@"Booty"];
    [_currency addOption:@"Herbs and Spices"];

    _referenceIdField = [BCTextField fieldWithLabel:@"Reference ID"];
    [detailsSection addFields:@[_amountToSend, _currency, _referenceIdField]];

    view.formView.form = form;
}

/* ============================================================ Private Methods ========================================================= */


@end
