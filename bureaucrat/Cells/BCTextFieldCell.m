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




#import "BCTextFieldCell.h"
#import "BCAbstractField.h"


@implementation BCTextFieldCell

/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _editable = YES;
        [self initLabel];
        [self initTextField];
        [self initReadOnlyField];
        [_textField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [_textField addObserver:self forKeyPath:@"textColor" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc
{
    [_textField removeObserver:self forKeyPath:@"text"];
    [_textField removeObserver:self forKeyPath:@"textColor"];
}

/* ====================================================================================================================================== */
#pragma mark - Interface Methods

- (void)setEditable:(BOOL)editable
{
    _editable = editable;
    [_textField setHidden:!_editable];
    [_readOnlyField setHidden:_editable];
}


/* ====================================================================================================================================== */
#pragma mark - Override

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    if (object == _textField)
    {
        if ([keyPath isEqualToString:@"text"])
        {
            [_readOnlyField setText:_textField.text];
        }
        if ([keyPath isEqualToString:@"textColor"])
        {
            [_readOnlyField setTextColor:_textField.textColor];
        }
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    CGPoint myPos = self.frame.origin;
    CGSize mySize = self.frame.size;

    CGSize labelSize = _label.frame.size;
    CGSize readOnlyFieldSize = _readOnlyField.frame.size;
  
    if(self.labelHidden){
      labelSize = CGSizeZero;
    }

    CGPoint labelPos = (CGPoint) {myPos.x + 20, (mySize.height - labelSize.height) / 2};
    _label.frame = CGRectMake(labelPos.x, labelPos.y, labelSize.width, labelSize.height);

    CGSize textFieldSize = _textField.frame.size;
    textFieldSize.width = mySize.width - labelSize.width;

    CGPoint textFieldPos = (CGPoint) {labelPos.x + labelSize.width, ((mySize.height - textFieldSize.height) / 2) + 4};
    _textField.frame = CGRectMake(textFieldPos.x, textFieldPos.y, textFieldSize.width, textFieldSize.height);

    CGPoint readOnlyFieldPos = (CGPoint) {labelPos.x + labelSize.width, (mySize.height - readOnlyFieldSize.height) / 2};
    _readOnlyField.frame = CGRectMake(readOnlyFieldPos.x, readOnlyFieldPos.y, mySize.width - labelSize.width, readOnlyFieldSize.height);

}

- (void)setFocused:(BOOL)focused
{
    [super setFocused:focused];
    if (focused)
    {
        [_label setTextColor:_field.selectedTextColor];
        [_textField setTextColor:_field.selectedTextColor];
        if (_editable)
        {
            [_textField performSelectorOnMainThread:@selector(becomeFirstResponder) withObject:nil waitUntilDone:NO];
        }
    }
    else
    {
        [_label setTextColor:_field.textColor];
        [_textField setTextColor:_field.textColor];
        [_textField performSelectorOnMainThread:@selector(resignFirstResponder) withObject:nil waitUntilDone:NO];
    }
}

/* ====================================================================================================================================== */
#pragma mark - Private Methods


- (void)initLabel
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    [_label setBackgroundColor:[UIColor clearColor]];
    [_label setFont:[UIFont boldSystemFontOfSize:14]];
    [_label setTextColor:[UIColor darkGrayColor]];
    [self addSubview:_label];
}

- (void)initTextField
{
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 350, 30)];
    [_textField setFont:[UIFont systemFontOfSize:16]];
    [_textField setBackgroundColor:[UIColor clearColor]];
    [_textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_textField setReturnKeyType:UIReturnKeyDone];
    [_textField setTextColor:[UIColor blackColor]];
    [self addSubview:_textField];
}

- (void)initReadOnlyField
{
    _readOnlyField = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 350, 30)];
    [_readOnlyField setBackgroundColor:[UIColor orangeColor]];
    [_readOnlyField setBackgroundColor:[UIColor clearColor]];
    [_readOnlyField setFont:[UIFont systemFontOfSize:15]];
    [_readOnlyField setTextColor:[UIColor darkGrayColor]];
    [_readOnlyField setHidden:YES];
    [self addSubview:_readOnlyField];
}

@end