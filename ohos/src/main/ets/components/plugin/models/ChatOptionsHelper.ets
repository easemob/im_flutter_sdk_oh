import { ChatOptions } from "@easemob/chatsdk";

export default class ChatOptionsHelper {
  static fromJson(param: Map <string, Object>): ChatOptions {
    let appKey:string | undefined;
    let appId:string | undefined;
    if(param.has("appKey")) {
      appKey = param.get("appKey") as string;
    }else {
      appId = param.get("appId") as string;
    }

    let options = new ChatOptions({appKey:appKey, appId:appId});
    if(typeof param.get("autoLogin") === 'boolean') {
      options.setAutoLogin(param.get("autoLogin") as boolean);
    }
    if(typeof param.get("requireAck") === 'boolean') {
      options.setRequireReadAck(param.get("requireAck") as boolean);
    }
    if(typeof param.get("requireDeliveryAck") === 'boolean') {
      options.setRequireDeliveryAck(param.get("requireDeliveryAck") as boolean);
    }
    if(typeof param.get("sortMessageByServerTime") === 'boolean') {
      options.setSortMessageByServerTime(param.get("sortMessageByServerTime") as boolean);
    }
    if(typeof param.get("acceptInvitationAlways") === 'boolean') {
      options.setAcceptInvitationAlways(param.get("acceptInvitationAlways") as boolean);
    }
    if(typeof param.get("autoAcceptGroupInvitation") === 'boolean') {
      options.setAutoAcceptGroupInvitations(param.get("autoAcceptGroupInvitation") as boolean);
    }
    if(typeof param.get("deleteMessagesAsExitGroup") === 'boolean') {
      options.setDeleteMessagesOnLeaveGroup(param.get("deleteMessagesAsExitGroup") as boolean);
    }
    if(typeof param.get("deleteMessagesAsExitChatRoom") === 'boolean') {
      options.setDeleteMessagesOnLeaveChatroom(param.get("deleteMessagesAsExitChatRoom") as boolean);
    }
    if(typeof param.get("isAutoDownload") === 'boolean') {
      options.setAutoDownloadThumbnail(param.get("isAutoDownload") as boolean);
    }
    if(typeof param.get("isChatRoomOwnerLeaveAllowed") === 'boolean') {
      options.allowChatroomOwnerLeave(param.get("isChatRoomOwnerLeaveAllowed") as boolean);
    }
    if(typeof param.get("serverTransfer") === 'boolean') {
      options.setAutoTransferMessageAttachments(param.get("serverTransfer") as boolean);
    }
    if(typeof param.get("areaCode") === 'number') {
      options.setAreaCode(param.get("areaCode") as number);
    }
    if(typeof param.get("usingHttpsOnly") === 'boolean') {
      options.setUsingHttpsOnly(param.get("usingHttpsOnly") as boolean);
    }
    if(typeof param.get("deviceName") === 'string') {
      options.setCustomDeviceName(param.get("deviceName") as string);
    }
    if(typeof param.get("osType") === 'number') {
      options.setCustomOSPlatform(param.get("osType") as number);
    }
    if(typeof param.get("imPort") === 'number') {
      options.setImPort(param.get("imPort") as number);
    }
    if(typeof param.get("imServer") === 'string') {
      options.setIMServer(param.get("imServer") as string);
    }
    if(typeof param.get("restServer") === 'string') {
      options.setRestServer(param.get("restServer") as string);
    }
    if(typeof param.get("dnsUrl") === 'string') {
      options.setDnsURL(param.get("dnsUrl") as string);
    }

    if(typeof param.get("enableTLS") === 'boolean') {
      options.setEnableTLSConnection(param.get("enableTLS") as boolean);
    }
    if(typeof param.get("useReplacedMessageContents") === 'boolean') {
      options.setUseReplacedMessageContents(param.get("useReplacedMessageContents") as boolean);
    }
    if(typeof param.get("messagesReceiveCallbackIncludeSend") === 'boolean') {
      options.setIncludeSendMessageInMessageListener(param.get("messagesReceiveCallbackIncludeSend") as boolean);
    }

    // TODO
    // options.setAppIDForPush(param.get("dnsUrl") as string);

    // TODO
    // if(typeof param.get("regardImportMessagesAsRead") === 'boolean') {
    // }

    // TODO
    // if(typeof param.get("loginExtensionInfo") === 'string') {
    // }
		return options;
	}
}