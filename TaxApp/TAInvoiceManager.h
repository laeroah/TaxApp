//
//  TAInvoiceManager.h
//  TaxApp
//
//  Created by Hao Wang on 13-4-17.
//  Copyright (c) 2013年 wh. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TAInvoiceErrorDomain @"com.tax"

typedef enum {
    TAInvoiceTypeUnknown         = -1,
    TAInvoiceTypeVatSpecial    = 0,
    TAInvoiceTypeVatNormal = 1,
    TAInvoiceTypeVehicleSales = 2,
    TAInvoiceTypePedlarsMarket = 3 ,
    TAInvoiceTypePrint = 4
} TAInvoiceType;

typedef enum{
    TAInvoiceInfoItemTaxPassword = 1001, //密码
    TAInvoiceInfoItemInvoiceCode = 1002, //发票代码
    TAInvoiceInfoItemInvoiceNumber = 1003 , //发票号码
    TAInvoiceInfoItemSerialNo = 1004 , //机器编号
    TAInvoiceInfoItemIssueDate = 1005 , //开票日期
    TAInvoiceInfoItemAmount = 1006 , //开票金额
    TAInvoiceInfoItemTaxControlCode = 1007 , //税控码
    TAInvoiceInfoItemTaxPayerIdentification = 1008 , //纳税人识别号,
    TAInvoiceInfoItemTypeCaptcha = 1009 , //验证码
} TAInvoiceInfoItemType;

typedef enum {
    TAInvoiceInfoItemBadFormat = 1000,
} TAInvoiceInfoItemErrorCode;

@interface TAInvoiceManager : NSObject
{
    
}

+(TAInvoiceManager*)sharedInstance;
-(TAInvoiceType)getInvoiceTypeWithInvoiceCode:(NSString*)invoiceCode;
- (BOOL)isInvoiceInfoItemRequired:(TAInvoiceInfoItemType)invoiceInfoItemType invoiceType:(TAInvoiceType)invoiceType;
- (BOOL)checkInvoiceInfoItemValidation:(TAInvoiceInfoItemType)invoiceInfoItemType
                                 value:(NSString*)invoiceInfoItemValue
                           invoiceType:(TAInvoiceType)invoiceType
                               failure:(void (^)(NSError *error))failure;
@end
