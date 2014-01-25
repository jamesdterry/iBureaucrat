//
//  BCSwitchCell.h
//  Pods
//
//  Created by James D. Terry on 1/25/14.
//
//

#import "BCAbstractCell.h"

@interface BCSwitchCell : BCAbstractCell
{
  UISwitch *_switchField;
}

@property (nonatomic, strong, readonly) UISwitch *switchField;
@property (nonatomic) BOOL editable;

@end
