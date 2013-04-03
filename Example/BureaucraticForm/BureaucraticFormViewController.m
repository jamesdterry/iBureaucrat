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


#import "BureaucraticFormViewController.h"
#import "BureaucraticFormView.h"
#import "BCTextField.h"
#import "BCFormSection.h"
#import "BCPickerField.h"
#import "BCForm.h"
#import "BCFormView.h"

@interface BureaucraticFormViewController ()

@end

@implementation BureaucraticFormViewController

- (void)loadView
{
    self.view = [[BureaucraticFormView alloc] initWithFrame:CGRectZero];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    BureaucraticFormView* view = (BureaucraticFormView*) self.view;

    BCForm* form = [BCForm new]; //Using default colors.
    BCFormSection* destinationPhoneSection = [form addSection:[BCFormSection sectionWithTitle:@"Destination Mobile"]];

    _countryCode = [BCPickerField fieldWithLabel:@"Country Code"];
    [_countryCode addOption:@"+1 USA"];
    [_countryCode addOption:@"+41 Switzerland"];
    [_countryCode addOption:@"+44 United Kingdom"];
    [_countryCode addOption:@"+60 Malaysia"];

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
