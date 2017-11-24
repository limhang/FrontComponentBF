//使用runtime的原因：
//需要添加对self的textFieldChanged的事件
//方案一：在某些属性set方法中写，【失败】，如下
//- (void)setText:(NSString *)text {
//    [self setText:text]; //在分类中，无法获取_text成员变量，[self setText:text]死循环
//    [self addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
//    NSLog(@"word has change %@",text);
//}
//方案二：自己弄一个方法，在初始化UITextField中调用，【可行】，不够优雅
//- (void)addTextChangeEvent {
//    [self addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
//}
//方案三：由于UITextField一定会自己调用text属性的set方法，所以我们基于方案一做一个优化，使用runtime，添加一个buffText属性(或者说置换下text的set方法)，方案如代码


#import "UITextField+ButterFly.h"
#import <objc/runtime.h>
@implementation UITextField (ButterFly)

//这个方法是在主main方法前被调用，一般就是写运行时逻辑的
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        //获取方法的编号
        SEL originalSelector = @selector(setText:);
        SEL swizzledSelector = @selector(setBuffText:);
        
        //获取方法指针
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        //给类添加一个方法，如果添加成功，则返回yes，第一个参数是类名，第二个参数是方法的选择器(也可以说是方法的编号)，第三个参数是方法的实现，第四个是实现的类型
        BOOL didAddMethod = class_addMethod(class, originalSelector,method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        //如果刚刚的添加成功，则说明original和swizzed都没被系统占用，那么我们就需要给swizzled选择器，添加original的方法
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            //如果第一步添加swizzled方法失败，说明，我们想用的original名字，系统已经用上了，所以我们只能做方法替换了
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - setters and getters
//生成BLMaxLenght的set方法
//【这个就是在分类中，使用数值类型的方式，转成NSNumber类型】,赋值的时候，对其【@(BLMaxlength)】处理
- (void)setBLMaxlength:(NSInteger)BLMaxlength {
    objc_setAssociatedObject(self, @selector(setBLMaxlength:), @(BLMaxlength), OBJC_ASSOCIATION_ASSIGN);
}

//BLMaxLength的get方法
- (NSInteger)BLMaxlength {
    return ((NSNumber *)objc_getAssociatedObject(self, @selector(setBLMaxlength:))).integerValue;
}

//emoji的set方法
- (void)setBLemojiEnable:(BOOL)BLemojiEnable {
    objc_setAssociatedObject(self, @selector(setBLemojiEnable:), @(BLemojiEnable), OBJC_ASSOCIATION_ASSIGN);
}

//emoji的get方法
- (BOOL)BLemojiEnable {
    return ((NSNumber *)objc_getAssociatedObject(self, @selector(setBLemojiEnable:))).boolValue;
}

//lastText的set方法 -- 最近一次text值
- (void)setLastText:(NSString *)lastText {
    objc_setAssociatedObject(self, @selector(setLastText:), lastText, OBJC_ASSOCIATION_COPY);
}

//lastText的get方法
- (NSString *)lastText {
    return objc_getAssociatedObject(self, @selector(setLastText:));
}

//生成firstLoad属性的set方法，【这里使用NSString主要，练习下对象的set和get生成】
- (void)setFirstLoad:(NSString *)firstLoad {
    objc_setAssociatedObject(self, @selector(setFirstLoad:), firstLoad, OBJC_ASSOCIATION_COPY);
}
//生成firstLoad属性的get方法
- (NSString *)firstLoad {
    return objc_getAssociatedObject(self, @selector(setFirstLoad:));
}

//这个set方法迷惑比较大，我开始看也懵逼一会，这里不会导致死循环嘛，其实这个是runtime方法替换
//直接调用setBuffText，肯定是UITextField调用[self setText]，然后setText和setBuffText方法替换了
- (void)setBuffText:(NSString *)text {
    //这个方法是UITextField调用[self setBuffText]，然后setBuffText和setText方法替换了，【一定要调用setBuffText，不然导致数值无法被赋到UITextField上】
    [self setBuffText:text];
    
    //这里开始写我们一直需要的，textFieldChanged方法
    if (self.firstLoad.length > 0) {
        NSLog(@"1111111");
    } else {
        //这里的代码只执行一次，重赋值firstLoad字符串后，就不会走这里的逻辑了
        [self addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
        self.firstLoad = @"赋值数据，改变自己非零值";
        NSLog(@"2222222");
    }
}


#pragma mark - private methods
//在我们使用上述runtime后，我们可以实时监控text的变化了，开始我们的表演【去掉emoji，控制字符长度】
-(void)textFieldChanged{
    if (self.text.length != 0){
        [self setNeedsDisplay]; //除了runtime我自己写的，这些是copy其他源码的
    }
    
    NSString *lang = [[[UIApplication sharedApplication] textInputMode] primaryLanguage];// 键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (position) {
            return;
        }
    }
    
    if (!self.BLemojiEnable) {
        [self setDeleteEmojiText];
    }
    NSString *getStr = [self getSubString:self.text];
    if(getStr && getStr.length > 0) {
        self.text= getStr;
    }
    
    //保存最近的text值，防止emoji输入时候，光标偏移  【注意自己我用的是text属性的get方法，所以不用担心方法互换】
    self.lastText = self.text;
}

-(void)setDeleteEmojiText{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    NSRange range;
    if([[self removeEmojiString:self.text] length]<self.text.length){
        //这里处理的好，才能解决输入emoji时候，光标偏移的问题
        range = NSMakeRange(location-(self.text.length-self.lastText.length), length);
    }else{
        range = NSMakeRange(location, length);
    }
    [self setText:[self removeEmojiString:self.text]];
    beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

-(NSString *)getSubString:(NSString*)string
{
    if (self.BLMaxlength <= 0) {
        return nil;
    }
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data = [string dataUsingEncoding:encoding];
    NSInteger length = [data length];
    if (length > self.BLMaxlength) {
        NSData *data1 = [data subdataWithRange:NSMakeRange(0, self.BLMaxlength)];
        NSString *content = [[NSString alloc] initWithData:data1 encoding:encoding];//【注意4】：当截取kMaxLength长度字符时把中文字符截断返回的content会是nil
        if (!content || content.length == 0) {
            data1 = [data subdataWithRange:NSMakeRange(0, self.BLMaxlength - 1)];
            content =  [[NSString alloc] initWithData:data1 encoding:encoding];
        }
        return content;
    }
    return nil;
}

//////////////////////////////////====这两个方法是NSSring分类方法，为了组件低依赖，我复制了过来====//////////////////////////////////
//移除string中的emoji部分
- (NSString *)removeEmojiString:(NSString *)string{
    __block NSMutableString *str = [NSMutableString string];
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if (![self isContainsEmoji:substring]) {
            [str appendString:substring];
        }
    }];
    return [str copy];
}

//检查时候包含emoji
- (BOOL)isContainsEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}

@end
