# Flutter与Anroid/iOS混合开发实战
## 混合开发有哪些应用场景?
1. 作为独立页面进行加入
2. 作为页面的一部分嵌入

## 将Flutter集成到现有的Android/iOS应用中需要如下几个主要步骤:
1. 创建Flutter module
在做混合开发之前我们首先需要创建一个Flutter module.
假如Native项目是这样的: ***/flutter_hybrid/Native项目:

```
cd ***/flutter_hybrid/
flutter create -t module flutter_module
```

上面代码会切换到Native项目的上一级目录,并创建一个flutter_module,它里面包含:
- .android: flutter_module的Android宿主工程
- .ios: flutter_module的iOS宿主工程
- lib: flutter_module的Dart部分的代码
- pubspec.yaml: flutter_module的项目依赖配置文件

*因为宿主工程的存在,当前flutter_module在不添加额外配置的情况下是可以独立运行的,*
*通过安装了Flutter与Dart插件的Android Studio打开这个flutter_module项目,就可以运行.*

2. 为已存在的Android/iOS应用添加Flutter module依赖
打开Android Nativa项目的settings.gradle,添加如下代码:

```
// FlutterHybridAndroid/settings.gradle
include ':app'
// 新增
setBinding(new Binding([gradle: this]))
evaluate(new File(
    settingsDir.parentFile,
    'flutter_module/.android/include_flutter.groovy'
))
```

setBinding与evaluate允许Flutter模块包括它自己在内的任何Flutter插件,在settings.gradle中以类似:
:flutter, :video_player的方式存在.

打开Android Nativa项目的app/build.gradle,添加如下代码:

```
// FlutterHybridAndroid/app/build.gradle
dependencies {
    ...
    implementation project(':flutter')
}
```

3. 在Java/Object-c中调用Flutter module
在Java中调用Flutter模块有两种方式:
- 使用Flutter.createView API的方式

```
View flutterView = Flutter.createView(MainActivity.this, getLifecycle(), "route1");
FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(600, 800);
layoutParams.leftMargin = 100;
layoutParams.topMargin = 200;
addContentView(flutterView, layoutParams);
```

- 使用FlutterFragment的方式

```
FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
ft.replace(R.id.someContainer, Flutter.createFragment("{name:'thunderHou',dataList:['aa','bb','cc']}"));
ft.commit();
```              

**Flutter要求minSdkVersion最低为16,且使用jdk1.8编译,所以Android Nativa项目的app/build.gradle需要进行修改**

4. 编写Dart代码

```
import 'dart:ui'; // 要使用window对象必须引入

// 拿到从Android Native项目中传入的json类型的数据后,序列化成Dart obj,就可以做任何事情了
void main() => runApp(MyApp(initParams: window.defaultRouteName));
```

5. 运行项目
在Android Studio中运行Native项目,调用Dart代码.

6. 热重启/重新加载
混合开发中在Android项目中集成了Flutter项目后,启用Flutter的热重启/重新加载的功能:
- 打开一个模拟器,或连接一个Android设备到电脑上
- 关闭模拟器或设备上正在运行的APP,然后切换到flutter_module下运行'flutter attach'

注意如果有多个模拟器或设备,需要 flutter attach -d+设备id 来指定一个设备:

`flutter attach -d 'emulator-5554'`

连接成功后,在手机或Native项目中重新启动APP,就可以通过终端提示来进行热加载/热重启了,在终端输入:
- r: 热加载
- R: 热重启
- h: 获取帮助
- d: 断开连接

7. 调试Dart代码
混合开发模式下高效调试Dart代码的方式:
- 关闭模拟器或设备上正在运行的APP(这步很关键)
- 在flutter_module项目中,点击Android Studio的Flutter Attach按钮(或执行命令'flutter attach -d 设备id')
- 在手机或Native项目中重新启动APP

接下来就可以像调试普通Flutter项目一样来调试混合开发模式下的Dart代码了.
**注意多个设备连接的情况.**

8. 发布应用
打包过程和原生一样,在配置签名之后,运行'./gradlew assembleRelease'打包.

