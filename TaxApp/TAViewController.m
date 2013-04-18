//
//  TAViewController.m
//  TaxApp
//
//  Created by Hao Wang on 13-04-17.
//  Copyright (c) 2013 wh. All rights reserved.
//

#import "TAViewController.h"
#import "TAResultViewController.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import <TouchXML.h>

#define VERIFICATION_URL_FORMAT @"http://www.bjtax.gov.cn/ptfp/turn.jsp?valiNum=%@&fpdm=%@&fphm=%@&sfzh=%@&fpmm=%@&ip=127.0.0.1&kpri=%@&nsr=%@&isFrist=%d"

typedef enum{
    ReceiptInfoLocalVerificationResultSuccess,
    ReceiptInfoLocalVerificationResultSerialNumberEmpty,
    ReceiptInfoLocalVerificationResultSecondaryNumberEmpty,
    ReceiptInfoLocalVerificationResultTaxplayerNumberEmpty,
    ReceiptInfoLocalVerificationResultVerificationCodeEmpty,
    ReceiptInfoLocalVerificationResultPasswordEmpty
}ReceiptInfoLocalVerificationResult;

@interface TAViewController ()
{
    BOOL _needTaxPayerNumber;
    BOOL _needReceiptPassword;
    AFHTTPClient *_httpClient;
    CGFloat _overlayMessageYOffset;
}

@property (weak, nonatomic) IBOutlet UIButton *verifyCodeButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *verificationCodeLoadingIndicator;

// info cells
@property (weak, nonatomic) IBOutlet UITextField *receiptSerialNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *receiptSecondaryNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *taxPayerNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *receiptPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;

@property (weak, nonatomic) IBOutlet UISwitch *firstTimeVerifySwitch;

@end

@implementation TAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showPasswordRow:YES];
    [self showTaxPayerRow:YES];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    [self refreshCookie];
    [self getVerifyCodeButtonImage];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getVerifyCodeButtonImage
{
    [self.verificationCodeLoadingIndicator startAnimating];
    [self.verifyCodeButton setHidden:YES];
    
    NSURLRequest *codeImageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.bjtax.gov.cn/ptfp/turnTest.jsp"]];
    AFImageRequestOperation *imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest:codeImageRequest success:^(UIImage *image)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.verifyCodeButton setBackgroundImage:image forState:UIControlStateNormal];
            [self.verificationCodeLoadingIndicator stopAnimating];
            [self.verifyCodeButton setHidden:NO];
        });
    }];
    
    [imageOperation start];
}

- (void)refreshCookie
{
    NSURL *url = [NSURL URLWithString:@"http://www.bjtax.gov.cn/ptfp/"];
    _httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request = [_httpClient requestWithMethod:@"GET" path:@"http://www.bjtax.gov.cn/ptfp/fpindex.jsp" parameters:nil];
    [request setCachePolicy:NSURLCacheStorageNotAllowed];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [_httpClient enqueueHTTPRequestOperation:operation];
}

- (void)sendForVerification
{
    [self showOverlayMessage:@"发票验证中 ..." hideAfterDelay:0.0f];
    
    NSMutableURLRequest *request = [_httpClient requestWithMethod:@"GET" path:[self urlStringForReceiptVerification] parameters:nil];
    NSLog(@"sending verification request to: %@", [self urlStringForReceiptVerification]);    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"respond string: %@", responseString);
        if (responseString) {
            CXMLDocument *doc= [[CXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
            NSArray *nodes = [doc nodesForXPath:@"/NS/N[@D='YZM']" error:nil];
            
            if ([nodes count] > 0) {
                
                CXMLElement *verificationCodeNode = [nodes lastObject];
                NSString *verificationCodeNodeValue = [verificationCodeNode stringValue];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self hideAllOverlayMessage];
                    
                    if ([verificationCodeNodeValue isEqualToString:@"1"]) {
                        [self performSegueWithIdentifier:@"showResultSegue" sender:responseString];
                    }else{
                        [self showOverlayMessage:@"验证码错误!" hideAfterDelay:2.0];
                    }
                });
            }
        }else{
            [self refreshCookie];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideAllOverlayMessage];
                [self showOverlayMessage:@"请求失败!" hideAfterDelay:1.0];
            });
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideAllOverlayMessage];
            [self showOverlayMessage:@"请求失败!" hideAfterDelay:1.0];
        });
    }];
    
    [_httpClient enqueueHTTPRequestOperation:operation];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"showResultSegue"])
    {
        NSString *responseString = (NSString *)sender;
        UINavigationController *resultViewControllerNavController = [segue destinationViewController];
        [(TAResultViewController *)[resultViewControllerNavController topViewController] displayResultWithResultString:responseString];
    }
}

- (void)hideAllOverlayMessage
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}


