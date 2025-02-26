import { Any } from "@ohos/flutter_ohos";

export type StringCallback<T> = (obj: T) => void;

export function SafetyValue<T>(value: T, func: StringCallback<T>, defaultValue?: T) {
  if (value) {
    func(value);
  }else if(defaultValue) {
    func(defaultValue);
  }
}

export function GetSafetyValue<T>(map: Map<string, Object>, key:string, defaultValue?: T): T | undefined {
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
