import { ChatMessageListener, ConversationListener } from "@easemob/chatsdk";
import { FlutterPluginBinding, JSONMethodCodec, MethodCallHandler, MethodChannel } from "@ohos/flutter_ohos";
import Wrapper from "./Wrapper";

export default class ChatManagerWrapper extends Wrapper implements MethodCallHandler {
  private messageChannel: MethodChannel;
  private listener: ChatMessageListener | undefined;
  private conversationListener: ConversationListener | undefined;

  constructor(binding: FlutterPluginBinding, channelName: string) {
    super(binding, channelName);
    this.messageChannel = new MethodChannel(binding.getBinaryMessenger(), "com.chat,im/chat_message", JSONMethodCodec.INSTANCE);
  }
}