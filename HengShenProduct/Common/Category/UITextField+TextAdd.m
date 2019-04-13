//
//  UITextField+TextAdd.m
//  KaiXinQianDai
//
//  Created by xiaoning on 2018/11/28.
//  Copyright © 2018年 xiaoning. All rights reserved.
//

#import "UITextField+TextAdd.h"
#import <objc/runtime.h>


#pragma mark - static char *const property

static char *const KTextFieldTextMaxLength = "TextFieldTextMaxLength";
static char *const KTextFieldPlaceholderFont = "TextFieldPlaceholderFont";
static char *const KTextFieldPlaceholderColor = "TextFieldPlaceholderColor";

#pragma mark - static char *const method
static char *const KTextFieldTextDidChangeMethod = "TextFieldTextDidChangeMethod";


@implementation UITextField (TextAdd)

#pragma mark - Swizzling

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(setPlaceholder:);
        SEL swizzledSelector = @selector(swizzling_setPlaceholder:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
        originalSelector = @selector(placeholder);
        swizzledSelector = @selector(swizzling_placeholder);
        
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
        originalSelector = @selector(initWithFrame:);
        swizzledSelector = @selector(swizzling_initWithFrame:);
        
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
        protocol_addMethodDescription(objc_getProtocol([@"UITextField" UTF8String]), @selector(textFieldDidChange:), KTextFieldTextDidChangeMethod, NO, YES);
#pragma clang diagnostic pop
        
    });
}

- (NSString *)swizzling_placeholder
{
    return self.attributedPlaceholder.string;
}

- (void)swizzling_setPlaceholder:(NSString *)placeholder
{
    if (!placeholder) {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:placeholder];
    if (self.placeholderColor) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:self.placeholderColor range:NSMakeRange(0, placeholder.length)];
    }
    if (self.placeholderFont) {
        [attributedString addAttribute:NSFontAttributeName value:self.placeholderFont range:NSMakeRange(0, placeholder.length)];
    }
    self.attributedPlaceholder = attributedString;
}

- (instancetype)swizzling_initWithFrame:(CGRect)frame
{
    [self swizzling_initWithFrame:frame];
    [self addTarget:self action:@selector(textField_textDidChanged) forControlEvents:UIControlEventEditingChanged];
    return self;
}

#pragma mark - @property setter getter
- (NSUInteger)maxLength
{
    NSNumber *maxLengthNum = objc_getAssociatedObject(self, KTextFieldTextMaxLength);
    if (!maxLengthNum) {
        return NSUIntegerMax;
    }
    return [maxLengthNum unsignedIntegerValue];
}

- (void)setMaxLength:(NSUInteger)maxLength
{
    objc_setAssociatedObject(self, KTextFieldTextMaxLength, @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)placeholderFont
{
    return objc_getAssociatedObject(self, KTextFieldPlaceholderFont);
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    objc_setAssociatedObject(self, KTextFieldPlaceholderFont, placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setPlaceholder:self.placeholder];
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, KTextFieldPlaceholderColor);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    objc_setAssociatedObject(self, KTextFieldPlaceholderColor, placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setPlaceholder:self.placeholder];
}

#pragma mark - Private method

- (void)textField_textDidChanged
{
    UITextField *textField = self;
    
    NSString *languageStr = [textField.textInputMode primaryLanguage];
    if ([languageStr isEqualToString:@"zh-Hans"])
    {
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position){
            if (textField.text.length > self.maxLength) {
                textField.text = [textField.text substringToIndex:self.maxLength];
            }
        }
    }
    else
    {
        if (textField.text.length > self.maxLength)
        {
            textField.text = [textField.text substringToIndex:self.maxLength];
        }
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidChange:)]) {
        [self.delegate performSelector:@selector(textFieldDidChange:) withObject:self];
    }
#pragma clang diagnostic pop
    
}

- (NSString *)getSpecialSymbolsWithStr:(NSString *)string {
    NSString *str = [self specialSymbolsAction];
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:str]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return filtered;
}

//只能输入数字、字母、汉字(即限制输入特殊字符，用这种方法虽然比较笨，但还是有优点的，当不需要限制某些特殊字符时直接去掉就OK了)
- (NSString *)specialSymbolsAction{
    //数学符号
    NSString *matSym = @"﹢﹣×÷±/=≌∽≦≧≒﹤﹥≈≡≠=≤≥<>≮≯∷∶∫∮∝∞∧∨∑∏∪∩∈∵∴⊥∥∠⌒⊙√∟⊿㏒㏑%‰⅟½⅓⅕⅙⅛⅔⅖⅚⅜¾⅗⅝⅞⅘≂≃≄≅≆≇≈≉≊≋≌≍≎≏≐≑≒≓≔≕≖≗≘≙≚≛≜≝≞≟≠≡≢≣≤≥≦≧≨≩⊰⊱⋛⋚∫∬∭∮∯∰∱∲∳%℅‰‱øØπ";
    
    //标点符号
    NSString *punSym = @"。，、＇：∶；?‘’“”〝〞ˆˇ﹕︰﹔﹖﹑·¨….¸;！´？！～—ˉ｜‖＂〃｀@﹫¡¿﹏﹋﹌︴々﹟#﹩$﹠&﹪%*﹡﹢﹦﹤‐￣¯―﹨ˆ˜﹍﹎+=<＿_-ˇ~﹉﹊（）〈〉‹›﹛﹜『』〖〗［］《》〔〕{}「」【】︵︷︿︹︽_﹁﹃︻︶︸﹀︺︾ˉ﹂﹄︼❝❞!():,'[]｛｝^・.·．•＃＾＊＋＝＼＜＞＆§⋯`－–／—|\"\\";
    
    //单位符号＊·
    NSString *unitSym = @"°′″＄￥〒￠￡％＠℃℉﹩﹪‰﹫㎡㏕㎜㎝㎞㏎m³㎎㎏㏄º○¤%$º¹²³";
    
    //货币符号
    NSString *curSym = @"₽€£Ұ₴$₰¢₤¥₳₲₪₵元₣₱฿¤₡₮₭₩ރ円₢₥₫₦zł﷼₠₧₯₨Kčर₹ƒ₸￠";
    
    //制表符
    NSString *tabSym = @"─ ━│┃╌╍╎╏┄ ┅┆┇┈ ┉┊┋┌┍┎┏┐┑┒┓└ ┕┖┗ ┘┙┚┛├┝┞┟┠┡┢┣ ┤┥┦┧┨┩┪┫┬ ┭ ┮ ┯ ┰ ┱ ┲ ┳ ┴ ┵ ┶ ┷ ┸ ┹ ┺ ┻┼ ┽ ┾ ┿ ╀ ╁ ╂ ╃ ╄ ╅ ╆ ╇ ╈ ╉ ╊ ╋ ╪ ╫ ╬═║╒╓╔ ╕╖╗╘╙╚ ╛╜╝╞╟╠ ╡╢╣╤ ╥ ╦ ╧ ╨ ╩ ╳╔ ╗╝╚ ╬ ═ ╓ ╩ ┠ ┨┯ ┷┏ ┓┗ ┛┳ ⊥ ﹃ ﹄┌ ╮ ╭ ╯╰";
    
    return [NSString stringWithFormat:@"%@%@%@%@%@",matSym,punSym,unitSym,curSym,tabSym];
}


@end
