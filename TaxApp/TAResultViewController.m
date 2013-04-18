//
//  TAResultViewController.m
//  TaxApp
//
//  Created by Hao Wang on 13-04-17.
//  Copyright (c) 2013 wh. All rights reserved.
//

#import "TAResultViewController.h"
#import <TouchXML.h>

@interface TAResultViewController ()

@property (weak, nonatomic) IBOutlet UILabel *receiptSerialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *receiptSecondaryNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *trueFalseLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;

@end

@implementation TAResultViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - public
- (void)displayResultWithResultString:(NSString *)resultString
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CXMLDocument *doc= [[CXMLDocument alloc] initWithXMLString:resultString options:0 error:nil];
        
        //发票代码
        NSArray *nodes = [doc nodesForXPath:@"/NS/N[@D='FPDM']" error:nil];
        
        if ([nodes count] > 0) {
            
            CXMLElement *node = [nodes lastObject];
            NSString *value = [node stringValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.receiptSerialNumberLabel.text = value;
            });
        }
        
        //发票号码
        nodes = [doc nodesForXPath:@"/NS/N[@D='FPHM']" error:nil];
        
        if ([nodes count] > 0) {
            
            CXMLElement *node = [nodes lastObject];
            NSString *value = [node stringValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.receiptSecondaryNumberLabel.text = value;
            });
        }
        
        //开票单位
        nodes = [doc nodesForXPath:@"/NS/N[@D='DWMC']" error:nil];
        
        if ([nodes count] > 0) {
            
            CXMLElement *node = [nodes lastObject];
            NSString *value = [node stringValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.ownerLabel.text = value;
            });
        }
        
        
        //小节
        nodes = [doc nodesForXPath:@"/NS/N[@D='CXJG']" error:nil];
        
        if ([nodes count] > 0) {
            
            CXMLElement *node = [nodes lastObject];
            NSString *value = [node stringValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.resultTextLabel.text = value;
            });
        }
        
        //真假
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([resultString rangeOfString:@"fj"].location != NSNotFound) {
                self.trueFalseLabel.text = @"假";
                self.trueFalseLabel.textColor = [UIColor redColor];
            }else if([resultString rangeOfString:@"tz"].location != NSNotFound) {
                self.trueFalseLabel.text = @"真";
                self.trueFalseLabel.textColor = [UIColor greenColor];
            }else{
                self.trueFalseLabel.text = @"无法确定";
                self.trueFalseLabel.textColor = [UIColor blackColor];
            }
         });
        
//        nodes = [doc nodesForXPath:@"/NS/N[@D='zj']" error:nil];
//        
//        if ([nodes count] > 0) {
//            
//            CXMLElement *node = [nodes lastObject];
//            NSString *value = [node stringValue];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                if ([value isEqualToString:@"1"]) {
//                    self.trueFalseLabel.text = @"真";
//                }else{
//                    self.trueFalseLabel.text = @"假";
//                }
//            });
//        }
        
    });
    
}

#pragma mark - actions
- (IBAction)confirmButtonDidPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
