# 鸿蒙 im_flutter_sdk 快速入门

当前工程支持了`ios`，`android`，`ohos` 三个平台。

[flutter 鸿蒙支持环境搭建](https://gitee.com/harmonycommando_flutter/flutter)

### 向已存在的项目中添加鸿蒙支持

需要先进入到项目中，之后执行命令

```shell
flutter create  --platforms=ohos .
```

如果之前设置了org，此时可能会报org冲突，此时需要在命令中指定 org。

```shell
flutter create  --platforms=ohos . --org="xxx.xxx"
```

其中 `xxx.xxx` 为您 or g的名称。


### 新建支持鸿蒙的项目

```shell
flutter create new_project_name --org="xxx.xxx" --platforms=ios,android,ohos
```

### 添加 im_flutter_sdk

在工程的 `pubspec.yaml` 中添加 sdk 依赖。

```shell
im_flutter_sdk:
    git:
        url: "https://github.com/easemob/im_flutter_sdk_oh.git"
        ref: "main"
```

运行项目时需要先 build hap包。 执行
```shell
flutter build hap --debug
```

### 打包

项目打包执行 `flutter build hap --release`