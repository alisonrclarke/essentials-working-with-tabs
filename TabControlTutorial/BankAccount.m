//
//  BankAccount.m
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

#import "BankAccount.h"

@implementation BankAccount

- (id)initWithName:(NSString*)name accountNumber:(int)accountNumber routingNumber:(int)routingNumber balance:(double)balance
{
    self = [super init];
    if (self) {
        _name = name;
        _accountNumber = accountNumber;
        _routingNumber = routingNumber;
        _balance = balance;
    }
    return self;
}

- (NSString *)description {
    // Return a string which will lay out the account details using tabs - this is just for simplicity of displaying the account details in the UI for the purposes of the demo app
    return [NSString stringWithFormat: @"Account Name:\t\t\t\t%@\n\nAccount Number:\t\t\t\t%d\n\nRouting Number:\t\t\t\t%d\n\nBalance:\t\t\t\t\t\t$%.02f", _name, _accountNumber, _routingNumber, _balance];
}

@end
