//
//  TAInvoiceManager.m
//  TaxApp
//
//  Created by wattpad on 13-4-17.
//  Copyright (c) 2013年 wh. All rights reserved.
//

#import "TAInvoiceManager.h"

@implementation TAInvoiceManager


#pragma mark - Shared Instance

+ (TAInvoiceManager *)sharedInstance
{
    static TAInvoiceManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        sharedInstance = [[TAInvoiceManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Invoice Type


- (NSDictionary *)invoiceCodeToTypeMap
{
    
    return
    @{
    @"1100083170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100023170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100024170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100001170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100002170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100021170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100022170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100031170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100981171":  @(TAInvoiceTypeVatSpecial) ,
    @"1100031171":  @(TAInvoiceTypeVatSpecial) ,
    @"1100001141":  @(TAInvoiceTypeVatSpecial) ,
    @"1100002141":  @(TAInvoiceTypeVatSpecial) ,
    @"1100013141":  @(TAInvoiceTypeVatSpecial) ,
    @"1100022141":  @(TAInvoiceTypeVatSpecial) ,
    @"1100023141":  @(TAInvoiceTypeVatSpecial) ,
    @"1100031141":  @(TAInvoiceTypeVatSpecial) ,
    @"1100031140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100014140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100001140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100002140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100011140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100012140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100021140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100023140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100024140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100013140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100092170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100112170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100114170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100104170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100103140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100121140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100122140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100112140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100103170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100111140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100111170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100113170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100121170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100123140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100123170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100124140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100124170":  @(TAInvoiceTypeVatSpecial) ,
    @"1100123730":  @(TAInvoiceTypeVatSpecial) ,
    @"1100123760":  @(TAInvoiceTypeVatSpecial) ,
    @"1100124730":  @(TAInvoiceTypeVatSpecial) ,
    @"1100124760":  @(TAInvoiceTypeVatSpecial) ,
    @"1100104140":  @(TAInvoiceTypeVatSpecial) ,
    @"1100113140":  @(TAInvoiceTypeVatSpecial) ,
    
    @"1100062650":  @(TAInvoiceTypeVatNormal) ,
    @"1100061650":  @(TAInvoiceTypeVatNormal) ,
    @"1100054620":  @(TAInvoiceTypeVatNormal) ,
    @"1100062620":  @(TAInvoiceTypeVatNormal) ,
    @"1100061620":  @(TAInvoiceTypeVatNormal) ,
    @"1100053620":  @(TAInvoiceTypeVatNormal) ,
    @"1100092620":  @(TAInvoiceTypeVatNormal) ,
    @"1100091620":  @(TAInvoiceTypeVatNormal) ,
    @"1100121620":  @(TAInvoiceTypeVatNormal) ,
    @"1100093620":  @(TAInvoiceTypeVatNormal) ,
    @"1100094620":  @(TAInvoiceTypeVatNormal) ,
    @"1100101620":  @(TAInvoiceTypeVatNormal) ,
    @"1100111620":  @(TAInvoiceTypeVatNormal) ,
    @"1100103620":  @(TAInvoiceTypeVatNormal) ,
    @"1100104620":  @(TAInvoiceTypeVatNormal) ,
    @"1100112620":  @(TAInvoiceTypeVatNormal) ,
    @"1100113620":  @(TAInvoiceTypeVatNormal) ,
    @"1100114620":  @(TAInvoiceTypeVatNormal) ,
    @"1100102620":  @(TAInvoiceTypeVatNormal) ,
    @"1100102650":  @(TAInvoiceTypeVatNormal) ,
    @"1100092650":  @(TAInvoiceTypeVatNormal) ,
    @"1100091650":  @(TAInvoiceTypeVatNormal) ,
    @"1100103650":  @(TAInvoiceTypeVatNormal) ,
    @"1100114650":  @(TAInvoiceTypeVatNormal) ,
    @"1100111650":  @(TAInvoiceTypeVatNormal) ,
    @"1100113650":  @(TAInvoiceTypeVatNormal) ,
    @"1100122650":  @(TAInvoiceTypeVatNormal) ,
    @"1100104650":  @(TAInvoiceTypeVatNormal) ,
    @"1100112650":  @(TAInvoiceTypeVatNormal) ,
    @"1100121650":  @(TAInvoiceTypeVatNormal) ,
    @"1100122620":  @(TAInvoiceTypeVatNormal) ,
    @"1100123620":  @(TAInvoiceTypeVatNormal) ,
    @"1100123650":  @(TAInvoiceTypeVatNormal) ,
    @"1100124620":  @(TAInvoiceTypeVatNormal) ,
    @"1100124650":  @(TAInvoiceTypeVatNormal) ,
    
    @"111000922011":    @(TAInvoiceTypeVehicleSales) ,
    @"111000422011":    @(TAInvoiceTypeVehicleSales) ,
    @"G1100000121041601":@(TAInvoiceTypeVehicleSales) ,
    @"G1100000221041601":@(TAInvoiceTypeVehicleSales) ,
    @"G1100000421041601":@(TAInvoiceTypeVehicleSales) ,
    @"111000522011":    @(TAInvoiceTypeVehicleSales) ,
    @"111000622011":    @(TAInvoiceTypeVehicleSales) ,
    @"G1100000321041601":@(TAInvoiceTypeVehicleSales) ,
    @"111001122011":    @(TAInvoiceTypeVehicleSales) ,
    @"111001022011":    @(TAInvoiceTypeVehicleSales) ,
    @"111001222011":    @(TAInvoiceTypeVehicleSales) ,
    @"111000722011":    @(TAInvoiceTypeVehicleSales) ,
    @"111000822011":    @(TAInvoiceTypeVehicleSales) ,
    @"111000521921":    @(TAInvoiceTypeVehicleSales) ,
    @"G1100000321041631":@(TAInvoiceTypeVehicleSales) ,
    @"G1100000221041631":@(TAInvoiceTypeVehicleSales) ,
    @"G1100000021041631":@(TAInvoiceTypeVehicleSales) ,
    @"111000421921":    @(TAInvoiceTypeVehicleSales) ,
    };
}

- (NSArray *)specialLastFiveArray
{
    return @[@"71011",@"71012",@"71013“,@”71061“,@”71062“,@”71063”,@“73051”,@“73052”,@“73053"];
}

- (NSArray*)oldLastFiveArray{
    return @[@"75021",@"75011"];
}

-(TAInvoiceType)getInvoiceTypeWithInvoiceCode:(NSString*)invoiceCode
{
    if (!invoiceCode)
        return TAInvoiceTypeUnknown;
    
    NSDictionary *invoiceCodeLast5ToTypeMap =
    @{
        @"73001" : @(TAInvoiceTypePedlarsMarket)
    };
    
    NSNumber *typeNumber  = [[self invoiceCodeToTypeMap] objectForKey:invoiceCode ];
    if (!typeNumber)
    {
        if ([invoiceCode length] < 5)
        {
            return TAInvoiceTypeUnknown;
        }
        
        NSString *lastFive = [invoiceCode substringFromIndex:[invoiceCode length]-5];
        
        typeNumber = [invoiceCodeLast5ToTypeMap objectForKey:lastFive];
        
        if (!typeNumber)
        {
            if ([[self specialLastFiveArray] containsObject:lastFive])
            {
                return TAInvoiceTypeSpecial;
            }
            
            if ([[self oldLastFiveArray] containsObject:lastFive])
            {
                return TAInvoiceTypeOld;
            }
            
            return TAInvoiceTypePrint;
        }
    }
    
    return [typeNumber intValue];
}

#pragma mark - Invoice Info Item Validation
- (NSDictionary*)invoiceInfoItemDefineTable
{
    return @{
    
    @(TAInvoiceInfoItemInvoiceCode) :
    @{
    @"Name" :   @"发票代码" ,
    @"Type" : @"Number" ,
    @"MaxLength" : @(25)
    },
    @(TAInvoiceInfoItemInvoiceNumber) :
    @{
    @"Name" : @"发票号码",
    @"Type" : @"Number" ,
    @"MaxLength" : @(8)
    },
    @(TAInvoiceInfoItemTaxPayerIdentification) :
    @{
    @"Name" : @"纳税人识别号" ,
    @"Type" : @"AlphaOrNumber" ,
    @"MinLength" : @(15),
    @"MaxLength" : @(20)
    },
    @(TAInvoiceInfoItemTaxPassword) :
    @{
    @"Name" : @"密码" ,
    @"Type" : @"Number" ,
    @"MaxLength" : @(8),
    @"MinLength" : @(8)
    },
    @(TAInvoiceInfoItemSerialNo) :
    @{
    @"Name" : @"机器编号" ,
    @"Type" : @"Number" ,
    @"MaxLength" : @(11),
    @"MinLenght" : @(11),
    },
    @(TAInvoiceInfoItemIssueDate) :
    @{
    @"Name" : @"开票日期" ,
    @"Type" : @"Date"  ,
    @"Format" : @"YYYY-MM-DD"
    },
    @(TAInvoiceInfoItemTaxControlCode) :
    @{
    @"Name" : @"税控码" ,
    @"Type" : @"Number" ,
    @"Enum" : @[ @(20) , @(22) ],
    },
    @(TAInvoiceInfoItemAmount):
    @{
    @"Name" : @"开票金额" ,
    @"Type" : @"Amount" ,
    @"MinValue" : @(0.0)
    },
    @(TAInvoiceInfoItemTypeCaptcha):
    @{
    @"Name" : @"验证码",
    @"Type" : @"AlphaOrNumber"
    }
    };
}

- (NSString*)modifySerialNo:(NSString*)orgSerialNo
{
    if (!orgSerialNo)
        return orgSerialNo;
    
    NSString *firstFour = [orgSerialNo substringWithRange:NSMakeRange(0, 4)];
    
    if ([firstFour isEqualToString:@"2101"] ||
        [firstFour isEqualToString:@"2102"] ||
        [firstFour isEqualToString:@"2103"])
    {
        return [NSString stringWithFormat:@"0%@",orgSerialNo];
    }
    
    return orgSerialNo;
}

- (BOOL)checkInvoiceInfoItemValidation:(TAInvoiceInfoItemType)invoiceInfoItemType
                                 value:(NSString*)invoiceInfoItemValue
                           invoiceType:(TAInvoiceType)invoiceType
                               failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *defineTable = [self invoiceInfoItemDefineTable];
    
    NSDictionary *itemDefine = [defineTable objectForKey:@(invoiceInfoItemType)];
    
    if (!itemDefine)
        return YES;
    
    if (invoiceInfoItemType == TAInvoiceInfoItemInvoiceCode &&
            (!invoiceInfoItemValue || [invoiceInfoItemValue isEqualToString:@""]))
    {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setValue:@"发票代码不能为空"forKey:NSLocalizedDescriptionKey];
        NSError *error = [[NSError alloc] initWithDomain:TAInvoiceErrorDomain code:TAInvoiceInfoItemBadFormat userInfo:userInfo];
        if (failure) {
            failure( error );
        }
        return NO;

    }
    
    if (invoiceType == TAInvoiceTypeUnknown) {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setValue:@"无法识别发票类型"forKey:NSLocalizedDescriptionKey];
        NSError *error = [[NSError alloc] initWithDomain:TAInvoiceErrorDomain code:TAInvoiceInfoItemBadFormat userInfo:userInfo];
        if (failure) {
            failure( error );
        }
        return NO;
    }
    
    if ([self isInvoiceInfoItemRequired:invoiceInfoItemType invoiceType:invoiceType])
    {
        if (!invoiceInfoItemValue || [invoiceInfoItemValue isEqualToString:@""] )
        {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            [userInfo setValue:[ NSString stringWithFormat:@"%@不能为空" ,
                                itemDefine[@"Name"]] forKey:NSLocalizedDescriptionKey];
            NSError *error = [[NSError alloc] initWithDomain:TAInvoiceErrorDomain code:TAInvoiceInfoItemBadFormat userInfo:userInfo];
            if (failure) {
                failure( error );
            }
            return NO;

        }
    }
    
    NSNumber *maxLength = [itemDefine objectForKey:@"MaxLength"];
    NSNumber *minLength = [itemDefine objectForKey:@"MinLength"];
    
    if (maxLength && [maxLength intValue] < [invoiceInfoItemValue length])
    {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setValue:[ NSString stringWithFormat:@"%@的长度超过%@" ,
                            itemDefine[@"Name"] , maxLength ] forKey:NSLocalizedDescriptionKey];
        NSError *error = [[NSError alloc] initWithDomain:TAInvoiceErrorDomain code:TAInvoiceInfoItemBadFormat userInfo:userInfo];
        if (failure) {
            failure( error );
        }

        return NO;
    }
    
