#### 核心原则
##### 一. 代码应该简洁易懂，逻辑清晰
* 软件是需要人来维护的。这个人在未来很可能不是你。所以首先是为人编写程序，其次才是计算机;
* 不要过分追求技巧，降低程序的可读性;
* 简洁的代码可以让bug无处藏身;要写出明显没有bug的代码，而不是没有明显bug的代码。
##### 二.  面向变化编程，而不是面向需求编程
* 需求是暂时的，只有变化才是永恒的;
* 本次迭代不能仅仅为了当前的需求，写出扩展性强，易修改的程序才是负责任的做法，对自己负责，对公司负责.
##### 三. 先保证程序的正确性，防止过度工程
* 过度工程:在正确可用的代码写出之前就过度地考虑扩展，重用的问题，使得工程过度复杂;

#### 通用规范
##### 一. 关于大括号
#####1.  控制语句(if,for,while,switch)中，大括号开始与行尾
```ObjC
应该:
if (someCondition) {
//do something
}else{
//do something
}

不应该:
if (someCondition)
//do something
}
else{
//do something
}
```
##### 二.运算符
##### 1. 运算符与变量之间的间隔;
1.1 一元运算符与变量之间没有空格;
```ObjC
!bValue
~iValue
++iCount
*strSource
&fSum
```
1.2 二元运算符与变量之间必须有空格;
```ObjC
fWidth = 5 + 5;
fLength = fWidth * 2;
fHeight = fWidth + fLength;
for(int i = 0; i < 10; i++)
```
##### 2. 多个不同的运算符同时存在时应该使用括号来明确优先级;
例如:
```ObjC
//应该
2 << (2 + 1 * 3 - 4)
//不应该
2 << 2 + 1 * 3 - 4
'<<'是移位操作,它的优先级是比加减法还要低的;
```

##### 三.变量

##### 1. 一个变量有且只有一个功能，尽量不要把一个变量用作多种用途;
##### 2. 变量在使用前应初始化，防止未初始化的变量被引用;
```ObjC
应该
int a = 0;
int b = 0;
...
...
return a + b;

不应该
int a;
int b;
...
...
return a + b;
```
##### 3. 局部变量应该尽量接近使用它的地方;
```ObjC
应该:
- (void)someFunction{
let index = ...;
//Do something With index
...
...
let count = ...;
//Do something With count
}
不应该:
- (void)someFunction{
let index = ...;
let count = ...;
//Do something With index
...
...
//Do something With count
}
```
##### 四.if语句
##### 1. 必须列出所有分支（穷举所有的情况），而且每个分支都必须给出明确的结果;
```ObjC
应该:
NSString *str = @"";
if (count < 3) {
str = @"Good";
} else {
str = @"Bad";
}
不应该:
NSString *str;
if (count < 3) {
str = @"Good";
}
```

##### 2. 不要使用过多的分支，要善于使用return来提前返回错误的情况;
```ObjC
应该:
- (void)someMethod {
if (!goodCondition) {
return;
}
//Do something
...
}
不应该:
- (void)someMethod {
if (goodCondition) {
//Do something
...
}
}
```
##### 3. 条件表达式如果很长，则需要将他们提取出来赋给一个BOOL值;
```ObjC
应该:
BOOL nameContainsOC = sessionName.hasPrefix("Objective-C")
BOOL isCurrentYear = sessionDateCompontents.year == 2014
BOOL isOCSession = nameContains && isCurrentYear
if (isOCSession) {
// Do something
...
}
不应该:
if ( sessionName.hasPrefix("Objective-C") && (sessionDateCompontents.year == 2014) ) {
// Do something
...
}
```
##### 4. 条件语句的判断应该是变量在左，常量在右;
```ObjC
应该:
if ( count == 6) {
//do something
}
if ( object == nil) {
//do something
}
不应该:
if ( 6 == count) {
//do something
}
if ( nil == object ) {
//do something
}
```

##### 5. 每个分支的实现代码都必须被大括号包围;
```ObjC
应该:
if (!error) {
return success;
}
不应该:
if (!error)
return success;
或
if (!error) return success;
```

