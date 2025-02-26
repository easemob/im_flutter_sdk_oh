import { GroupReadAck } from "@easemob/chatsdk";
import { SafetyValue } from "../SafetyMapTool";

export default class GroupReadAckHelper {
  static toJson(ack: GroupReadAck): Map<string, Object> {
    let ret = new Map<string, Object>();
    SafetyValue(ack.getMsgId(), (value)=>ret.set("msg_id", value));
    SafetyValue(ack.getAckId(), (value)=>ret.set("ack_id", value));
    SafetyValue(ack.getFrom(), (value)=>ret.set("from", value));
    SafetyValue(ack.getCount(), (value)=>ret.set("count", value));
    SafetyValue(ack.getTimestamp(), (value)=>ret.set("timestamp", value));
    SafetyValue(ack.getContent(), (value)=>ret.set("content", value));
    return ret;
  }
}