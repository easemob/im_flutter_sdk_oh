import { Any } from "@ohos/flutter_ohos";

export type StringCallback<T> = (obj: T) => void;

export function SafetyValue<T>(value: T, func: StringCallback<T>, defaultValue?: T) {
  if (value != undefined && value != null) {
    func(value);
  }else if(defaultValue) {
    func(defaultValue);
  }
}

export function GetSafetyValue<T>(args: Any, key:string, defaultValue?: T): T | undefined {
  let ret: T | undefined;
  do {
    if (args instanceof Map) {
      if(args.has(key)) {
        ret = args.get(key) as T;
        break;
      }
    }

    if (IsObj(args)) {
      let keys = Object.keys(args);
      if(keys.includes(key)) {
        ret = args[key] as T;
      }
    }
  } while (false);

  if(ret == undefined) ret = defaultValue;
  return ret;
}


export function IsObj (object: Object): boolean {
  return object && typeof (object) == 'object';
}
