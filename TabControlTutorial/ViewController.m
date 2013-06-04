//
//  ViewController.m
//  TabControlTutorial
//
//  Created by Alison Clarke on 07/05/2013.
//  
//  Copyright 2013 Scott Logic
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "ViewController.h"
#import "BankAccount.h"
#import "BankAccountDataSource.h"

#define DEFAULT_TAB_NAME @"Choose an account:"

@interface ViewController ()
{
    @private
    // Dictionary to hold our mappings from tabs to views
    NSMutableDictionary *mapTabToView;
    // Source for bank account data
    BankAccountDataSource *dataSource;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Create and set up a bank account data source
    dataSource = [[BankAccountDataSource alloc] init];
    [dataSource addAccount:[[BankAccount alloc] initWithName:@"My Checking Account" accountNumber:12345678 routingNumber:123456789 balance:394.27]];
    [dataSource addAccount:[[BankAccount alloc] initWithName:@"Joint Checking Account" accountNumber:38472363 routingNumber:352483956 balance:52.39]];
    [dataSource addAccount:[[BankAccount alloc] initWithName:@"Savings Account" accountNumber:28361234 routingNumber:392756386 balance:8364.28]];
    [dataSource addAccount:[[BankAccount alloc] initWithName:@"Mortgage" accountNumber:98342563 routingNumber:243138287 balance:-163872.36]];
    
    // Create the tabbed view
    tabbedView = [[SEssentialsTabbedView alloc] initWithFrame:self.view.frame];
    
    // Enable the "new tab" button
    tabbedView.hasNewTabButton = YES;
    
    // Set the tabs to a fixed size, rather than resizing when their text changes
    tabbedView.resizeToText = NO;
    
    // Set the theme
    [SEssentialsTheme setSharedTheme:[SEssentialsLightTheme new]];
    // Update the style for the tab headers
    tabbedView.style.defaultFont = [UIFont systemFontOfSize:16];
    
    // Set its datasource and delegate to be ourself
    tabbedView.dataSource = self;
    tabbedView.delegate = self;
    
    // Set up the Tab=>View dictionary
    mapTabToView = [[NSMutableDictionary alloc] init];
    
    // Add a tab to start with
    [tabbedView addTab:[self tabForTabbedView:tabbedView]];
    
    // Add the tabbed view to our main view
    [self.view addSubview:tabbedView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)createDefaultView
{
    // Create a view to display in the tab
    UIView *defaultView = [[UIView alloc] initWithFrame:[tabbedView contentViewBounds]];
    
    // Create a table view to display the different account names
    UITableView *defaultTableView = [[UITableView alloc] initWithFrame:[tabbedView contentViewBounds] style:UITableViewStylePlain];
    defaultTableView.dataSource = dataSource;
    defaultTableView.delegate = self;
    
    // Add the table view to the main view
    [defaultView addSubview:defaultTableView];
    
    return defaultView;
}

- (void)resetTab:(SEssentialsTab *)tab
{
    // Create a default view
    UIView *defaultView = [self createDefaultView];
    // Update our mapping
    [mapTabToView setObject:defaultView forKey:[NSValue valueWithNonretainedObject:tab]];
    // Update the tab name
    tab.name = DEFAULT_TAB_NAME;
    [tab.tabHeaderView updateView];
    // Call activateTab to re-render the tab's contents
    [tabbedView activateTab:tab];
}

#pragma mark - Tabbed view data source

- (UIView *)tabbedView:(SEssentialsTabbedView *)tabbedViewRef contentForTab:(SEssentialsTab *)tab
{
    // Just get the view out of our dictionary
    return [mapTabToView objectForKey:[NSValue valueWithNonretainedObject:tab]];
}

- (SEssentialsTab *)tabForTabbedView:(SEssentialsTabbedView *)tabbedViewRef
{
    // Create a new tab
    SEssentialsTab *myTab = [[SEssentialsTab alloc] initWithName:DEFAULT_TAB_NAME icon:nil];
    
    // Create a default view to display in the tab
    UIView *defaultView = [self createDefaultView];
    
    // Add the view and tab to our dictionary
    [mapTabToView setObject:defaultView forKey:[NSValue valueWithNonretainedObject:myTab]];
    
    // Return the tab
    return myTab;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create a new text view based on the selected account
    BankAccount* account = [dataSource accountAtIndex:indexPath.row];
    UITextView* newView = [[UITextView alloc] initWithFrame:CGRectMake(30, 20, tableView.bounds.size.height-60, tableView.bounds.size.width-40)];
    newView.font = [UIFont systemFontOfSize:18];
    newView.textColor = [SEssentialsTheme sharedTheme].primaryTextColor;
    [newView setEditable:NO];
    [newView setText:[account description]];
    
    // Replace the table view with our new view
    UIView *parentView = tableView.superview;
    [parentView addSubview:newView];
    [tableView removeFromSuperview];    
    
    // Change the name of the current tab
    SEssentialsTab *tab = tabbedView.activeTab;
    tab.name = account.name;
    // Call updateView on the tab's header view to update its name in the display
    [tab.tabHeaderView updateView];
}

#pragma mark - Tabbed view delegate

- (BOOL)tabbedView:(SEssentialsTabbedView *)tabbedViewRef shouldRemoveTab:(SEssentialsTab *)tab
{
    // If this is the last tab, reset it instead of removing it
    if ([tabbedViewRef.allTabs count] == 1)
    {
        [self resetTab:tab];
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
