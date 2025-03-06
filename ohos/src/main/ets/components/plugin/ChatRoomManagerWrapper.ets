import { ChatMessageListener, ChatroomListener, ConversationListener } from "@easemob/chatsdk";
import { FlutterPluginBinding, JSONMethodCodec, MethodCallHandler, MethodChannel } from "@ohos/flutter_ohos";
import Wrapper from "./Wrapper";

export default class ChatRoomManagerWrapper extends Wrapper implements MethodCallHandler {
  private listener: ChatroomListener | undefined;

  constructor(binding: FlutterPluginBinding, channelName: string) {
    super(binding, channelName);
  }
}