import {
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';

import {
  ChatClient,
  ChatError,
  ChatLog,
  ChatOptions,
  ConnectionListener,
  LoginExtInfo,
  PushListener
} from '@easemob/chatsdk';

import common from '@ohos.app.ability.common';
import ClientWrapper from './ClientWrapper';

/** ImFlutterSdkOhPlugin **/
export default class ImFlutterSdkOhPlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;
  private context: common.Context  | null = null;
  private messageChannel: MethodChannel | null = null;
  private clientWrapper: ClientWrapper | null = null;;
  constructor() {
  }

  getUniqueClassName(): string {
    return "ImFlutterSdkOhPlugin"
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.clientWrapper = new ClientWrapper(binding, "chat_client");
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null)
    }
  }

  public sendDataToFlutter(data: Map<string, Object>):void {
    if(this.clientWrapper != null) {
      this.clientWrapper.sendDataToFlutter(data);
    }
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (call.method == "getPlatformVersion") {
      let options = new ChatOptions({appKey: "easemob#easeim"});
      ChatClient.getInstance().init(this.context, options);
      ChatClient.getInstance().login("du001", "1").then(() => {
        result.success("login success ^ ^ ")
      }).catch((e: ChatError) => {
        result.success("login err ^ ^ ")
      });
    }
    else if(call.method == "startCallBack") {
      this.messageChannel?.invokeMethod("test", "2");
    }

    else {
      result.notImplemented()
    }
  }
}

