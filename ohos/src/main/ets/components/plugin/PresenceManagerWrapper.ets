import { PresenceListener } from "@easemob/chatsdk";
import { FlutterPluginBinding, MethodCallHandler } from "@ohos/flutter_ohos";
import Wrapper from "./Wrapper";

export default class PresenceManagerWrapper extends Wrapper implements MethodCallHandler {
  private listener: PresenceListener | undefined;

  constructor(binding: FlutterPluginBinding, channelName: string) {
    super(binding, channelName);

  }
}