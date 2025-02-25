import { Any } from "@ohos/flutter_ohos";

export type StringCallback = (obj: Object) => void;

export function SafetyValue(value: Object, func: StringCallback) {
  if (value !== null) {
    func(value);
  }
}

export function GetSafetyValue<T>(map: Map<string, Any>, key:string, defaultValue?: T): T | undefined {
  if(map.has(key))
  {
    return map.get(key) as T;
  }
  else if (defaultValue != null)
  {
    return defaultValue;
  }
  else {
    return undefined;
  }
}
