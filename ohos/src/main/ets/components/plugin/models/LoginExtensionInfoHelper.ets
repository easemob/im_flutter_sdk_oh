import { LoginExtInfo } from "@easemob/chatsdk";

export default class LoginExtensionInfoHelper {
  static toJson(info: LoginExtInfo): Map<string, Object> {
    let ret = new Map<string, Object>();
    ret.set("deviceName", info.deviceInfo);
    ret.set("ext", info.deviceExt);
    return ret;
  }
}