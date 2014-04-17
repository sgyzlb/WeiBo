

/*
 存放微博账号等配置信息
 */

// 账号：643055866@qq.com
// 密码：itcastios
#define kAppKey       @"2783540646"
#define kAppSecret   @"ca07a4fda7bedb05407e04394c2d7aa2"

#define kAccessToken          @"access_token"
#define kUid                           @"uid"

// 没有回调地址
#define kRedirectURL  @"http://"

// 授权地址
// 授权一步到位的方法
#define kOauthURL     [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&display=mobile&response_type=token",kAppKey,kRedirectURL]
// response_type=token直接返回accessToken

// 公共请求地址
// 开始请求各种参数和详细参数
#define kBaseURL  @"https://api.weibo.com/2/"


