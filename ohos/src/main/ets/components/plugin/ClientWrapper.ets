import { ChatClient, ChatError } from '@easemob/chatsdk';
import { FlutterPluginBinding, MethodCall, MethodResult } from '@ohos/flutter_ohos';
import MethodKey from './MethodKeys';
import ChatOptionsHelper from './models/ChatOptionsHelper';
import Wrapper from './Wrapper';

export default class ClientWrapper extends Wrapper {


  constructor(binding: FlutterPluginBinding, channelName: string) {
    super(binding, channelName);
  }


  public sendDataToFlutter(data: Map<string, Object>) {
    if(data != null) {
      this.channel?.invokeMethod(MethodKey.onSendDataToFlutter, data);
    }
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (MethodKey.init == call.method) {
      this.init(call, result);
    }
    else if (MethodKey.createAccount == call.method)
    {
      this.createAccount(call, result);
    }
    else if (MethodKey.login == call.method)
    {
      this.login(call, result);
    }
    else if (MethodKey.logout == call.method)
    {
      this.logout(call, result);
    }
    else if (MethodKey.changeAppKey == call.method)
    {
      this.changeAppKey(call, result);
    }
    else if (MethodKey.uploadLog == call.method)
    {
      this.uploadLog(call, result);
    }
    else if (MethodKey.compressLogs == call.method)
    {
      this.compressLogs(call, result);
    }
    else if (MethodKey.getLoggedInDevicesFromServer == call.method)
    {
      this.getLoggedInDevicesFromServer(call, result);
    }
    else if (MethodKey.kickDevice == call.method)
    {
      this.kickDevice(call, result);
    }
    else if (MethodKey.kickAllDevices == call.method)
    {
     this.kickAllDevices(call, result);
    }
    else if (MethodKey.isLoggedInBefore == call.method)
    {
      this.isLoggedInBefore(call, result);
    }
    else if (MethodKey.getCurrentUser == call.method)
    {
      this.getCurrentUser(call, result);
    }
    else if (MethodKey.loginWithAgoraToken == call.method)
    {
      this.loginWithAgoraToken(call, result);
    }
    else if (MethodKey.getToken == call.method)
    {
      this.getToken(call, result);
    }
    else if (MethodKey.isConnected == call.method) {
      this.isConnected(call, result);
    }
    else if (MethodKey.renewToken == call.method){
      this.renewToken(call, result);
    }
    else if (MethodKey.startCallback == call.method) {
      this.startCallback(call, result);
    }
    else if (MethodKey.updateUsingHttpsOnlySetting == call.method) {
      this.updateUsingHttpsOnlySetting(call, result);
    }
    else if (MethodKey.updateLoginExtensionInfo == call.method) {
      this.updateLoginExtensionInfo(call, result);
    }
    else if (MethodKey.updateDeleteMessagesWhenLeaveGroupSetting == call.method) {
      this.updateDeleteMessagesWhenLeaveGroupSetting(call, result);
    }
    else if (MethodKey.updateDeleteMessageWhenLeaveRoomSetting == call.method) {
      this.updateDeleteMessageWhenLeaveRoomSetting(call, result);
    }
    else if (MethodKey.updateRoomOwnerCanLeaveSetting == call.method) {
      this.updateRoomOwnerCanLeaveSetting(call, result);
    }
    else if (MethodKey.updateAutoAcceptGroupInvitationSetting == call.method) {
      this.updateAutoAcceptGroupInvitationSetting(call, result);
    }
    else if (MethodKey.acceptInvitationAlways == call.method) {
      this.acceptInvitationAlways(call, result);
    }
    else if (MethodKey.updateAutoDownloadAttachmentThumbnailSetting == call.method) {
      this.updateAutoDownloadAttachmentThumbnailSetting(call, result);
    }
    else if (MethodKey.updateRequireAckSetting == call.method) {
      this.updateRequireAckSetting(call, result);
    }
    else if (MethodKey.updateDeliveryAckSetting == call.method) {
      this.updateDeliveryAckSetting(call, result);
    }
    else if (MethodKey.updateSortMessageByServerTimeSetting == call.method) {
      this.updateSortMessageByServerTimeSetting(call, result);
    }
    else if (MethodKey.updateMessagesReceiveCallbackIncludeSendSetting == call.method) {
      this.updateMessagesReceiveCallbackIncludeSendSetting(call, result);
    }
    else if (MethodKey.updateRegradeMessagesSetting == call.method) {
      this.updateRegradeMessagesSetting(call, result);
    }
    else if (MethodKey.changeAppId == call.method) {
      this.changeAppId(call, result);
    }
    else  {
      super.onMethodCall(call, result);
    }
  }