##### 6. 条件过多，过长的时候应该换行
```ObjC
应该:
if (condition1 &&
condition2 &&
condition3 &&
condition4) {
// Do something
}
不应该:
if (condition1 && condition2 && condition3 && condition4) {
// Do something
}
```
### 五.for语句
##### 1. 不可在for循环内修改循环变量，防止for循环失去控制;
```ObjC
不应该:
for (int index = 0; index < 10; index++){
...
logicToChange(index)
}
```
##### 2. 避免使用continue和break;
2.1 如果出现了continue，只需要把continue的条件取反即可
```ObjC
NSMutableArray <NSString *> *filteredProducts = [NSMutableArray array];
应该:
for (NSString *level in filteredProducts){
if (![level hasPrefix:@"bad"]) {
[filteredProducts addObject:level];
}
}

不应该:
for (NSString *level in filteredProducts){
if ([level hasPrefix:@"bad"]) {
continue;
}
[filteredProducts addObject:level];
}
```
2.2 消除while里的break：将break的条件取反，并合并到主循环里
```ObjC
应该:
while (condition1 && !condition2) {
......
}
不应该:
while (condition1) {
...
if (condition2) {
break;
}
}
```
2.3 在有返回值的方法里消除break：将break转换为return立即返回
```ObjC
应该:
- (BOOL)hasBadProductIn:(NSArray <NSString *>*products){
for (NSString *level in products){
if [level hasPrefix:@"bad"]{
return YES;
}
}
return NO;
}
不应该:
- (BOOL)hasBadProductIn:(NSArray <NSString *>*products){
BOOL result = NO;
for (NSString *level in products){
if [level hasPrefix:@"bad"]{
resutl = YES;
}
}
return result;
}
```
##### 六.Switch语句
##### 1. 每个分支都必须用大括号括起来;
```ObjC
switch (integer) {
case 1: {
// ...
}
break;
case 2: {
// ...
break;
}
case 3: {
// ...
break;
}
default:{
// ...
break;
}
}
```

##### 2. 使用枚举类型时，不能有default分支， 除了使用枚举类型以外，都必须有default分支;
```ObjC
VETLeftMenuTopItemType menuType = VETLeftMenuTopItemMain;
switch (menuType) {
case VETLeftMenuTopItemMain: {
// ...
break;
}
case VETLeftMenuTopItemShows: {
// ...
break;
}
case VETLeftMenuTopItemSchedule: {
// ...
break;
}
}
```
**在Switch语句使用枚举类型的时候，如果使用了default分支，在将来就无法通过编译器来检查新增的枚举类型了。**
##### 七.函数
##### 1. 一个函数的长度必须限制在50行以内;
> 通常来说，在阅读一个函数的时候，如果视需要跨过很长的垂直距离会非常影响代码的阅读体验。如果需要来回滚动眼球或代码才能看全一个方法，就会很影响思维的连贯性，对阅读代码的速度造成比较大的影响。最好的情况是在不滚动眼球或代码的情况下一眼就能将该方法的全部代码映入眼帘。
##### 2. 一个函数只做一件事（单一原则）每个函数的职责都应该划分的很明确（就像类一样);
```ObjC
应该:
- (void)dataConfiguration{
//do something
}
- (void)viewConfiguration{
//do something
}

不应该:
- (void)dataConfiguration{
...
[self viewConfiguration];
}
```

