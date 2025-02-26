import { ConversationFilter } from "@easemob/chatsdk";
import { GetSafetyValue } from "./SafetyMapTool";

export default class ConversationFilterHelper {
  static fromJson(json: Map<string, Object>): ConversationFilter {
    let filter = new ConversationFilter();
    filter.markType = GetSafetyValue(json, "mark")!;
    filter.pageSize = GetSafetyValue(json, "pageSize")!;
    filter.cursor = GetSafetyValue(json, "cursor");
    return filter;
  }
}