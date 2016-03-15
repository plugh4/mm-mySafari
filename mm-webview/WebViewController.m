//
//  WebViewController.m
//  mm-webview
//
//  Created by Christopher Serra on 3/15/16.
//  Copyright © 2016 plugh. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    [self loadURL:@"http://www.mobilemakers.co"];
}


#pragma mark -
#pragma mark UIWebView delegates


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.spinner stopAnimating];

    
    UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"Load failed"
                                            message:error.localizedDescription
                                     preferredStyle:UIAlertControllerStyleAlert
         ];
    UIAlertAction *homeButton =
        [UIAlertAction actionWithTitle:@"Home"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * _Nonnull action)
    {
        [self loadURL:@"http://www.mobilemakers.co"];
    }];
    UIAlertAction *cancelButton =
        [UIAlertAction actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * _Nonnull action) {}
         ];

    [alert addAction:homeButton];
    [alert addAction:cancelButton];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark -
#pragma mark UITextField delegates


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self loadURL:textField.text];

    return YES;
}


#pragma mark -
#pragma mark utility


- (void) loadURL:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlReq];
}


@end
