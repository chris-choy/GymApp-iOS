
<div align="center" >
 <img src="https://user-images.githubusercontent.com/23289235/150794034-37a77fec-0a5d-4289-8d14-e844bccf465e.png" alt="logo" style="max-height:150px;"/>
</div>

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)

## 1.背景介绍
此项目是基于UIKit和CoreData编写的一款在iOS上的运动记录App，该App在于提供用户创建运动的计划，记录运动的数据以及分析运动数据。

## 2. 软件功能
### 2.1 运动计划管理
* 每个运动计划包含多组运动项目。
* 每个运动项目支持自定义运动数值，例如哑铃每组5次、跑步每组5分钟、俯卧撑每组10个等等。
* 自定义每组休息时间。

### 2.2 运动项目管理
* 支持自定义运动名称。
* 支持自定义运动的单位，kg、lb、分钟、秒钟等等。

### 2.3 记录运动数据
* 记录每次完成整个运动计划的运动时间。
* 记录每组运动的实际数值，允许和计划数值不相同。
* 记录每组的休息时间，运动过程中可产生一定的督促作用。

## 3. 软件截图

<div align="center">
  <img src="https://user-images.githubusercontent.com/23289235/155956311-12690ce2-ccf8-4135-8a13-123b20cba738.png" alt="viper" />
</div>



## 4. VIPER架构介绍

VIPER是一个由MVC开始逐渐发展衍生出来的一种架构。

MVC的话相对容易理解，结构简单明了，但是在复杂的项目中，往往各个部件之间的代码量会比较大，容易出现代码复杂、可读性差的问题。

VIPER在MVC的情况下，将Controller细分到Interactor中负责和Entity打交道，增加Router在不同模块之间切换，Presenter则充当一个指挥者负责将View组件的响应操作分配给不一样的组件进行处理。这样细分后的好处是代码结构更加清晰了，在代码分散开，不会在功能多的情况下，很多代码都集中在MVC中的Controller里面。

不过这样的代价就是会增加很多接口的代码，比较多看似多余的代码，但是在查找问题的时候根据接口定位又会相对方便点。
<div align="center">
  <img src="https://user-images.githubusercontent.com/23289235/154660041-08958bf1-31af-43b8-bf42-e18635ea427e.png" height = "300" alt="viper" />
</div>

参考引用

https://www.alfianlosari.com/posts/building-todo-list-ios-app-with-viper-architecture/




## 5.测试环境
XCode 13.2.1 (13C100)

## 6.运行环境配置
配置服务器的ip和端口号，文件路径如下：

    ~/GymApp/Config/ConfigConstant
设置serverAdderss，格式参照下面：

    serverAdderss = "http://127.0.0.1:8080"
配置好后运行即可。

## 7.问题反馈
1. 欢迎提交issue。
2. Email: ct.choi@outlook.com