//    if (minLength && [minLength intValue] > [invoiceInfoItemValue length])
//    {
//        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//        [userInfo setValue:[ NSString stringWithFormat:@"%@的长度小于%@" ,
//                            itemDefine[@"Name"] , minLength ] forKey:NSLocalizedDescriptionKey];
//        NSError *error = [[NSError alloc] initWithDomain:TAInvoiceErrorDomain code:TAInvoiceInfoItemBadFormat userInfo:userInfo];
//        if (failure) {
//            failure( error );
//        }
//
//        return NO;
//    }
    
    if ([itemDefine[@"Type"] isEqualToString:@"Number"])
    {
        NSString * regex = @"(^[0-9]*$)";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:invoiceInfoItemValue];
        if (!isMatch) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            [userInfo setValue:[ NSString stringWithFormat:@"%@必须是数字" ,
                                itemDefine[@"Name"]  ] forKey:NSLocalizedDescriptionKey];
            NSError *error = [[NSError alloc] initWithDomain:TAInvoiceErrorDomain code:TAInvoiceInfoItemBadFormat userInfo:userInfo];
            if (failure) {
                failure( error );
            }
        }
    }
    
    if ([itemDefine[@"Type"] isEqualToString:@"AlphaOrNumber"])
    {
        NSString * regex = @"(^[0-9A-Za-z]*$)";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:invoiceInfoItemValue];
        if (!isMatch) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            [userInfo setValue:[ NSString stringWithFormat:@"%@必须是数字或字母" ,
                                itemDefine[@"Name"]  ] forKey:NSLocalizedDescriptionKey];
            NSError *error = [[NSError alloc] initWithDomain:TAInvoiceErrorDomain code:TAInvoiceInfoItemBadFormat userInfo:userInfo];
            if (failure) {
                failure( error );
            }
            return NO;
        }
        return YES;
    }
    
    if ([itemDefine[@"Type"] isEqualToString:@"Date"])
    {
        NSString * regex = @"(^[0-9A-Za-z]*$)";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:invoiceInfoItemValue];
        if (!isMatch) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            [userInfo setValue:[ NSString stringWithFormat:@"%@必须是数字或字母" ,
                                itemDefine[@"Name"]  ] forKey:NSLocalizedDescriptionKey];
            NSError *error = [[NSError alloc] initWithDomain:TAInvoiceErrorDomain code:TAInvoiceInfoItemBadFormat userInfo:userInfo];
            if (failure) {
                failure( error );
            }
            return NO;
        }
        return YES;
        
    }
    
    if ([itemDefine[@"Type"] isEqualToString:@"Amount"])
    {
        NSString * regex = @"(^[0-9]{0,8}（.[0－9]{2})?$)";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:invoiceInfoItemValue];
        if (!isMatch) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            [userInfo setValue:[ NSString stringWithFormat:@"%@格式错误" ,
                                itemDefine[@"Name"]  ] forKey:NSLocalizedDescriptionKey];
            NSError *error = [[NSError alloc] initWithDomain:TAInvoiceErrorDomain code:TAInvoiceInfoItemBadFormat userInfo:userInfo];
            if (failure) {
                failure( error );
            }
            return NO;
        }
        return YES;
        
    }
    
    return YES;
}

