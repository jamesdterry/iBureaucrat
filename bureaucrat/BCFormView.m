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


#import "BCFormView.h"
#import "BCDefaultInputAccessory.h"
#import "BCFormSection.h"
#import "UITableView+IndexPaths.h"
#import "BCAbstractCell.h"
#import "BCAbstractField.h"
#import "UITextField+AbstractFormCell.h"
#import "BCForm.h"
#import "BCFormDelegate.h"
#import "BCTextFieldCell.h"
#import "BCColorScheme.h"


@interface BCFormView ()

@property(nonatomic, strong) BCAbstractCell* currentlyEditingCell;

@end


@implementation BCFormView

/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (void)awakeFromNib
{
  [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
  [self setClipsToBounds:YES];
  [self initContentView];
  [self initTableView];
  [self initNavigationAccessory];
}


/* ====================================================================================================================================== */
#pragma mark - Interface Methods

- (void)setForm:(BCForm*)form
{
    _form = form;
    _form.view = self;
    NSLog(@"Using form: %@", form);
    [_formNavigationAccessory.doneButton setTintColor:_form.colorScheme.buttonTintColor];
    [_tableView setSeparatorColor:_form.colorScheme.separatorColor];
}

- (void)setCurrentlyEditingCell:(BCAbstractCell*)currentlyEditingCell
{
    _currentlyEditingCell = currentlyEditingCell;
    if (_currentlyEditingCell)
    {
        [self scrollToAccommodateCell:_currentlyEditingCell];
        _currentlyEditingCell.textField.inputAccessoryView = _formNavigationAccessory;
    }
}


/* ====================================================================================================================================== */
#pragma mark - Override

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (CGRectEqualToRect(_contentView.frame, CGRectZero))
    {
        _contentView.frame = self.bounds;
    }

    _backgroundView.frame = _contentView.bounds;
    _tableView.frame = _contentView.bounds;
}

- (void)setBackgroundView:(UIView*)backgroundView
{
    _backgroundView = backgroundView;
    [_contentView addSubview:_backgroundView];
    [_contentView sendSubviewToBack:_backgroundView];
}

/* =========================================================== Protocol Methods ========================================================= */
#pragma mark - <UITextFieldDelegate>


- (void)textFieldDidBeginEditing:(UITextField*)textField
{
    BCTextFieldCell* cell = (BCTextFieldCell*) textField.formCell;
    if (_currentlyEditingField != textField && cell.editable)
    {
        [_currentlyEditingCell setFocused:NO];
        _selectedIndexPath = nil;
        [self selectRowAtIndexPath:textField.formCell.indexPath];
        _currentlyEditingField = textField;
        [_currentlyEditingField becomeFirstResponder];
    }
}

- (void)textFieldDidEndEditing:(UITextField*)textField
{
}

/* ====================================================================================================================================== */
#pragma mark - <FormInputAccessoryViewDelegate>

- (void)didSelectDone
{
    [_currentlyEditingCell setFocused:NO];
    [_currentlyEditingField resignFirstResponder];
    [_tableView deselectRowAtIndexPath:_selectedIndexPath animated:NO];
    if (_currentScrollAmount != 0)
    {
        [self scrollByAmount:-_currentScrollAmount];
        _currentScrollAmount = 0;
    }
    _currentlyEditingField = nil;
    if ([_form.delegate respondsToSelector:@selector(didSelectDone)])
    {
        [_form.delegate didSelectDone];
    }
}


- (void)didSelectPreviousField
{
    [self selectRowAtIndexPath:[_tableView previousIndexPathGiven:_selectedIndexPath]];
    if ([_form.delegate respondsToSelector:@selector(didSelectPreviousField)])
    {
        [_form.delegate didSelectPreviousField];
    }
}

- (void)didSelectNextField
{
    [self selectRowAtIndexPath:[_tableView nextIndexPathGiven:_selectedIndexPath]];
    if ([_form.delegate respondsToSelector:@selector(didSelectNextField)])
    {
        [_form.delegate didSelectNextField];
    }
}

