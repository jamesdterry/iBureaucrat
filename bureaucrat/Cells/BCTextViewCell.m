////////////////////////////////////////////////////////////////////////////////
//
//  INFRAXIS
//  Copyright 2013 Infraxis
//  All Rights Reserved.
//
//  NOTICE: Infraxis permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import "BCTextViewCell.h"
#import "BCAbstractField.h"

/* ============================================================ Initializers ============================================================ */
@implementation BCTextViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _editable = YES;
        [self initTextView];
    }
    return self;
}


/* ========================================================== Interface Methods ========================================================= */
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_textView setTextColor:[UIColor blackColor]];
    _textView.frame = CGRectMake(20, 5, 280, 66);
    [_textView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)setFocused:(BOOL)focused
{
    [super setFocused:focused];
    if (focused)
    {
//        [_label setTextColor:_field.selectedTextColor];
        [_textView setTextColor:_field.selectedTextColor];
        if (_editable)
        {
            NSLog(@"Let's edit!!!!");
            [self bringSubviewToFront:_textView];
            [_textView becomeFirstResponder];
            [_textView setTextColor:[UIColor blackColor]];
        }
    }
    else
    {
        NSLog(@"What the fuck?");
//        [_label setTextColor:_field.textColor];
        [_textView setTextColor:_field.textColor];
        [self.textField performSelectorOnMainThread:@selector(resignFirstResponder) withObject:nil waitUntilDone:NO];
    }
}

- (CGFloat)preferredHeight
{
    return 140;
}


/* ============================================================ Private Methods ========================================================= */
- (void)initTextView
{
    _textView = [[UITextView alloc] initWithFrame:CGRectZero];
    [_textView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [_textView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_textView setFont:[UIFont systemFontOfSize:16]];
    [_textView setBackgroundColor:[UIColor colorWithRed:.7 green:0.7 blue:0.8 alpha:1]];
//    [_textView setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//    [_textView setAutocorrectionType:UITextAutocorrectionTypeNo];
//    [_textView setReturnKeyType:UIReturnKeyDone];
//    [_textView setTextColor:[UIColor blackColor]];
    [self addSubview:_textView];
    [self bringSubviewToFront:_textView];
}



@end