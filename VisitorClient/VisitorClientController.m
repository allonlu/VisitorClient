//
//  VisitorClientController.m
//  VisitorClient
//
//  Created by Allon on 5/26/15.
//  Copyright (c) 2015 Allon. All rights reserved.
//

#import "VisitorClientController.h"

@implementation VisitorClientController


NSString * _chatUrl;

UIWebView * _viewChatWindow;
UIActivityIndicatorView * _indicator;


-(id) initWithChatUrl:(NSString *)url{
    self = [super init];
    
    if(self){
        _chatUrl = [url copy];
        
    }
    
    return self;
}

-(void) viewDidLoad{
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"Chat"];
    

    _viewChatWindow = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_viewChatWindow setDelegate:self];
    [_viewChatWindow setAlpha:0.0];
    [self.view addSubview:_viewChatWindow];
    
    [_viewChatWindow setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view" : _viewChatWindow}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view" : _viewChatWindow}]];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 25, self.view.frame.size.height / 2 - 25, 50, 50)];
    [_indicator setColor:[UIColor blackColor]];
    [_indicator startAnimating];
    [self.view addSubview:_indicator];
    
    [_indicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    NSURL * url = [NSURL URLWithString:_chatUrl];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    [_viewChatWindow loadRequest:request];
}





- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
-(void) webViewDidFinishLoad:(UIWebView *)webView{
    void (^showChatWindow)(void) = ^(void){
        [_viewChatWindow setAlpha:1.0];
        [_indicator setAlpha:0.0];
    };
    
    void(^stopIndicator)(BOOL) = ^(BOOL finished){
        [_indicator stopAnimating];
    };
    
    [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:showChatWindow completion:stopIndicator];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    
}

-(void) dealloc{
    [_viewChatWindow setDelegate:nil];
}



@end
