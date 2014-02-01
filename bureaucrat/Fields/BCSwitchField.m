//
//  BCSwitchField.m
//  Pods
//
//  Created by James D. Terry on 1/25/14.
//
//

#import "BCSwitchField.h"
#import "BCSwitchCell.h"

@implementation BCSwitchField

- (UISwitch *)switchField
{
  BCSwitchCell *selfCell = (BCSwitchCell *)(self.cell);
  
  return selfCell.switchField;
}

/* ====================================================================================================================================== */
#pragma mark - Override

- (BCAbstractCell*)createCellInstance;
{
  BCSwitchCell *cell = [[BCSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
  [cell.label setText:self.label];
  [cell.label setFrame:CGRectMake(cell.label.frame.origin.x, cell.label.frame.origin.y, 100, cell.label.frame.size.height)];
  
  cell.textField.returnKeyType = UIReturnKeyDefault;
  cell.label.textColor = [UIColor blackColor];
  
  if(self.label == nil){
    cell.labelHidden = YES;
  }
  return cell;
}

- (id<NSObject>)value
{
  BCSwitchCell *selfCell = (BCSwitchCell *)(self.cell);
  
  return [NSNumber numberWithBool:selfCell.switchField.on];
}

- (void)setValue:(NSNumber *)value
{
  [super setValue:value];
  
  BCSwitchCell *selfCell = (BCSwitchCell *)(self.cell);
  
  selfCell.switchField.on = [value boolValue];
}


@end