##### 3. 对于有返回值的函数（方法），每一个分支都必须有返回值;
```Objc
应该:
- (void)function{
if(condition1){
return count1;
}else if(condition2){
return count2;
}else{
return defaultCount;
}
}
不应该:
- (void)function{
if(condition1){
return count1;
}else if(condition2){
return count2;
}
}
```
##### 4. 对输入参数的正确性和有效性进行检查，参数错误立即返回;
```ObjC
- (void)function:(id)param1 param:(id)param2{
if(param1 is unavailable){
return;
}
if(param2 is unavailable){
return;
}
//Do some right thing
}
```
##### 5. 如果在不同的函数内部有相同的功能，应该把相同的功能抽取出来单独作为另一个函数;
```ObjC
应该:
- (void)basicConfig{
[self func1];
[self func2];
}

- (void)logic1{
[self basicConfig];
[self func3];
}
- (void)logic2{
[self basicConfig];
[self func4];
}

不应该:
- (void)logic{
[self func1];
[self func2]；
if (logic1 condition) {
[self func3];
} else {
[self func4];
}
}
```
##### 6. 将函数内部比较复杂的逻辑提取出来作为单独的函数;
> 一个函数内的不清晰（逻辑判断比较多，行数较多）的那片代码，往往可以被提取出去，构成一个新的函数，然后在原来的地方调用它这样你就可以使用有意义的函数名来代替注释，增加程序的可读性。
```ObjC
举一个发送邮件的例子：

应该:
- (void)writeEmail:(NSString *)title
content:(NSString *)content
receiver:(NSString *)receiver
attachment:(NSString *)attachment{
[self writeTitle:title];
[self writeContent:content];
[self writeReceiver:receiver];
[self addAttachment:attachment];
}

[self openEmailSite];
[self login];
[self writeEmail:title
content:content
receiver:receiver
attachment:attachment];
[self send];

不应该:

[self openEmailSite];
[self login];
[self writeTitle:title];
[self writeContent:content];
[self writeReceiver:receiver];
[self addAttachment:attachment];
[self send];
```
##### 八.注释
> 优秀的代码大部分是可以自描述的，我们完全可以用程代码本身来表达它到底在干什么，而不需要注释的辅助; 但并不是说一定不能写注释，有以下三种情况比较适合写注释：

* 公共接口（注释要告诉阅读代码的人，当前类能实现什么功能）。
* 涉及到比较深层专业知识的代码（注释要体现出实现原理和思想）。
* 容易产生歧义的代码（但是严格来说，容易让人产生歧义的代码是不允许存在的）。
** 除了上述这三种情况，如果别人只能依靠注释才能读懂你的代码的时候，就要反思代码出现了什么问题。**

#### iOS规范
##### 一. 变量
##### 1. 变量名必须使用驼峰格式;
1.1 类，协议使用大驼峰：
```ObjC
HomePageViewController.h
<HeaderViewDelegate>
```
1.2 对象等局部变量使用小驼峰:
```ObjC
NSString *personName = @"";
NSUInteger totalCount = 0;
```
##### 2. 变量的名称必须同时包含功能与类型;
```ObjC
UIButton *addButton //添加按钮
UILabel *nameLabel //名字标签
NSString *addressString//地址字符串
```
##### 3. 系统常用类作实例变量声明时加入后缀

| 类型 | 后缀 |
| :--- | :--- |
| UIViewController | VC |
| UIView | View |
| UILabel | Label |
| UIButton | Button |
| UIImage | Image |
| UIImageView | ImageView |
| NSArray | Array |
| NSMutableArray | MutableArray |
| NSDictionary | Dict |
| NSMutableDictionary | MutableDict |
| NSString | String |
| NSMutableString | MutableString |
| NSSet | Set |
| NSMutableSet | MutablSet |

##### 二. 常量

##### 1. 常量以相关类名作为前缀;

```ObjC
应该:
static const NSTimeInterval VETSignInViewControllerFadeOutAnimationDuration = 0.4;
不应该:
static const NSTimeInterval fadeOutTime = 0.4;
```

##### 2. 建议使用类型常量，不建议使用#define预处理命令

> 首先比较一下这两种声明常量的区别：

* 预处理命令：简单的文本替换，不包括类型信息，并且可被任意修改。
* 类型常量：包括类型信息，并且可以设置其使用范围，而且不可被修改。

##### 3. 对外公开某个常量：

> 如果我们需要发送通知，那么就需要在不同的地方拿到通知的“频道”字符串（通知的名称），那么显然这个字符串是不能被轻易更改，而且可以在不同的地方获取。这个时候就需要定义一个外界可见的字符串常量。

