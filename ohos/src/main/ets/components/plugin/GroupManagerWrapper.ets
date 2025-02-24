import { ChatClient, ChatMessageListener, ConversationListener, GroupListener } from "@easemob/chatsdk";
import { FlutterPluginBinding, JSONMethodCodec, MethodCallHandler, MethodChannel } from "@ohos/flutter_ohos";
import ClientWrapper from "./ClientWrapper";
import Wrapper from "./Wrapper";

export default class GroupManagerWrapper extends Wrapper implements MethodCallHandler {
  private listener: GroupListener | undefined;
  public clientWrapper: ClientWrapper | null = null;

  constructor(binding: FlutterPluginBinding, channelName: string) {
    super(binding, channelName);
  }
}