  private init(call: MethodCall, result: MethodResult) {
      let options = ChatOptionsHelper.fromJson(call.args as Map<string, Object>);
      ChatClient.getInstance().init(this.context, options);
      this.onSuccess(result, call.method);
  }

  private createAccount(call: MethodCall, result: MethodResult) {
    let userId = call.argument("username") as string;
    let password = call.argument("password") as string;
    ChatClient.getInstance().createAccount(userId, password)
      .then(() => this.onSuccess(result, call.method))
      .catch((e: ChatError) => this.onError(result, e));
  }

  private login(call: MethodCall, result: MethodResult) {
    let isPwd = call.argument("isPassword") as boolean;
    let userId = call.argument("username") as string;
    let pwdOrToken = call.argument("pwdOrToken") as string;
    if(isPwd) {
      ChatClient.getInstance().login(userId, pwdOrToken)
        .then(() => this.onSuccess(result, call.method))
        .catch((e: ChatError) => this.onError(result, e));
    }else {
      ChatClient.getInstance().loginWithToken(userId, pwdOrToken)
        .then(() => this.onSuccess(result, call.method))
        .catch((e: ChatError) => this.onError(result, e));
    }
  }

  private logout(call: MethodCall, result: MethodResult) {
    let unbindToken = call.argument("unbindToken") as boolean;
    ChatClient.getInstance().logout(unbindToken)
      .then(() => this.onSuccess(result, call.method))
      .catch((e: ChatError) => this.onError(result, e));
  }

  private changeAppKey(call: MethodCall, result: MethodResult) {
    let appKey = call.argument("appKey") as string;
    let chatError = ChatClient.getInstance().changeAppkey(appKey)
    if(chatError == null) {
      this.onSuccess(result, call.method);
    }else {
      this.onError(result, chatError);
    }
  }

  private uploadLog(call: MethodCall, result: MethodResult) {
    ChatClient.getInstance().uploadLog()
      .then(() => this.onSuccess(result, call.method))
      .catch((e: ChatError) => this.onError(result, e));
  }

  private compressLogs(_: MethodCall, result: MethodResult) {
    result.notImplemented();
  }

  private getLoggedInDevicesFromServer(_: MethodCall, result: MethodResult) {
    result.notImplemented();
  }

  private kickDevice(_: MethodCall, result: MethodResult) {
    result.notImplemented();
  }

  private kickAllDevices(_: MethodCall, result: MethodResult) {
    result.notImplemented();
  }

  private isLoggedInBefore(call: MethodCall, result: MethodResult) {
    let options = ChatClient.getInstance().getOptions();
    this.onSuccess(result,call.method, ChatClient.getInstance().isLoggedIn() && options?.isAutoLogin());
  }

  private getCurrentUser(call: MethodCall, result: MethodResult) {
    this.onSuccess(result,call.method, ChatClient.getInstance().getCurrentUser());
  }

  private loginWithAgoraToken(call: MethodCall, result: MethodResult) {
    let username = call.argument("username") as string;
    let agoraToken = call.argument("agora_token") as string;
    ChatClient.getInstance().loginWithToken(username, agoraToken)
      .then(() => this.onSuccess(result, call.method))
      .catch((e: ChatError) => this.onError(result, e));
  }

  private getToken(call: MethodCall, result: MethodResult) {
    let token = ChatClient.getInstance().getAccessToken();
    this.onSuccess(result, call.method, token);
  }

  private isConnected(_: MethodCall, result: MethodResult) {
    result?.notImplemented();
  }

  private renewToken(call: MethodCall, result: MethodResult) {
    let token = call.argument("agora_token") as string;
    ChatClient.getInstance().renewToken(token)
      .then(() => this.onSuccess(result, call.method))
      .catch((e: ChatError) => this.onError(result, e));
  }

  private startCallback(call: MethodCall, result: MethodResult) {
    // TODO:
  }

  private updateUsingHttpsOnlySetting(call: MethodCall, result: MethodResult) {
    let usingHttpsOnly = call.argument("usingHttpsOnly") as boolean;
    let options = ChatClient.getInstance().getOptions();
    options?.setUsingHttpsOnly(usingHttpsOnly)
    this.onSuccess(result, call.method);
  }

