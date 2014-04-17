
// 获得颜色
#define kGetColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

/*
 一条微博上的颜色
 */
// 昵称
#define kScreenNameColor kGetColor(88, 88, 88)
// 会员昵称颜色
#define kMBScreenNameColor kGetColor(244, 103, 8)
// 时间
#define kTimeColor kGetColor(246, 157, 46)
// 内容
#define kContentColor kGetColor(52, 52, 52)
// 来源
#define kSourceColor kGetColor(153, 153, 153)
// 被转发昵称
#define kRetweetScreenNameColor kGetColor(81, 126, 175)
// 被转发内容
#define kRetweetContentColor kGetColor(109, 109, 109)

// 昵称
#define kScreenNameFont [UIFont systemFontOfSize:17]
// 正文
#define kContentFont kScreenNameFont
// 时间
#define kTimeFont [UIFont systemFontOfSize:13]
// 来源
#define kSourceFont  [UIFont systemFontOfSize:13]

// 被转发的昵称
#define kRetweetScreenNameFont [UIFont systemFontOfSize:15]
// 被转发的正文
#define  kRetweeContentFont   kRetweetScreenNameFont


// 头像的尺寸

#define kIconSmallWidth 34
#define kIconSmallHeight  34

#define kIconWidth 50
#define kIconHeight 50

#define kIconBigWidth 85
#define kIconBigHeight 85

// 微博认证尺寸
#define kVerifiedWidth 18
#define kVerifiedHeight 18

// 皇冠的尺寸
#define kMBIconWidth 14
#define kMBIconHeight 14

// cell边框的宽度
#define kCellBorderWidth 10
// cell的边框宽度
#define kTableBorderWidth 5
// tableView第一个cell的间距
#define kTableTopBorderWidth 5
// tableView每个cell的间距
#define kTableViewMargin 5;


// 配图的尺寸
#define kImageWidth 120
#define kImageHeight 120