/* ====================================================================================================================================== */
#pragma mark - <UITableViewDataSource> & <UITableViewDelegate>

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 34)];
    headerView.backgroundColor = [UIColor clearColor];

    UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 20, 200, 15)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = _form.colorScheme.sectionTitleColor;
    headerLabel.font = [UIFont systemFontOfSize:18];
    headerLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    [headerLabel sizeToFit];
    [headerView addSubview:headerLabel];
    return headerView;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    BCFormSection* formSection = [_form.sections objectAtIndex:section];
    return formSection.title;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([[self tableView:_tableView titleForHeaderInSection:section] length] > 0)
    {
        return 44;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    NSUInteger sections = [_form.sections count];
    return sections;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    BCFormSection* formSection = [_form.sections objectAtIndex:section];
    return [[formSection fields] count];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    BCAbstractCell* cell = (BCAbstractCell*) [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return [cell preferredHeight];
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    BCFormSection* section = [_form.sections objectAtIndex:indexPath.section];
    BCAbstractField* field = [[section fields] objectAtIndex:indexPath.row];
    BCAbstractCell* cell = [field cell];
    cell.indexPath = indexPath;
    BOOL focused = (_selectedIndexPath != nil && [_selectedIndexPath compare:indexPath] == NSOrderedSame);

    if (focused)
    {
        [self performSelectorOnMainThread:@selector(resignFirstResponder) withObject:_currentlyEditingField waitUntilDone:NO];
        _currentlyEditingField = cell.textField;
        [self setCurrentlyEditingCell:cell];
        [cell setFocused:YES];
        _selectedIndexPath = indexPath;
    }
    else
    {
        [cell setFocused:NO];
    }
    return cell;
}


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    BCFormSection* section = [_form.sections objectAtIndex:indexPath.section];
    BCAbstractField* field = [[section fields] objectAtIndex:indexPath.row];
    if (field.editable)
    {
        [tableView endEditing:YES];
        if ([indexPath compare:_selectedIndexPath] == NSOrderedSame)
        {
            [self scrollToAccommodateCell:_currentlyEditingCell];
            NSLog(@"Currently editing field: %@", _currentlyEditingCell.textField);
            [_currentlyEditingCell.textField resignFirstResponder];
            [_currentlyEditingCell.textField becomeFirstResponder];
        }
        else
        {
            NSIndexPath* previousSelectedCellIndexPath = _selectedIndexPath;
            _selectedIndexPath = indexPath;
            [_tableView scrollToRowAtIndexPath:_selectedIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            NSArray* rows;
            if (previousSelectedCellIndexPath == nil)
            {
                rows = [NSArray arrayWithObject:_selectedIndexPath];
            }
            else
            {
                rows = [NSArray arrayWithObjects:_selectedIndexPath, previousSelectedCellIndexPath, nil];
            }
            [tableView reloadRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationNone];

            BOOL previousButtonEnabled = [_selectedIndexPath compare:[tableView firstIndexPath]] == NSOrderedSame ? NO : YES;
            BOOL nextButtonEnabled = [_selectedIndexPath compare:[tableView lastIndexPath]] == NSOrderedSame ? NO : YES;
            [_formNavigationAccessory.previousButton setEnabled:previousButtonEnabled];
            [_formNavigationAccessory.nextButton setEnabled:nextButtonEnabled];
        }
    }
}


/* ============================================================ Private Methods ========================================================= */
- (void)initContentView
{
    _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_contentView];
}

- (void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 50, 300, 400) style:UITableViewStyleGrouped];

    [_tableView setBackgroundView:nil];
    [_tableView setBackgroundColor:[UIColor clearColor]];

    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_contentView addSubview:_tableView];
}

- (void)initNavigationAccessory
{
    _formNavigationAccessory = [BCDefaultInputAccessory viewWithDelegate:self];
}


/* ====================================================================================================================================== */
- (CGSize)keyboardSize;
{
    //TODO: Handle interface orientations and idioms (ie iPad vs iPhone)
    return CGSizeMake(320, 216);
}

- (CGRect)keyboardFrame;
{
    CGSize keyboardSize = [self keyboardSize];
    CGRect frame = CGRectMake(0, self.frame.size.height - keyboardSize.height, self.frame.size.width, keyboardSize.height);
    return frame;
}

- (void)setScrollable:(BOOL)isScrollable
{
    [_tableView setScrollEnabled:isScrollable];
}


/* ====================================================================================================================================== */
- (void)selectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self tableView:_tableView didSelectRowAtIndexPath:indexPath];
}

- (void)scrollToAccommodateCell:(BCAbstractCell*)cell
{
    CGPoint position = [self convertPoint:cell.frame.origin toView:nil];
    NSLog(@"Position: %@", NSStringFromCGPoint(position));
    CGFloat y = position.y;
    CGFloat scrollAmount = 0;
    CGFloat padding = 10.0;
    CGSize screenSize = [self screenSizeWithOrientation:[UIApplication sharedApplication].statusBarOrientation];
    CGSize accessorySize = _formNavigationAccessory.frame.size;
    CGSize cellSize = cell.frame.size;

    CGFloat actualY =
        screenSize.height - [self keyboardSize].height - accessorySize.height - cellSize.height - -_tableView.contentOffset.y - padding;
    CGFloat visibleY = actualY;

    if (y > visibleY)
    {
        scrollAmount = visibleY - y;
        CGFloat scrollDelta = scrollAmount - _currentScrollAmount;
        _currentScrollAmount = scrollAmount;
        [self scrollByAmount:scrollDelta];

    }
    else
    {
        if (_currentScrollAmount != 0)
        {
            _currentScrollAmount = 0;
            [UIView transitionWithView:self duration:0.4 options:UIViewAnimationOptionCurveEaseOut animations:^
            {
                _contentView.frame = [self bounds];
            } completion:nil];
        }
    }
}

- (void)scrollByAmount:(CGFloat)scrollDelta
{
    if (scrollDelta != 0)
    {
        CGRect scrollFrame = _contentView.frame;
        scrollFrame.origin.y += scrollDelta;
        [UIView transitionWithView:self duration:0.4 options:UIViewAnimationOptionTransitionNone animations:^
        {
            _contentView.frame = scrollFrame;
        } completion:nil];
    }
}

- (CGRect)rectWithOrientation:(int)orientation
{
    CGRect r = [UIScreen mainScreen].applicationFrame;
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        return CGRectMake(0, 0, r.size.height, r.size.width);
    }
    else
    {
        return CGRectMake(0, 0, r.size.width, r.size.height);
    }
}


- (CGSize)screenSizeWithOrientation:(int)orientation
{
    return [self rectWithOrientation:orientation].size;
}

@end