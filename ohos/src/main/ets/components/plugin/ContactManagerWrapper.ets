import { ChatMessageListener, ChatroomListener, ContactListener, ConversationListener } from "@easemob/chatsdk";
import { FlutterPluginBinding, JSONMethodCodec, MethodCallHandler, MethodChannel } from "@ohos/flutter_ohos";
import Wrapper from "./Wrapper";

export default class ContactManagerWrapper extends Wrapper implements MethodCallHandler {
  private listener: ContactListener | undefined;

  constructor(binding: FlutterPluginBinding, channelName: string) {
    super(binding, channelName);
  }
}