```ObjC
应该:
//头文件
extern NSString *const VETCacheControllerDidClearCacheNotification;
//实现文件
static NSString * const VETCacheControllerDidClearCacheNotification = @"VETCacheControllerDidClearCacheNotification";
static const CGFloat ZOCImageThumbnailHeight = 50.0f;
不应该:
#define CompanyName @"AppleInc."
#define magicNumber 42
```

##### 三. 宏

##### 1. 宏、常量名都要使用大写字母，用下划线‘\_’分割单词;
```ObjC
#define URL_GAIN_QUOTE_LIST @"/v1/quote/list"
#define URL_UPDATE_QUOTE_LIST @"/v1/quote/update"
#define URL_LOGIN @"/v1/user/login”
```
##### 2. 宏定义中如果包含表达式或变量，表达式和变量必须用小括号括起来。

```ObjC
#define VET_MIN(A, B) ((A)>(B)?(B):(A))
```

### 四. CGRect函数

> 其实iOS内部已经提供了相应的获取CGRect各个部分的函数了，它们的可读性比较高，而且简短，推荐使用：

```ObjC
应该:
CGRect frame = self.view.frame;
CGFloat x = CGRectGetMinX(frame);
CGFloat y = CGRectGetMinY(frame);
CGFloat width = CGRectGetWidth(frame);
CGFloat height = CGRectGetHeight(frame);
CGRect frame = CGRectMake(0.0, 0.0, width, height);

不应该:
CGRect frame = self.view.frame;
CGFloat x = frame.origin.x;
CGFloat y = frame.origin.y;
CGFloat width = frame.size.width;
CGFloat height = frame.size.height;
CGRect frame = (CGRect){ .origin = CGPointZero, .size = self.view.frame.size };
```

##### 五. 范型

> 建议在定义NSArray和NSDictionary时使用泛型，可以保证程序的安全性：

```ObjC
NSArray<NSString *> *testArr = [NSArray arrayWithObjects:@"Hello", @"world", nil];
NSDictionary<NSString *, NSNumber *> *dic = @{@"key":@(1), @"age":@(10)};
```

##### 六. Block

> 为常用的Block类型创建typedef
* 如果我们需要重复创建某种block（相同参数，返回值）的变量，可以通过typedef来给某一种块定义属于它自己的新类型;
* 通过typedef定义Block签名的好处是:如果要某种块增加参数，那么只修改定义签名的那行代码即可。

```ObjC
应该:
typedef void(^EOCCompletionHandler)(NSData data, NSError error);
- (void)startWithCompletionHandler:(EOCCompletionHandler)completion;

不应该:
//这里的Block有一个NSData参数，一个NSError参数并没有返回值
- (void)startWithCompletionHandler: (void(^)(NSData data, NSError error))completion;

```

##### 七. 属性

##### 1. 属性的命名使用小驼峰;

```ObjC
@property (nonatomic, readwrite, strong) UIButton *confirmButton;
```

##### 2. 属性的关键字推荐按照 原子性，读写，内存管理的顺序排列;

```ObjC
推荐这样写:
@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *gender;
@property (nonatomic, readwrite, strong) UIView *headerView;

```

##### 3. Block属性应该使用copy关键字;

```ObjC
推荐这样写:
typedef void (^ErrorCodeBlock) (id errorCode,NSString *message);
@property (nonatomic, readwrite, copy) ErrorCodeBlock errorBlock;
```

##### 4. 形容词性的BOOL属性的getter应该加上is前缀;

```ObjC
推荐这样写:
@property (assign, getter=isEditable) BOOL editable;
```

##### 5. 使用getter方法做懒加载;
> 实例化一个对象是需要耗费资源的，如果这个对象里的某个属性的实例化要调用很多配置和计算，就需要懒加载它，在使用它的前一刻对它进行实例化;

