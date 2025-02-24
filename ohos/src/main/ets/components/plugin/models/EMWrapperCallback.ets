import { EMCallback } from "@easemob/chatsdk/src/main/cpp/types/libhyphenate";
import { MethodResult } from "@ohos/flutter_ohos";
import { HashMap } from "@kit.ArkTS";
import ChatErrorHelper from "./ChatErrorHelper";
import { ChatError } from "@easemob/chatsdk";

export default class EMWrapperCallback extends  EMCallback {
  private result: MethodResult | null = null;
  private method: string | null = null;
  private object: undefined;
  EMWrapperCallback(result: MethodResult, method:string, object:Object | undefined) {
      this.result = result;
      this.method = this.method;
      this.object = this.object;
      this.onSuccess = this.wrapperSuccess;
      this.onFail = this.wrapperError;
      this.onProgress = this.wrapperProgress;
  }

  wrapperSuccess(){
    let data = new HashMap<string, Object>();
    if(this.object != null) {
        data.set(this.method, this.object);
    }
    this.result?.success(data);
  }

  wrapperError(e: ChatError) {
    let data = new HashMap<string, Object>();
    data.set("error", ChatErrorHelper.toJson(e));
    this.result?.success(data);
  }

  wrapperProgress(progress: number) {
    // no need;
  }
}