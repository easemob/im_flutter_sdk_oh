import { ChatClient, ChatMessageListener, ConversationListener } from "@easemob/chatsdk";
import { FlutterPluginBinding, JSONMethodCodec,
  MethodCall,
  MethodCallHandler, MethodChannel,
  MethodResult } from "@ohos/flutter_ohos";
import MethodKey from "./MethodKeys";
import Wrapper from "./Wrapper";

export default class ChatManagerWrapper extends Wrapper implements MethodCallHandler {
  private messageChannel: MethodChannel;
  private listener: ChatMessageListener | undefined;
  private conversationListener: ConversationListener | undefined;

  constructor(binding: FlutterPluginBinding, channelName: string) {
    super(binding, channelName);
    this.messageChannel = new MethodChannel(binding.getBinaryMessenger(), "com.chat,im/chat_message", JSONMethodCodec.INSTANCE);
  }

  public registerEaseListener(): void {
    this.unRegisterEaseListener();
    // this.listener = {};
    // this.conversationListener = {};
  }

  public unRegisterEaseListener(): void {
    if(this.listener != null) {
      ChatClient.getInstance().chatManager()?.removeMessageListener(this.listener);
    }
    if(this.conversationListener != null) {
      ChatClient.getInstance().chatManager()?.removeConversationListener(this.conversationListener);
    }
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (MethodKey.sendMessage == call.method) {
      this.sendMessage(call, result);
    } else if (MethodKey.resendMessage == call.method) {
      this.resendMessage(call, result);
    } else if (MethodKey.ackMessageRead == call.method) {
      this.ackMessageRead(call, result);
    } else if (MethodKey.ackGroupMessageRead == call.method) {
      this.ackGroupMessageRead(call, result);
    } else if (MethodKey.ackConversationRead == call.method) {
      this.ackConversationRead(call, result);
    } else if (MethodKey.recallMessage == call.method) {
      this.recallMessage(call, result);
    } else if (MethodKey.getConversation == call.method) {
      this.getConversation(call, result);
    } else if (MethodKey.getThreadConversation == call.method) {
      this.getThreadConversation(call, result);
    } else if (MethodKey.markAllChatMsgAsRead == call.method) {
      this.markAllChatMsgAsRead(call, result);
    } else if (MethodKey.getUnreadMessageCount == call.method) {
      this.getUnreadMessageCount(call, result);
    } else if (MethodKey.updateChatMessage == call.method) {
      this.updateChatMessage(call, result);
    } else if (MethodKey.downloadAttachment == call.method) {
      this.downloadAttachment(call, result);
    } else if (MethodKey.downloadThumbnail == call.method) {
      this.downloadThumbnail(call, result);
    } else if (MethodKey.downloadMessageAttachmentInCombine == call.method) {
      this.downloadMessageAttachmentInCombine(call, result);
    } else if (MethodKey.downloadMessageThumbnailInCombine == call.method) {
      this.downloadMessageThumbnailInCombine(call, result);
    } else if (MethodKey.importMessages == call.method) {
      this.importMessages(call, result);
    } else if (MethodKey.loadAllConversations == call.method) {
      this.loadAllConversations(call, result);
    } else if (MethodKey.getConversationsFromServer == call.method) {
      this.getConversationsFromServer(call, result);
    } else if (MethodKey.deleteConversation == call.method) {
      this.deleteConversation(call, result);
    } else if (MethodKey.fetchHistoryMessages == call.method) {
      this.fetchHistoryMessages(call, result);
    } else if (MethodKey.fetchHistoryMessagesByOptions == call.method) {
      this.fetchHistoryMessagesByOptions(call, result);
    } else if (MethodKey.searchChatMsgFromDB == call.method) {
      this.searchChatMsgFromDB(call, result);
    } else if (MethodKey.getMessage == call.method) {
      this.getMessage(call, result);
    } else if (MethodKey.asyncFetchGroupAcks == call.method){
      this.asyncFetchGroupMessageAckFromServer(call, result);
    } else if (MethodKey.deleteRemoteConversation == call.method){
      this.deleteRemoteConversation(call, result);
    } else if (MethodKey.deleteMessagesBeforeTimestamp == call.method) {
      this.deleteMessagesBefore(call, result);
    } else if (MethodKey.translateMessage == call.method) {
      this.translateMessage(call, result);
    } else if (MethodKey.fetchSupportedLanguages == call.method) {
      this.fetchSupportedLanguages(call, result);
    } else if (MethodKey.addReaction == call.method) {
      this.addReaction(call, result);
    } else if (MethodKey.removeReaction == call.method) {
      this.removeReaction(call, result);
    } else if (MethodKey.fetchReactionList == call.method) {
      this.fetchReactionList(call, result);
    } else if (MethodKey.fetchReactionDetail == call.method) {
      this.fetchReactionDetail(call, result);
    } else if (MethodKey.reportMessage == call.method) {
      this.reportMessage(call, result);
    } else if (MethodKey.fetchConversationsFromServerWithPage == call.method) {
      this.getConversationsFromServerWithPage(call, result);
    } else if (MethodKey.removeMessagesFromServerWithMsgIds == call.method) {
      this.removeMessagesFromServerWithMsgIds(call, result);
    } else if (MethodKey.removeMessagesFromServerWithTs == call.method) {
      this.removeMessagesFromServerWithTs(call, result);
    } else if (MethodKey.getConversationsFromServerWithCursor == call.method) {
      this.getConversationsFromServerWithCursor(call, result);
    } else if (MethodKey.getPinnedConversationsFromServerWithCursor == call.method) {
      this.getPinnedConversationsFromServerWithCursor(call, result);
    } else if (MethodKey.pinConversation == call.method) {
      this.pinConversation(call, result);
    } else if (MethodKey.modifyMessage == call.method) {
      this.modifyMessage(call, result);
    } else if (MethodKey.downloadAndParseCombineMessage == call.method) {
      this.downloadAndParseCombineMessage(call, result);
    } else if (MethodKey.addRemoteAndLocalConversationsMark == call.method) {
      this.addRemoteAndLocalConversationsMark(call, result);
    } else if (MethodKey.deleteRemoteAndLocalConversationsMark == call.method) {
      this.deleteRemoteAndLocalConversationsMark(call, result);
    } else if (MethodKey.fetchConversationsByOptions == call.method) {
      this.fetchConversationsByOptions(call, result);
    } else if (MethodKey.deleteAllMessageAndConversation == call.method) {
      this.deleteAllMessageAndConversation(call, result);
    } else if (MethodKey.pinMessage == call.method) {
      this.pinMessage(call, result);
    } else if (MethodKey.unpinMessage == call.method) {
      this.unpinMessage(call, result);
    } else if (MethodKey.fetchPinnedMessages == call.method) {
      this.fetchPinnedMessages(call, result);
    } else if (MethodKey.searchMsgsByOptions == call.method) {
      this.searchMsgByOptions(call, result);
    } else if (MethodKey.getMessageCount == call.method) {
      this.getMessageCount(call, result);
    } else {
      super.onMethodCall(call, result);
    }
  }
  private sendMessage(call: MethodCall, result: MethodResult) {}
  private resendMessage(call: MethodCall, result: MethodResult) {}
  private ackMessageRead(call: MethodCall, result: MethodResult) {}
  private ackGroupMessageRead(call: MethodCall, result: MethodResult) {}
  private ackConversationRead(call: MethodCall, result: MethodResult) {}
  private recallMessage(call: MethodCall, result: MethodResult) {}
  private getConversation(call: MethodCall, result: MethodResult) {}
  private getThreadConversation(call: MethodCall, result: MethodResult) {}
  private markAllChatMsgAsRead(call: MethodCall, result: MethodResult) {}
  private getUnreadMessageCount(call: MethodCall, result: MethodResult) {}
  private updateChatMessage(call: MethodCall, result: MethodResult) {}
  private downloadAttachment(call: MethodCall, result: MethodResult) {}
  private downloadThumbnail(call: MethodCall, result: MethodResult) {}
  private downloadMessageAttachmentInCombine(call: MethodCall, result: MethodResult) {}
  private downloadMessageThumbnailInCombine(call: MethodCall, result: MethodResult) {}
  private importMessages(call: MethodCall, result: MethodResult) {}
  private loadAllConversations(call: MethodCall, result: MethodResult) {}
  private getConversationsFromServer(call: MethodCall, result: MethodResult) {}
  private deleteConversation(call: MethodCall, result: MethodResult) {}
  private fetchHistoryMessages(call: MethodCall, result: MethodResult) {}
  private fetchHistoryMessagesByOptions(call: MethodCall, result: MethodResult) {}
  private searchChatMsgFromDB(call: MethodCall, result: MethodResult) {}
  private getMessage(call: MethodCall, result: MethodResult) {}
  private asyncFetchGroupMessageAckFromServer(call: MethodCall, result: MethodResult) {}
  private deleteRemoteConversation(call: MethodCall, result: MethodResult) {}
  private deleteMessagesBefore(call: MethodCall, result: MethodResult) {}
  private translateMessage(call: MethodCall, result: MethodResult) {}
  private fetchSupportedLanguages(call: MethodCall, result: MethodResult) {}
  private addReaction(call: MethodCall, result: MethodResult) {}
  private removeReaction(call: MethodCall, result: MethodResult) {}
  private fetchReactionList(call: MethodCall, result: MethodResult) {}
  private fetchReactionDetail(call: MethodCall, result: MethodResult) {}
  private reportMessage(call: MethodCall, result: MethodResult) {}
  private getConversationsFromServerWithPage(call: MethodCall, result: MethodResult) {}
  private removeMessagesFromServerWithMsgIds(call: MethodCall, result: MethodResult) {}
  private removeMessagesFromServerWithTs(call: MethodCall, result: MethodResult) {}
  private getConversationsFromServerWithCursor(call: MethodCall, result: MethodResult) {}
  private getPinnedConversationsFromServerWithCursor(call: MethodCall, result: MethodResult) {}
  private pinConversation(call: MethodCall, result: MethodResult) {}
  private modifyMessage(call: MethodCall, result: MethodResult) {}
  private downloadAndParseCombineMessage(call: MethodCall, result: MethodResult) {}
  private addRemoteAndLocalConversationsMark(call: MethodCall, result: MethodResult) {}
  private deleteRemoteAndLocalConversationsMark(call: MethodCall, result: MethodResult) {}
  private fetchConversationsByOptions(call: MethodCall, result: MethodResult) {}
  private deleteAllMessageAndConversation(call: MethodCall, result: MethodResult) {}
  private pinMessage(call: MethodCall, result: MethodResult) {}
  private unpinMessage(call: MethodCall, result: MethodResult) {}
  private fetchPinnedMessages(call: MethodCall, result: MethodResult) {}
  private searchMsgByOptions(call: MethodCall, result: MethodResult) {}
  private getMessageCount(call: MethodCall, result: MethodResult) {}
}