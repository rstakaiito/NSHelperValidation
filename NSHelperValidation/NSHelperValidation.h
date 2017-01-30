//
//  NSHelperValidation.h
//  Campus
//
//  Created by Duong Viet Cuong on 4/19/16.
//  Copyright © 2016 Newsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSHelperValidation : NSObject{
    NSMutableArray *arrRules;
}

-(void)addValidation:(NSString *)key source:(NSString *)content conditions:(NSArray *)conditions;

-(BOOL)validation:(void (^)())success
           onFail:(void (^)(NSString *key,NSString *type,NSString *msg))onfail;

-(BOOL)checkEmpty:(NSString *)text;

@end
