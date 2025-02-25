import { Group, SharedFile } from "@easemob/chatsdk";
import { SafetyValue } from "../SafetyMapTool";

export default class SharedFileHelper {
  static toJson(file: SharedFile): Map<string, Object> {
    let data = new Map<string, Object>();
    data.set("fileId", file.fileId());
    data.set("name", file.fileName());
    data.set("owner", file.fileOwner());
    data.set("createTime", file.fileUpdateTime());
    data.set("fileSize", file.fileSize());
    return data;
  }

  static listToJson(files: SharedFile[]): Map<string, Object>[] {
    let list = new Array<Map<string, Object>>();
    for (let index = 0; index < files.length; index++) {
      const file = files[index];
      list.push(SharedFileHelper.toJson(file));
    }
    return list;
  }
}

