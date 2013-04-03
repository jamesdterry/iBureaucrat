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
#import "BCFormInputAccessoryView.h"
#import "BCFormSection.h"
#import "UITableView+IndexPaths.h"
#import "BCAbstractFormCell.h"
#import "BCAbstractFormField.h"
#import "UITextField+AbstractFormCell.h"
#import "BCForm.h"
#import "CKUITools.h"

@interface BCFormView ()

@property(nonatomic, strong) BCAbstractFormCell* currentlyEditingCell;

@end


@implementation BCFormView

/* ============================================================ Initializers ============================================================ */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initContentView];
        [self initTableView];
        [self initKeyboardAccessory];
    }
    return self;
}


/* ========================================================== Interface Methods ========================================================= */
- (void) setForm:(BCForm*)form
{
    _form = form;
    _form.view = self;
    NSLog(@"Using form: %@", form);
//    [[NSNotificationCenter defaultCenter] notifyColorsChanged];
}

- (void)setCurrentlyEditingCell:(BCAbstractFormCell*)currentlyEditingCell
{
    _currentlyEditingCell = currentlyEditingCell;
    if (_currentlyEditingCell)
    {
        [self scrollToAccommodateCell:_currentlyEditingCell];
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

    _tableView.width = self.width - 20;
    _tableView.position = (CGPoint) {(_contentView.width - _tableView.width) / 2, 60};
    _tableView.height = _contentView.height - _tableView.y - 20;
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
    if (_currentlyEditingField != textField)
    {
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
    [self hideNavigationAccessory];
    if (_currentScrollAmount != 0)
    {
        [self scrollByAmount:-_currentScrollAmount];
        _currentScrollAmount = 0;
    }
    _currentlyEditingField = nil;
}


- (void)didSelectPreviousField
{
    [self selectRowAtIndexPath:[_tableView previousIndexPathGiven:_selectedIndexPath]];
}

- (void)didSelectNextField
{
    [self selectRowAtIndexPath:[_tableView nextIndexPathGiven:_selectedIndexPath]];
}

/* ====================================================================================================================================== */
#pragma mark - <UITableViewDataSource> & <UITableViewDelegate>

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 34)];
    headerView.backgroundColor = [UIColor clearColor];

    UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 20, 200, 15)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = _form.sectionTitleColor;
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
    return 44;
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

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    BCFormSection* section = [_form.sections objectAtIndex:indexPath.section];
    BCAbstractFormField* field = [[section fields] objectAtIndex:indexPath.row];
    BCAbstractFormCell* cell = [field cell];
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
    [_currentlyEditingCell setFocused:NO];
    [tableView endEditing:YES];
    [self showNavigationAccessory];
    if ([indexPath compare:_selectedIndexPath] == NSOrderedSame)
    {
        [self scrollToAccommodateCell:_currentlyEditingCell];
        [_currentlyEditingCell.textField becomeFirstResponder];
    }
    else
    {
        NSIndexPath* previousSelectedCellIndexPath = _selectedIndexPath;
        _selectedIndexPath = indexPath;
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


/* ============================================================ Private Methods ========================================================= */
- (void)initContentView
{
    _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_contentView];
}

- (void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 50, 300, 400) style:UITableViewStyleGrouped];

    UIView* backgroundView = [[UIView alloc] init];
    [backgroundView setBackgroundColor:[UIColor clearColor]];
    [_tableView setBackgroundView:backgroundView];
    [_tableView setScrollEnabled:NO];

    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_contentView addSubview:_tableView];
}

- (void)initKeyboardAccessory
{
    _formNavigationAccessory = [BCFormInputAccessoryView viewWithDelegate:self];
}


/* ====================================================================================================================================== */
- (void)showNavigationAccessory
{
    [_formNavigationAccessory setFrame:[self navigationAccessoryFrame]];
    [self addSubview:_formNavigationAccessory];
}

- (void)hideNavigationAccessory
{
    [_formNavigationAccessory removeFromSuperview];
}

- (CGSize)keyboardSize;
{
    //TODO: Handle interface orientations and idioms (ie iPad vs iPhone)
    return CGSizeMake(320, 216);
}

- (CGRect)onScreenKeyboardFrame;
{
    CGSize keyboardSize = [self keyboardSize];
    CGRect frame = CGRectMake(0, self.height - keyboardSize.height, self.width, keyboardSize.height);
    return frame;
}

- (CGRect)offScreenKeyboardFrame;
{
    CGSize keyboardSize = [self keyboardSize];
    CGRect frame = CGRectMake(0, self.height, self.width, keyboardSize.height);
    return frame;
}

- (CGRect)navigationAccessoryFrame
{
    CGRect keyboardFrame = [self onScreenKeyboardFrame];
    return CGRectMake(0, keyboardFrame.origin.y - _formNavigationAccessory.size.height, self.width, _formNavigationAccessory.height);
}


/* ====================================================================================================================================== */
- (void)selectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self tableView:_tableView didSelectRowAtIndexPath:indexPath];
}

- (void)scrollToAccommodateCell:(BCAbstractFormCell*)cell
{
    CGFloat y = cell.position.y;
    CGRect keyboardFrame = [self onScreenKeyboardFrame];
    CGFloat scrollAmount = 0;
    CGFloat visibleY = keyboardFrame.origin.y - _formNavigationAccessory.height - cell.height - 70;
    if (y > visibleY)
    {
        scrollAmount = visibleY - y;
        CGFloat scrollDelta = scrollAmount - _currentScrollAmount;
        _currentScrollAmount = scrollAmount;
        [self scrollByAmount:scrollDelta];

    }
    else
    {
        _currentScrollAmount = 0;
        [UIView transitionWithView:self duration:0.4 options:UIViewAnimationOptionCurveEaseOut animations:^
        {
            _contentView.frame = [self bounds];
        } completion:nil];
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

@end