```ObjC
static NSString *dateFormatter = @"yyyy-MM-dd HH:mm:ss";
- (NSDateFormatter *)dateFormatter {
if (!_dateFormatter) {
_dateFormatter = [[NSDateFormatter alloc] init];
[_dateFormatter setDateFormat:dateFormatter];
}
return _dateFormatter;
}
```

##### 6. 除了init和dealloc方法，建议都使用点语法访问属性;
* 使用点语法的好处：
* setter：
1. setter会遵守内存管理语义(strong, copy, weak)
2. 通过在内部设置断点，有助于调试bug
3. 可以过滤一些外部传入的值
4. 捕捉KVO通知
* getter：
1. 允许子类化
2. 通过在内部设置断点，有助于调试bug
3. 实现懒加载（lazy initialization）
> 注意：
懒加载的属性，必须通过点语法来读取数据。因为懒加载是通过重写getter方法来初始化实例变量的，如果不通过属性来读取该实例变量，那么这个实例变量就永远不会被初始化。
在init和dealloc方法里面使用点语法的后果是：因为没有绕过setter和getter，在setter和getter里面可能会有很多其他的操作。而且如果它的子类重载了它的setter和getter方法，那么就可能导致该子类调用其他的方法。


##### 7. 不要滥用点语法，要区分好方法调用和属性访问;
```ObjC
应该:
view.backgroundColor = [UIColor orangeColor];
[UIApplication sharedApplication].delegate;
不应该:
[view setBackgroundColor:[UIColor orangeColor]];
UIApplication.sharedApplication.delegate;
```

##### 八. 方法
##### 1. 方法名中不应使用and，而且签名要与对应的参数名保持高度一致

```ObjC
应该:
- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height;
不应该:
- (instancetype)initWithWidth:(CGFloat)width andHeight:(CGFloat)height;
- (instancetype)initWith:(int)width and:(int)height;
```

##### 2. 方法实现时，如果参数过长，则令每个参数占用一行，以冒号对齐;
```ObjC
- (void)doSomethingWith:(NSString *)theFoo
rect:(CGRect)theRect
interval:(CGFloat)theInterval{
//Implementation
}
```
##### 3. 方法名用小写字母开头的单词组合而成;

```ObjC
- (void)viewDidLoad
```
##### 4. 方法名前缀
* 刷新视图的方法名要以refresh为首
* 更新数据的方法名要以update为首

```ObjC
- (void)refreshHeaderViewWithCount:(NSUInteger)count;
- (void)updateDataSourceWithViewModel:(ViewModel*)viewModel;

```

##### 九. iOS 中委托的设计

##### 1. 代理方法的第一个参数必须为委托者
> 代理方法必须以委托者作为第一个参数（参考UITableViewDelegate）的方法。其目的是为了区分不同委托着的实例。因为同一个控制器是可以作为多个tableview的代理的实
```ObjC
应该:
- (void)tableView:(UITableView )tableView didSelectRowAtIndexPath:(NSIndexPath )indexPath

不应该:
- (void)didSelectRowAtIndexPath:(NSIndexPath )indexPath
```

##### 2. 向代理发送消息时需要判断其是否实现该方法
```ObjC
应该:
if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
[self.delegate scrollViewDidScroll:scrollView];
}
不应该:
[self.delegate scrollViewDidScroll:scrollView];

```
##### 3. 遵循代理过多的时候，换行对齐显示;
```ObjC
应该:
@interface ViewController () <UIGestureRecognizerDelegate,
UITableViewDelegate,
UITableViewDataSource>
不应该:
@interface ShopViewController () <UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
```
##### 4. 代理的方法需要明确必须执行和可不执行
```ObjC
@protocol DataCenterCallbackDelegate <NSObject>
@optional //可不实现
- (void)dataCenterFetchDataDidFail:(NSError *)error requestType:(ZLRequestType)type;
@required //必须实现
- (void)dataCenterFetchDataDidSuccess:(NSDictionary *)resultDict;
@end
```