#pragma mark - Invoice Info Item Required


- (NSArray *)specialLastFiveToInfoItems
{
    return @[@(TAInvoiceInfoItemSerialNo),@(TAInvoiceInfoItemIssueDate),@(TAInvoiceInfoItemAmount),@(TAInvoiceInfoItemTaxControlCode),@(TAInvoiceInfoItemTypeCaptcha)
    ];
}



- (NSArray *)checkOldLastFiveToInfoItems
{
    return @[@(TAInvoiceInfoItemIssueDate)];
}

- (NSDictionary *)invoiceTypeRequiredItems
{
    return
    @{
    @(TAInvoiceTypeVatSpecial) : @[
    @(TAInvoiceInfoItemInvoiceCode),
    @(TAInvoiceInfoItemTaxPayerIdentification),
    @(TAInvoiceInfoItemTypeCaptcha)
    ],
    
    @(TAInvoiceTypeVatNormal) : @[
    @(TAInvoiceInfoItemInvoiceCode),
    @(TAInvoiceInfoItemTaxPayerIdentification),
    @(TAInvoiceInfoItemTypeCaptcha)
    ],
    
    @(TAInvoiceTypeVehicleSales) : @[
    @(TAInvoiceInfoItemInvoiceCode),
    @(TAInvoiceInfoItemTaxPayerIdentification),
    @(TAInvoiceInfoItemTypeCaptcha)
    ],
    
    @(TAInvoiceTypePrint) : @[
    @(TAInvoiceInfoItemInvoiceCode),
    @(TAInvoiceInfoItemTaxPayerIdentification),
    @(TAInvoiceInfoItemTaxPassword),
    @(TAInvoiceInfoItemTypeCaptcha)
    ],
    
    @(TAInvoiceTypePedlarsMarket) : @[
    @(TAInvoiceInfoItemInvoiceCode),
    @(TAInvoiceInfoItemTaxPayerIdentification),
    @(TAInvoiceInfoItemTaxPassword),
    @(TAInvoiceInfoItemTypeCaptcha)
    ]
    };
}

- (BOOL)isInvoiceInfoItemRequired:(TAInvoiceInfoItemType)invoiceInfoItemType invoiceType:(TAInvoiceType)invoiceType
{
    NSArray *requiredItems = [[self invoiceTypeRequiredItems] objectForKey:@(invoiceType)];
    
    if (!requiredItems)
    {
        return NO;
    }
    
    if (invoiceType == TAInvoiceTypeSpecial)
    {
        if ([[self specialLastFiveToInfoItems] containsObject:@(invoiceInfoItemType)])
        {
            return YES;
        }
        return NO;
    }
    
    if (invoiceType == TAInvoiceTypeOld) {
        if ([[self oldLastFiveArray] containsObject:@(invoiceInfoItemType)])
        {
            return YES;
        }
        return NO;
    }
    
    if ([requiredItems containsObject:@(invoiceInfoItemType)])
        return YES;
    
    return NO;
    
}


@end
