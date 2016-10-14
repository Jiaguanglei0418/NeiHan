//
//  GLDefine.h
//  NeiHan
//
//  Created by Guangleijia on 16/10/12.
//  Copyright © 2016年 Guangleijia. All rights reserved.
//

#ifndef GLDefine_h
#define GLDefine_h


#define WS(weakself) __weak __typeof(&*self)weakSelf = self;

#pragma mark - Screen
#define kSCREEN_RECT [UIScreen mainScreen].bounds
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kLeftMargin 15



#pragma mark - Color
#define kCOLOR_RGB(r,g,b) [UIColor colorWithRed:r green:g blue:b alpha:1.00f]
#define kCOLOR_BARTINT kCOLOR_RGB(0.97,0.97,0.97)

#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kGrayColor [UIColor grayColor]
#define kRedColor [UIColor redColor]
#define kGreenColor [UIColor greenColor]
#define kBlueColor [UIColor blueColor]
#define kCyanColor [UIColor cyanColor]
#define kYellowColor [UIColor yellowColor]
#define kMagentaColor [UIColor magentaColor]
#define kOrangeColor [UIColor orangeColor]
#define kPurpleColor [UIColor purpleColor]
#define kBrownColor [UIColor brownColor]
#define kClearColor [UIColor clearColor]
#define kCommonGrayTextColor [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:1.00f]
#define kCommonRedColor [UIColor colorWithRed:0.91f green:0.33f blue:0.33f alpha:1.00f]
#define kBgColor kRGBColor(243,245,247)
#define kLineBgColor [UIColor colorWithRed:0.86f green:0.88f blue:0.89f alpha:1.00f]
#define kTextColor [UIColor colorWithRed:0.32f green:0.36f blue:0.40f alpha:1.00f]
#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kRGBColor(r,g,b) kRGBAColor(r,g,b,1.0f)
#define kCommonBlackColor [UIColor colorWithRed:0.17f green:0.23f blue:0.28f alpha:1.00f]
#define kSeperatorColor kRGBColor(234,237,240)
#define kDetailTextColor [UIColor colorWithRed:0.56f green:0.60f blue:0.62f alpha:1.00f]
#define kCommonTintColor [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f]
#define kCommonBgColor [UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f]
#define kCommonHighLightRedColor [UIColor colorWithRed:1.00f green:0.49f blue:0.65f alpha:1.00f]



#pragma mark - Font
#define kFONT(float) [UIFont systemFontOfSize:float]


#pragma mark - Property
#define kPROPERTY_COPY(name)            @property (nonatomic, copy) NSString *name;
#define kPROPERTY_WEAK(Class, name)     @property (nonatomic, weak) Class *name;
#define kPROPERTY_STRONG(Class, name)   @property (nonatomic, strong) Class *name;
#define kPROPERTY_ASSIGN(Class, name)   @property (nonatomic, assign) Class name;
#define kPROPERTY_BLOCK(Class, name)    @property (nonatomic, copy) Class name;
#define kPROPERTY_DELEGATE(Class, name)    @property (nonatomic, assign) id<Class> name;



#pragma mark - 字符串转化
#define kEmptyStr @""
#define kIntToStr(i) [NSString stringWithFormat: @"%d", i]
#define kIntegerToStr(i) [NSString stringWithFormat: @"%ld", i]
#define kValidStr(str) [NHUtils validString:str]




#ifdef DEBUG

#define kLOG(...) printf(" %s\n",[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#define kLOG_CURRENT_METHOD NSLog(@"%@-%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))

#else

#define kLOG(...) ;
#define kLOG_CURRENT_METHOD ;

#endif

#endif /* GLDefine_h */