##### 十. 类
##### 1. 类的名称应该以三个大写字母为前缀；创建子类的时候，应该把代表子类特点的部分放在前缀和父类名的中间;
```ObjC
//父类
VETSalesListViewController
//子类
VETDaySalesListViewController
VETMonthSalesListViewController
```
##### 2. initializer && dealloc
2.1 dealloc方法里面应该直接访问实例变量，不应该用点语法访问;
2.2 init方法的写法：
* init方法返回类型必须是instancetype，不能是id;
* 必须先实现[super init]。
```ObjC
- (instancetype)init {
self = [super init]; // call the designated initializer
if (self) {
// Custom initialization
}
return self;
}
```
##### 3. 所有返回类对象和实例对象的方法都应该使用instancetype

```ObjC
应该:
@interface VETPerson
+ (instancetype)personWithName:(NSString *)name;
@end
不应该:
@interface VETPerson
+ (id)personWithName:(NSString *)name;
@end
```
##### 4. 在类的头文件中尽量少引用其他头文件;
> 有时，类A需要将类B的实例变量作为它公共API的属性。这个时候，我们不应该引入类B的头文件，而应该使用向前声明（forward declaring）使用class关键字，并且在A的实现文件引用B的头文件。
```ObjC
// VETPerson.h
#import <Foundation/Foundation.h>
@class VETEmployer;
@interface VETPerson : NSObject
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, strong) VETEmployer *employer;//将VETEmployer作为属性
@end
// VETPerson.m
#import "VETEmployer.h"
```
** 优点 :
* 不在A的头文件中引入B的头文件，就不会一并引入B的全部内容，这样就减少了编译时间;
* 可以避免循环引用：因为如果两个类在自己的头文件中都引入了对方的头文件，那么就会导致其中一个类无法被正确编译。

##### 5. 类的布局

```ObjC
#pragma mark - Life Cycle Methods
- (instancetype)init{
}

- (void)dealloc{
}

- (void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidAppear:(BOOL)animated{
}

- (void)viewWillDisappear:(BOOL)animated{
}

- (void)viewDidDisappear:(BOOL)animated{
}
...
#pragma mark - Override Methods
#pragma mark - Intial Methods
#pragma mark - Lazy Loads
#pragma mark - Target Methods
#pragma mark - Public Methods
#pragma mark - Private Methods
#pragma mark - UITableViewDataSource
#pragma mark - UITableViewDelegate
#pragma mark - NSCopying
#pragma mark - Network Methods
```

##### 十一. 分类

##### 1.分类添加的方法需要添加前缀和下划线

```ObjC
应该:
@interface NSDate (VETTimeExtensions)
- (NSString *)vet_timeAgoShort;
@end
不应该:
@interface NSDate (VETTimeExtensions)
- (NSString *)timeAgoShort;
@end
```
##### 2. 把类的实现代码分散到便于管理的多个分类中

```ObjC
应该:
#import <Foundation/Foundation.h>
@interface VETPerson : NSObject
@property (nonatomic, copy, readonly) NSString *firstName;
@property (nonatomic, copy, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSArray *friends;
- (id)initWithFirstName:(NSString*)firstName
andLastName:(NSString*)lastName;
@end
@interface VETPerson (Friendship)
- (void)addFriend:(EOCPerson*)person;
- (void)removeFriend:(EOCPerson*)person;
- (BOOL)isFriendsWith:(EOCPerson*)person;
@end
@interface VETPerson (Work)
- (void)performDaysWork;
- (void)takeVacationFromWork;
@end
@interface VETPerson (Play)
- (void)goToTheCinema;
- (void)goToSportsGame;
@end

不应该:
#import <Foundation/Foundation.h>
@interface VETPerson : NSObject
@property (nonatomic, copy, readonly) NSString *firstName;
@property (nonatomic, copy, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSArray *friends;
- (id)initWithFirstName:(NSString*)firstName andLastName:(NSString*)lastName;
/* Friendship methods */
- (void)addFriend:(EOCPerson*)person;
- (void)removeFriend:(EOCPerson*)person;
- (BOOL)isFriendsWith:(EOCPerson*)person;
/* Work methods */
- (void)performDaysWork;
- (void)takeVacationFromWork;
/* Play methods */
- (void)goToTheCinema;
- (void)goToSportsGame;
@end
```

