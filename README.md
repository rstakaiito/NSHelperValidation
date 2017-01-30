# NSHelperValidation
Helper Form Validation cho IOS 

Cách đơn giản

    NSHelperValidation *helperV = [[NSHelperValidation alloc] init];
    
    [helperV addValidation:@"Name" source:txtDisplayName.text conditions:@[@"null"]];
    [helperV addValidation:@"Username" source:txtUsername.text conditions:@[@"null"]];
    [helperV addValidation:@"Password" source:txtPassword.text conditions:@[@"null"]];
    [helperV addValidation:@"Email" source:txtEmail.text conditions:@[@"null",@"email"]];
    [helperV addValidation:@"Phone" source:txtPhone.text conditions:@[@"null"]];
    
    return [helperV validation:^{
        // Done
        NSLog(@"Done");  
    } onFail:^(NSString *key, NSString *type, NSString *msg) {
        NSLog(@"Error");  
    }


Cách phức tạp hơn, khi lỗi sẽ gọi vào onFail trả về key(keyname, string validation error msg). ở đây gọi đến setHighlightOrFalse để tạo hiệu ứng cho cái view nhấp nháy

    - (void)cleanHightLight:(NSArray *)arrItems{
        for (UIView* item in arrItems) {
            [item setBackgroundColor: defaultColorField];
        }
    }

    - (void)setHighlightOrFalse:(UIView*)target isError:(BOOL)isError{
        if(isError){
            [target setBackgroundColor: defaultColorField];
            [UIView animateWithDuration:0.5 animations:^{
                [target setBackgroundColor: [UIColor orangeColor]];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1 animations:^{
                    [target setBackgroundColor: highlColorField];
                } completion:^(BOOL finished) {
                }];
            }];
        }else{
            [target setBackgroundColor: defaultColorField];
        }
    }

    NSHelperValidation *helperV = [[NSHelperValidation alloc] init];
    [helperV addValidation:@"Name" source:txtDisplayName.text conditions:@[@"null"]];
    [helperV addValidation:@"Username" source:txtUsername.text conditions:@[@"null"]];
    [helperV addValidation:@"Password" source:txtPassword.text conditions:@[@"null"]];
    [helperV addValidation:@"Email" source:txtEmail.text conditions:@[@"null",@"email"]];
    [helperV addValidation:@"Phone" source:txtPhone.text conditions:@[@"null"]];
    
    
    return [helperV validation:^{
        // Done, callback it
        NSLog(@"Done");
        success();
        
    } onFail:^(NSString *key, NSString *type, NSString *msg) {
        
        NSDictionary *keyRef = @{
                                 @"Email":layerEmail,
                                 @"Name":layerDisplayName,
                                 @"Username":layerUsername,
                                 @"Password":layerPassword,
                                 @"Phone":layerPhone
                                 };
        NSDictionary *keyFocus = @{
                                   @"Email":txtEmail,
                                   @"Name":txtDisplayName,
                                   @"Username":txtUsername,
                                   @"Password":txtPassword,
                                   @"Phone":txtPhone
                                   };
        
        [self setHighlightOrFalse:[keyRef objectForKey:key] isError:YES];
        
        UITextField *txt = (UITextField *)[keyFocus objectForKey:key];
        [txt becomeFirstResponder];
        
        if (![type isEqualToString:@"null"]) {
            [[[UIAlertView alloc] initWithTitle:@""
                                        message:msg
                                       delegate:nil
                              cancelButtonTitle:@"Close"
                              otherButtonTitles:nil, nil] show];
        }
        NSLog(@"Form validation %@",msg);
        
    }];
