//
//  BCSwitchField.h
//  Pods
//
//  Created by James D. Terry on 1/25/14.
//
//

#import "BCAbstractField.h"

@class BCSwitchCell;

@interface BCSwitchField : BCAbstractField

@property(nonatomic, strong, readonly) UISwitch *switchField;

- (void)setValue:(NSNumber *)value;

@end