#define MESSAGE_Y_OFFSET -50.0f
- (void)showOverlayMessage:(NSString *)msg hideAfterDelay:(NSTimeInterval)seconds
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *overlayMessageView = [[MBProgressHUD alloc] initWithView:self.view];
        overlayMessageView.removeFromSuperViewOnHide = YES;
        overlayMessageView.userInteractionEnabled = YES;
        overlayMessageView.yOffset = MESSAGE_Y_OFFSET;
        
        [self.view addSubview:overlayMessageView];
        [self.view bringSubviewToFront:overlayMessageView];
        overlayMessageView.mode = MBProgressHUDModeText;
        
        if ([msg length] < 20) {
            overlayMessageView.labelText = msg;
        }else{
            overlayMessageView.detailsLabelText = msg;
        }
        
        [overlayMessageView show:YES];
        
        if (seconds > 0) {
            [overlayMessageView hide:YES afterDelay:seconds];
        }
    });
}

- (ReceiptInfoLocalVerificationResult)verifyInputInfoTextFields
{
    if ([self.receiptSerialNumberTextField.text length] <= 0) {
        return ReceiptInfoLocalVerificationResultSerialNumberEmpty;
    }else if ([self.receiptSecondaryNumberTextField.text length] <= 0) {
        return ReceiptInfoLocalVerificationResultSecondaryNumberEmpty;
    }else if ([self.receiptPasswordTextField.text length] <= 0 && _needReceiptPassword) {
        return ReceiptInfoLocalVerificationResultPasswordEmpty;
    }else if ([self.taxPayerNumberTextField.text length] <= 0 && _needTaxPayerNumber) {
        return ReceiptInfoLocalVerificationResultTaxplayerNumberEmpty;
    }else if ([self.verificationCodeTextField.text length] <= 0){
        return ReceiptInfoLocalVerificationResultVerificationCodeEmpty;
    }else{
        return ReceiptInfoLocalVerificationResultSuccess;
    }
}

- (NSString *)urlStringForReceiptVerification
{
    return [NSString stringWithFormat:VERIFICATION_URL_FORMAT, [self.verificationCodeTextField.text lowercaseString], self.receiptSerialNumberTextField.text, self.receiptSecondaryNumberTextField.text, @"", self.receiptPasswordTextField.text, @"", @"", !self.firstTimeVerifySwitch.on]; //!self.firstTimeVerifySwitch.on because server side bug, isFirst is used the wrong way
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.receiptSerialNumberTextField) {
        _needReceiptPassword = !_needReceiptPassword;
        [self showPasswordRow:_needReceiptPassword];
    }
}

#pragma mark - UITableViewDelegate
#define PASSWORD_SECTION 2
#define TAXPAYER_SECTION 3
#define VERIFICATION_SECTION 5

// hide/show each section based on current receipt
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == PASSWORD_SECTION && !_needReceiptPassword) {
        return 0.0f;
    }else if (section == TAXPAYER_SECTION && !_needTaxPayerNumber){
        return 0.0f;
    }else{
        return 1.0f;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *headerTitle = [super tableView:tableView titleForHeaderInSection:section];
    
    if (section == PASSWORD_SECTION && !_needReceiptPassword) {
        return @"";
    }else if (section == TAXPAYER_SECTION && !_needTaxPayerNumber){
        return @"";
    }else{
        return headerTitle;
    }
}

#pragma mark - adjust tableview
- (void)showPasswordRow:(BOOL)show
{
    _needReceiptPassword = show;
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:PASSWORD_SECTION] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)showTaxPayerRow:(BOOL)show
{
    _needTaxPayerNumber = show;
    if (!_needTaxPayerNumber) {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:TAXPAYER_SECTION] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        [self.tableView reloadData];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *huds = [MBProgressHUD allHUDsForView:self.view];
    
    CGFloat yOffset = scrollView.contentOffset.y;
    
    for (MBProgressHUD *hud in huds) {
        CGRect currentFrame = hud.frame;
        hud.frame = CGRectMake(currentFrame.origin.x, MESSAGE_Y_OFFSET + 50 + yOffset, currentFrame.size.width, currentFrame.size.height);
    }
    
}


#pragma mark - actions
- (IBAction)showResultController:(id)sender {
    
    [self.view endEditing:YES];
    ReceiptInfoLocalVerificationResult localVerificationResult = [self verifyInputInfoTextFields];
    
    switch (localVerificationResult) {
        case ReceiptInfoLocalVerificationResultSerialNumberEmpty:
            [self showOverlayMessage:@"发票代码不能为空!" hideAfterDelay:1.0];
            break;
        case ReceiptInfoLocalVerificationResultSecondaryNumberEmpty:
            [self showOverlayMessage:@"发票号码不能为空!" hideAfterDelay:1.0];
            break;
        case ReceiptInfoLocalVerificationResultPasswordEmpty:
            [self showOverlayMessage:@"发票密码不能为空!" hideAfterDelay:1.0];
            break;
        case ReceiptInfoLocalVerificationResultTaxplayerNumberEmpty:
            [self showOverlayMessage:@"纳税人税控号不能为空!" hideAfterDelay:1.0];
            break;
        case ReceiptInfoLocalVerificationResultVerificationCodeEmpty:
            [self showOverlayMessage:@"验证码不能为空!" hideAfterDelay:1.0];
            break;
        case ReceiptInfoLocalVerificationResultSuccess:
            [self sendForVerification];
            
        default:
            break;
    }
    
}

- (IBAction)requestForNewVerificationCode:(id)sender {
    [self getVerifyCodeButtonImage];
}


@end
