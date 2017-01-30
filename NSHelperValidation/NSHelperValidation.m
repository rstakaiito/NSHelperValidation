//
//  NSHelperValidation.m
//  Campus
//
//  Created by Duong Viet Cuong on 4/19/16.
//  Copyright © 2016 Newsoft. All rights reserved.
//

#import "NSHelperValidation.h"

@implementation NSHelperValidation


-(instancetype)init{
    NSHelperValidation *v = self;
    arrRules = [[NSMutableArray alloc] init];
    return v;
}

-(BOOL)validation:(void (^)())success
           onFail:(void (^)(NSString *key,NSString *type,NSString *msg))onfail{
    NSString *rKey = @"";
    NSString *rContent = @"";
    NSString *rRule = @"";
    for (NSArray *rule in arrRules) {
        rKey = [rule objectAtIndex:0];
        rContent = [rule objectAtIndex:1];
        rRule = [rule objectAtIndex:2];
        if ([rRule isEqualToString:@"null"]) {
            // Check null
            if ([self checkEmpty:rContent]) {
                // Is NUll
                onfail(rKey,rRule,[NSString stringWithFormat:@"Vui lòng không để rỗng %@ ",rKey]);
                return false;
            }
        }
        if ([rRule isEqualToString:@"email"]) {
            if (![self checkIsEmail:rContent]) {
                // Is NUll
                onfail(rKey,rRule,[NSString stringWithFormat:@"%@ cần là một email",rKey]);
                return false;
            }
        }
    }
    success();
    return true;
}

-(void)addValidation:(NSString *)key source:(NSString *)content conditions:(NSArray *)conditions{
    for (NSString *rule_condition in conditions) {
        [arrRules addObject:@[key,content,rule_condition]];
    }
}


-(BOOL)checkEmpty:(NSString *)text{ 
    return [[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""];
}

-(BOOL)checkIsEmail:(NSString *)text{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:text];
}

@end
