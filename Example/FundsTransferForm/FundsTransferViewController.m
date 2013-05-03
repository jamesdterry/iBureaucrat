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
#import "BCPasswordField.h"
#import "BCMultiLineTextField.h"

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

    _form = [BCForm new]; //Using default colors.
    _form.delegate = self;
    [_form addSection:[self createTransportDetailsSection]];
    [_form addSection:[self createDetailsSection]];

    //Uncomment this to try a long form
    //[_form addSection:[self createAuthorizeSection]];

    view.formView.form = _form;
}

/* ====================================================================================================================================== */
#pragma mark <BCFormDelegate>

- (void)didSelectDone
{
    NSLog(@"Delegate call for done. Field: %@", [_sendBy value]);
}

- (void)didSelectPreviousField
{
    NSLog(@"Delegate call for previous");
}

- (void)didSelectNextField
{
    NSLog(@"Delegate call for next");
}

- (void)fieldReceivedFocus:(BCAbstractField*)field
{
    NSLog(@"Field received focus: %@", field);
}

- (void)fieldLostFocus:(BCAbstractField*)field
{
    NSLog(@"Field lost focus: %@", field);
}


/* ============================================================ Private Methods ========================================================= */
- (BCFormSection*)createTransportDetailsSection
{
    BCFormSection* transportDetailsSection = [BCFormSection sectionWithTitle:@"Transport Details"];
    _sendBy = [BCPickerField fieldWithLabel:@"Send by"];
    [_sendBy addOption:[Vehicle vehicleWithName:@"Horse" traits:@"grain tax"]];
    [_sendBy addOption:[Vehicle vehicleWithName:@"Scoundrel" traits:@"reliable"]];
    [_sendBy addOption:[Vehicle vehicleWithName:@"Ship" traits:@"not good over-land"]];

    _notes = [BCMultiLineTextField fieldWithLabel:@"Notes"];
    [_notes setEditable:NO];
    [_notes setValue:@"You don't need a weather man to know which way the wind blows. Bob Dylayn said that, 40 years ago"];
    [transportDetailsSection addFields:@[_sendBy, _notes]];
    return transportDetailsSection;
}

- (BCFormSection*)createDetailsSection
{
    BCFormSection* detailsSection = [BCFormSection sectionWithTitle:@"Details"];

    _amountToSend = [BCTextField fieldWithLabel:@"Amount"];
    _amountToSend.textField.keyboardType = UIKeyboardTypeNumberPad;
    _currency = [BCPickerField fieldWithLabel:@"Currency"];
    [_currency addOption:@"Gold"];
    [_currency addOption:@"Pieces of Eight"];
    [_currency addOption:@"Booty"];
    [_currency addOption:@"Herbs and Spices"];

    _referenceIdField = [BCTextField fieldWithLabel:@"Reference ID"];
    _anotherField = [BCTextField fieldWithLabel:@"Another Field"];
    [_anotherField setEditable:NO];

    [detailsSection addFields:@[_amountToSend, _currency, _referenceIdField, _anotherField]];
    return detailsSection;
}

- (BCFormSection*)createAuthorizeSection
{
    BCFormSection* authorizeSection = [BCFormSection sectionWithTitle:@"Authorization"];

    _password = [BCPasswordField fieldWithLabel:@"Password"];
    _secretInstructions = [BCPasswordField fieldWithLabel:@"Instructions"];

    [authorizeSection addFields:@[_password, _secretInstructions]];
    return authorizeSection;
}


@end
