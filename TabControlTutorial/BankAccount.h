//
//  BankAccount.h
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

#import <Foundation/Foundation.h>

@interface BankAccount : NSObject
@property (assign, readonly) NSString *name;
@property (assign, readonly) int accountNumber;
@property (assign, readonly) int routingNumber;
@property (assign, readonly) double balance;

- (id)initWithName:(NSString*)name accountNumber:(int)accountNumber routingNumber:(int)routingNumber balance:(double)balance;
@end
