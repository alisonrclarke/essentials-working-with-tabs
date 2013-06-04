//
//  BankAccountDataSource.m
//  TabControlTutorial
//
//  Created by Alison Clarke on 08/05/2013.
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

#import "BankAccountDataSource.h"

@interface BankAccountDataSource ()
{
    @private
    NSMutableArray *accounts;
}
@end

@implementation BankAccountDataSource

- (id)init
{
    self = [super init];
    if (self)
    {
        accounts = [[NSMutableArray alloc] init];
    }
    return self;		
}	

- (void)addAccount:(BankAccount *)account
{
    [accounts addObject:account];
}

- (BankAccount*)accountAtIndex:(NSInteger)index
{
    return (BankAccount*)[accounts objectAtIndex:index];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [accounts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = ((BankAccount*)[accounts objectAtIndex:indexPath.row]).name;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    return cell;
}

@end
