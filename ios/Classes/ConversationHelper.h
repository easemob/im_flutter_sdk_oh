//
//  EMConversation+Helper.h
//  im_flutter_sdk
//
//  Created by 杜洁鹏 on 2020/9/21.
//

#import "ChatHeaders.h"
#import "ModeToJson.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMConversation (Helper) <ModeToJson>
- (NSDictionary *)toJson;
@end

NS_ASSUME_NONNULL_END
