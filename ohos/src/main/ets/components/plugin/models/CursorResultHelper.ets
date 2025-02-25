import { ChatMessage,
  ChatMessageReaction,
  Chatroom, Contact, Conversation, CursorResult, Group, GroupReadAck } from "@easemob/chatsdk";
import ContactHelper from "./ContactHelper";
import GroupHelper from "./GroupHelper";

export default class CursorResultHelper {
  // TODO: 补全类型
    static toJson<T>(result: CursorResult<T>):Map<string, Object> {
      let data = new Map<string, Object>();
      data.set("cursor", result.getNextCursor());
      let list = Array<Object>();

      for (let index = 0; index < result.getResult().length; index++) {
        const element = result.getResult()[index];
        if (element instanceof ChatMessage) {

        }
        else if (element instanceof Group) {
          list.push(GroupHelper.toJson(element));
        }
        else if (element instanceof Chatroom) {

        }
        else if (element instanceof GroupReadAck) {

        }
        else if (element instanceof ChatMessageReaction) {

        }
        else if (element instanceof Conversation) {

        }
        else if (element instanceof Contact) {
          list.push(ContactHelper.toJson(element));
        }
        else if (element instanceof String) {
          list.push(element);
        }
      }
      data.set("list", list);
      return data;
    }
}