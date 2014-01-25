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


#import "BCTextViewCell.h"
#import "BCAbstractField.h"
#import "BCFormSection.h"
#import "BCForm.h"
#import "BCFormView.h"

/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

@implementation BCTextViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _editable = YES;
        [self initLabel];
        [self initTextView];
    }
    return self;
}


/* ====================================================================================================================================== */
#pragma mark - Interface Methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_textView setTextColor:[UIColor whiteColor]];
    _label.frame = CGRectMake(20, 3, self.frame.size.width - 40, 20);
    _textView.frame = CGRectMake(20, 3 + _label.frame.size.height, self.frame.size.width - 40, 100);
    [_textView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)setFocused:(BOOL)focused
{
    [super setFocused:focused];
    if (focused)
    {
        [_textView setTextColor:_field.selectedTextColor];
        UIView* view = (id) self.field.section.parent.view.formNavigationAccessory;
        [_textView setInputAccessoryView:view];
        if (_editable)
        {
            [_textView setEditable:YES];
            [_textView becomeFirstResponder];
            [_textView setTextColor:[UIColor blackColor]];
        }
    }
    else
    {
        [_textView setEditable:NO];
        [_textView setTextColor:_field.textColor];
        [self.textField performSelectorOnMainThread:@selector(resignFirstResponder) withObject:nil waitUntilDone:NO];
    }

    [_label setTextColor:_field.textColor];
    [_textView setTextColor:_field.textColor];
}

- (CGFloat)preferredHeight
{
    return 140;
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


- (void)initTextView
{
    _textView = [[UITextView alloc] initWithFrame:CGRectZero];
    [_textView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [_textView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_textView setFont:[UIFont systemFontOfSize:15]];
    [_textView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_textView];
    [self bringSubviewToFront:_textView];
}


@end