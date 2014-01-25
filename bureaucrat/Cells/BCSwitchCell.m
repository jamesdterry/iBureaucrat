//
//  BCSwitchCell.m
//  Pods
//
//  Created by James D. Terry on 1/25/14.
//
//

#import "BCSwitchCell.h"
#import "BCAbstractField.h"

@implementation BCSwitchCell

/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self)
  {
    _editable = YES;
    [self initLabel];
    [self initSwitchField];
  }
  return self;
}

/* ====================================================================================================================================== */
#pragma mark - Interface Methods

- (void)setEditable:(BOOL)editable
{
  _editable = editable;
  [_switchField setHidden:!_editable];
}

/* ====================================================================================================================================== */
#pragma mark - Override

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGPoint myPos = self.frame.origin;
  CGSize mySize = self.frame.size;
  
  CGSize labelSize = _label.frame.size;
  
  if (self.labelHidden) {
    labelSize = CGSizeZero;
  }
  
  CGPoint labelPos = (CGPoint) {
    myPos.x + 20,
    (mySize.height - labelSize.height) / 2
  };
  _label.frame = CGRectMake(labelPos.x, labelPos.y, 160, labelSize.height);
  
  CGSize switchFieldSize = _switchField.frame.size;
  switchFieldSize.width = mySize.width - labelSize.width;
  
  CGPoint switchFieldPos = (CGPoint) {
    labelPos.x + 200,
    _label.frame.origin.y
  };
  _switchField.frame = CGRectMake(switchFieldPos.x, switchFieldPos.y, switchFieldSize.width, switchFieldSize.height);
}

/* ====================================================================================================================================== */
#pragma mark - Private Methods


- (void)initLabel
{
  _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
  [_label setBackgroundColor:[UIColor clearColor]];
  [_label setFont:[UIFont boldSystemFontOfSize:14]];
  [_label setTextColor:[UIColor darkGrayColor]];
  [self addSubview:_label];
}

- (void)initSwitchField
{
  _switchField = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
  /*
  [_textField setFont:[UIFont systemFontOfSize:16]];
  [_textField setBackgroundColor:[UIColor clearColor]];
  [_textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
  [_textField setAutocorrectionType:UITextAutocorrectionTypeNo];
  [_textField setReturnKeyType:UIReturnKeyDone];
  [_textField setTextColor:[UIColor blackColor]];
   */
  [_switchField setBackgroundColor:[UIColor clearColor]];
  _switchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  _switchField.on = YES;
  [self addSubview:_switchField];
}

@end