##### 十二. 单例

##### 1. 单例不能作为容器对象来使用;
> 单例对象不应该暴露出任何属性，也就是说它不能作为让外部存放对象的容器。它应该是一个处理某些特定任务的工具，比如在iOS中的GPS和加速度传感器。我们只能从他们那里得到一些特定的数据。

##### 2. 使用dispatch_once来生成单例;
```ObjC
应该:
+ (instancetype)sharedInstance {
static id sharedInstance = nil;
static dispatch_once_t onceToken = 0;
dispatch_once(&onceToken, ^{
sharedInstance = [[self alloc] init];
});
return sharedInstance;
}
不应该:
+ (instancetype)sharedInstance {
static id sharedInstance;
@synchronized(self) {
if (sharedInstance == nil) { sharedInstance = [[MyClass alloc] init];
}
}
return sharedInstance;
}
```
##### 十三. 方法文档

##### 1. 一个函数(方法)必须有一个字符串文档来解释，除非它：

* 非公开，私有函数;
* 很短
* 显而易见,通俗易懂

而其余的，包括公开接口，重要的方法，分类，以及协议，都应该伴随文档（注释）：

* 以/开始
* 第二行识总结性的语句
* 第三行永远是空行
* 在与第二行开头对齐的位置写剩下的注释。
```ObjC
推荐:
/This comment serves to demonstrate the format of a doc string.
Note that the summary line is always at most one line long, and after the opening block comment,
and each line of text is preceded by a single space.
*/

看一个指定初始化方法的注释：
/
* Designated initializer. *
* @param store The store for CRUD operations.
* @param searchService The search service used to query the store.
* @return A VETCRUDOperationsStore object.
*/
- (instancetype)initWithOperationsStore:(id<VETGenericStoreProtocol>)store searchService:(id<VETGenericSearchServiceProtocol>)searchService;
```

##### 十四. NSArray & NSMutableArray

##### 1. addObject/removeObject之前要非空判断;

```ObjC
- (void)doSomething{
if (self.infoArray != nil) {
[self.infoArray addObject:object];
}
......
if (self.infoArray.count > 0) {
[self.infoArray removeObject:object];
}
}
```

##### 2. 取下标的时候要判断是否越界;

```ObjC
- (NSString *)objectAtIndex:(NSInteger )index{
if (self.infoArray.count > index &&
index > 0) {
return [self.infoArray objectAtIndex:index];
}else{
return nil;
}
}
```

##### 3. 取第一个元素或最后一个元素的时候使用firtstObject和lastObject

### 十五. NSNotification
##### 1. 通知的名称
> 建议将通知的名字作为常量，保存在一个专门的类中：
```ObjC
// Const.h
extern NSString * const VETFooDidBecomeBarNotification
// Const.m
NSString * const VETFooDidBecomeBarNotification = @"VETFooDidBecomeBarNotification";
```
##### 2. 通知的移除
> 通知必须要在对象销毁之前移除掉。
```ObjC
- (void)dealloc{
[[NSNotificationCenter defaultCenter] removeObserver:self];
}
```

##### 十七. 其他
##### 1. 忽略没有使用变量的编译警告
> 对于某些暂时不用，以后可能用到的临时变量，为了避免警告，我们可以使用如下方法将这个警告消除
```ObjC
- (NSInteger)giveMeFive {
NSString *foo;
#pragma unused (foo)
return 5;
}
```

##### 2. 手动标明警告和错误
* 手动明确一个错误：
```ObjC
- (NSInteger)divide:(NSInteger)dividend by:(NSInteger)divisor {
#error somebody1, somebody2, you need to check for zero here!
return (dividend / divisor);
}
```

* 手动明确一个警告

```ObjC
- (float)divide:(float)dividend by:(float)divisor {
#warning someone, don't compare floating point numbers like this!
if (divisor != 0.0) {
return (dividend / divisor);
} else {
return NAN;
}
}
```