  private updateLoginExtensionInfo(call: MethodCall, result: MethodResult) {
    let extension = call.argument("extension") as string;
    let options = ChatClient.getInstance().getOptions();
    options?.setLoginCustomExt(extension);
    this.onSuccess(result, call.method);
  }

  private updateDeleteMessagesWhenLeaveGroupSetting(call: MethodCall, result: MethodResult) {
    let deleteMessagesWhenLeaveGroup = call.argument("deleteMessagesWhenLeaveGroup") as boolean;
    let options = ChatClient.getInstance().getOptions();
    options?.setDeleteMessagesOnLeaveGroup(deleteMessagesWhenLeaveGroup);
    this.onSuccess(result, call.method);
  }

  private updateDeleteMessageWhenLeaveRoomSetting(call: MethodCall, result: MethodResult) {
    let deleteMessageWhenLeaveRoom = call.argument("deleteMessageWhenLeaveRoom") as boolean;
    let options = ChatClient.getInstance().getOptions();
    options?.setDeleteMessagesOnLeaveChatroom(deleteMessageWhenLeaveRoom);
    this.onSuccess(result, call.method);
  }

  private updateRoomOwnerCanLeaveSetting(call: MethodCall, result: MethodResult) {
    let roomOwnerCanLeave = call.argument("roomOwnerCanLeave") as boolean;
    let options = ChatClient.getInstance().getOptions();
    options?.allowChatroomOwnerLeave(roomOwnerCanLeave);
    this.onSuccess(result, call.method);
  }

  private updateAutoAcceptGroupInvitationSetting(call: MethodCall, result: MethodResult) {
    let autoAcceptGroupInvitation = call.argument("autoAcceptGroupInvitation") as boolean;
    let options = ChatClient.getInstance().getOptions();
    options?.setAutoAcceptGroupInvitations(autoAcceptGroupInvitation);
    this.onSuccess(result, call.method);
  }

  private acceptInvitationAlways(call: MethodCall, result: MethodResult) {
    let acceptInvitationAlways = call.argument("acceptInvitationAlways") as boolean;
    let options = ChatClient.getInstance().getOptions();
    options?.setAcceptInvitationAlways(acceptInvitationAlways);
    this.onSuccess(result, call.method);
  }

  private updateAutoDownloadAttachmentThumbnailSetting(call: MethodCall, result: MethodResult) {
    let autoDownloadThumbnail = call.argument("autoDownloadThumbnail") as boolean;
    let options = ChatClient.getInstance().getOptions();
    options?.setAutoDownloadThumbnail(autoDownloadThumbnail);
    this.onSuccess(result, call.method);
  }

  private updateRequireAckSetting(call: MethodCall, result: MethodResult) {
    let requireAck = call.argument("requireAck") as boolean;
    let options = ChatClient.getInstance().getOptions();
    options?.setRequireReadAck(requireAck);
    this.onSuccess(result, call.method);
  }

  private updateDeliveryAckSetting(call: MethodCall, result: MethodResult) {
    let requireDeliveryAck = call.argument("requireDeliveryAck") as boolean;
    let options = ChatClient.getInstance().getOptions();
    options?.setRequireDeliveryAck(requireDeliveryAck);
    this.onSuccess(result, call.method);
  }

  private updateSortMessageByServerTimeSetting(call: MethodCall, result: MethodResult) {
    let sortMessageByServerTime = call.argument("sortMessageByServerTime") as boolean;
    let options = ChatClient.getInstance().getOptions();
    options?.setSortMessageByServerTime(sortMessageByServerTime);
    this.onSuccess(result, call.method);
  }

  private updateMessagesReceiveCallbackIncludeSendSetting(call: MethodCall, result: MethodResult) {
    let includeSend = call.argument("includeSend") as boolean;
    let options = ChatClient.getInstance().getOptions();
    options?.setIncludeSendMessageInMessageListener(includeSend);
    this.onSuccess(result, call.method);
  }

  private updateRegradeMessagesSetting(_: MethodCall, result: MethodResult) {
    result.notImplemented();
  }

  private changeAppId(call: MethodCall, result: MethodResult) {
    let appId = call.argument("appId") as string;
    let err = ChatClient.getInstance().changeAppId(appId);
    if(err == null) {
      this.onSuccess(result, call.method);
    }else {
      this.onError(result, err);
    }
  }
}