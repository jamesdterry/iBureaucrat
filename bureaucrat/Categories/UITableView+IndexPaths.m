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



#import "UITableView+IndexPaths.h"


@implementation UITableView (IndexPaths)

- (NSIndexPath*)nextIndexPathGiven:(NSIndexPath*)indexPath
{
    NSIndexPath* nextIndexPath = nil;
    if ([self canEvaluateNextOrPreviousIndexPathGiven:indexPath])
    {
        id <UITableViewDataSource> delegate = self.dataSource;
        NSInteger sections = [delegate numberOfSectionsInTableView:self];
        NSInteger rowsInSection = [delegate tableView:self numberOfRowsInSection:indexPath.section];
        NSInteger nextRow = indexPath.row + 1;

        if (nextRow == rowsInSection && indexPath.section <= (sections - 1))
        {
            nextIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section + 1];
        }
        else
        {
            nextIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
        }
    }
    return nextIndexPath;
}

- (NSIndexPath*)previousIndexPathGiven:(NSIndexPath*)indexPath
{
    NSIndexPath* previousIndexPath = nil;
    if ([self canEvaluateNextOrPreviousIndexPathGiven:indexPath])
    {
        id <UITableViewDataSource> delegate = self.dataSource;
        NSInteger previousRow = indexPath.row - 1;

        if (previousRow < 0 && indexPath.section > 0)
        {
            NSInteger previousSection = indexPath.section - 1;
            NSInteger lastRowInSection = ([delegate tableView:self numberOfRowsInSection:previousSection]) - 1;
            previousIndexPath = [NSIndexPath indexPathForRow:lastRowInSection inSection:previousSection];
        }
        else
        {
            previousIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
        }
    }
    return previousIndexPath;
}

- (NSIndexPath*)firstIndexPath
{
    NSIndexPath* path = nil;
    id <UITableViewDataSource> delegate = self.dataSource;
    NSInteger sections = [delegate numberOfSectionsInTableView:self];
    if (sections > 0 && ([delegate tableView:self numberOfRowsInSection:0]) > 0)
    {
        path = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return path;
}


- (NSIndexPath*)lastIndexPath
{
    NSIndexPath* path = nil;
    id <UITableViewDataSource> delegate = self.dataSource;
    NSInteger sections = [delegate numberOfSectionsInTableView:self];
    NSInteger rows = [delegate tableView:self numberOfRowsInSection:sections -1];
    if (sections > 0 && rows > 0)
    {
        path = [NSIndexPath indexPathForRow:rows -1 inSection:sections - 1];
    }
    return path;
}


/* ============================================================ Private Methods ========================================================= */
- (BOOL)canEvaluateNextOrPreviousIndexPathGiven:(NSIndexPath*)indexPath
{
    BOOL canEvaluate = YES;
    if (indexPath == nil)
    {
        canEvaluate = NO;
    }
    else if (self.delegate == nil)
    {
        canEvaluate = NO;
    }
    else
    {
        id <UITableViewDataSource> delegate = self.dataSource;
        NSInteger sections = [delegate numberOfSectionsInTableView:self];
        if (indexPath.section >= sections || indexPath.section < 0)
        {
            canEvaluate = NO;
        }
    }
    return canEvaluate;
}

@end