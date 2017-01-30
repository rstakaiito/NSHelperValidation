# NSHelperValidation
Helper Form Validation for IOS 


Sample

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
