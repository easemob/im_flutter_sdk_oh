import { ChatError } from "@easemob/chatsdk";


export default class ChatErrorHelper {
  static toJson(err: ChatError): Map<string, Object> {
    let ret = new Map<string, Object>();
    ret.set("code", err.errorCode);
    ret.set("description", err.description);
    return ret;
  }

  static infoToJson(code: number, desc: string): Map<string, object> {
    let ret = new Map<string, Object>();
    ret.set("code", code);
    ret.set("description", desc);
    return ret;
  }
}