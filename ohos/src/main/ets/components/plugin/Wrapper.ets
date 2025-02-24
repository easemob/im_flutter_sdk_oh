import {
  Any,
  FlutterPluginBinding, MethodCall, MethodCallHandler, MethodChannel, MethodResult } from "@ohos/flutter_ohos";
import { common } from "@kit.AbilityKit";
import { ChatError } from "@easemob/chatsdk";
import { HashMap } from "@kit.ArkTS";
import ChatErrorHelper from "./models/ChatErrorHelper";

export default class Wrapper implements  MethodCallHandler{

  public context: common.Context  | null = null;
  public binding: FlutterPluginBinding | null = null;
  public channel: MethodChannel | null = null;

  constructor(binding: FlutterPluginBinding, channelName: string) {
    this.context = binding.getApplicationContext();
    this.binding = binding;
    this.channel = new MethodChannel(this.binding.getBinaryMessenger(), `com.chat.im/${channelName}`);
    this.channel.setMethodCallHandler(this);
  }

  public onSuccess(result: MethodResult, method: string, object?: Object): void {
    let map = new HashMap<string, Object>();
    if(object != null) {
      map.set(method, object);
    }
    result.success(map);
  }

  public onError(result: MethodResult, e: ChatError): void {
    let map = new HashMap<string, Object>();
    map.set("error", ChatErrorHelper.toJson(e));
    result.success(map);
  }


  onMethodCall(call: MethodCall, result: MethodResult): void {
    result.notImplemented();
  }
}