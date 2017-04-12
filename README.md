# Swift Package Manager 入门
Swift Package Manager是一个Swift代码的包管理工具。它集成于Swift的编译系统用来自动下载、编译、和链接依赖库。

该包管理工具包含在Swift 3.0及以上系统中。
##概述
本次分享主要介绍Swift Package Manager(以下简称SPM)的基本概念与功能。
##模块
Swift将代码组织成*模块*，每个模块指定一个命名空间，并强制控制该模块中的哪些代码可以在模块之外使用。

一个应用程序可以将所有的代码写在单个模块里，也可以将其他模块导入作为依赖。除了部分系统提供的模块，例如macOS上的Darwin或Linux上的Glibc，大多数的依赖库都需要下载和编译才能使用。

当您使用单独模块的代码解决特定问题，而这部分代码又可以在其他情况下复用的时候。例如，提供网络请求功能的模块可以在照片共享应用程序和天气应用程序之间共享。使用模块可以让您建立在其他开发人员的代码之上，而不是自己重新实现相同的功能。
##包
一个*包*是由多个Swift源文件和一个列表文件组成。这个列表文件叫做`Package.Swift`，使用`PackageDescription`模块来定义包的名称和内容。

一个包会有一个或者多个Target。每个Target指定一个产品，并且可以声明一个或多个Target之间的依赖关系。
##产品
一个Target可以编译成一个库或者一个可执行文件作为它的产品。一个*库*包含可以被其他Swift代码导入的模块。一个*可执行文件*是一个可以被操作系统运行的程序。
##依赖
一个Target的依赖是包中代码所需要的模块。一个依赖是由包源的相对或绝对URL以及其可以使用的版本组成。Package Manager所担任的角色就是通过自动下载、编译所有项目中的依赖库来降低依赖之间的协调成本。这是一个递归的过程：一个依赖还可以有它自己的依赖，每个依赖都是这样，最后形成一个依赖图。Package Manager就会自动下载、编译满足整个依赖图所需要的一切。
##安装Swift
使用Swift的第一步就是下载并安装编译器和其他必要的组件。可以在官方[下载](https://swift.org/download/)页面，选择相应平台并按说明操作。

为了进行下面的示例，需要确保将Swift添加到你的`$PATH`环境变量中。
###在macOS上
macOS上默认的可下载工具链是在`/Library/Developer/Toolchains`，可以执行下面的命令让终端使用这些工具：
>\$ export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:"${PATH}"

###在Linux上
首先，安装clang：
> \$ sudo apt-get install clang

如果你将Swift工具链安装到了系统根目录以外的其他目录，则需要执行如下命令来使用Swift安装的实际路径：
> \$ export PATH=/path/to/Swift/usr/bin:"${PATH}"

你可以使用`Swift --version`命令来验证你是否正在运行预期的Swift版本：
> \$ swift --version
> Apple Swift version 3.1 (swiftlang-802.0.48 clang-802.0.38)
> Target: x86_64-apple-macosx10.9

##使用REPL
如果你执行`swift`命令，不带任何参数的话，那么你将启动REPL，这是一个将会读取、评估和打印你输入的所有Swift代码结果的交互式的shell。
> \$ swift
> Welcome to Apple Swift version 3.1 (swiftlang-802.0.48 clang-802.0.48). Type :help for assistance.
> 　　1>

与REPL进行交互是对Swift进行实验的好方法。例如，如果你输入表达式`1 + 2`，表达式的结果`3`将打印在下一行：
> 　1> 1 + 2
> $R0: Int = 3

你可以为常量和变量分配值，然后再使用。例如，一个`String`类型的值`Hello, world!`可以赋值给常量`greeting`，然后作为参数传递给`print(_:)`函数：
> 　2> let greeting = "Hello, world!"
> greeting: String = "Hello, world!"
> 　3> print(greeting)
> Hello, world!

如果你输入一个无效的表达式，REPL将打印一个错误并显示出现问题的位置：
> 　4> let answer = "forty"-"two"
> error: repl.swift:4:21: error: binary operator '-' cannot be applied to two 'String' operands
> let answer = "forty"-"two"
> 　　　　　 ~~~~~~~^~~~~~
> repl.swift:4:21: note: overloads for '-' exist with these partially matching parameter lists: (UInt8, UInt8), (Int8, Int8), (UInt16, UInt16), (Int16, Int16), (UInt32, UInt32), (Int32, Int32), (UInt64, UInt64), (Int64, Int64), (UInt, UInt), (Int, Int), (Float, Float), (Double, Double), (Float80, Float80), (T, T.Stride), (T, T._DisallowMixedSignArithmetic), (UnsafeMutablePointer<Pointee>, Int), (UnsafeMutablePointer<Pointee>, UnsafeMutablePointer<Pointee>), (UnsafePointer<Pointee>, Int), (UnsafePointer<Pointee>, UnsafePointer<Pointee>)
> let answer = "forty"-"two"
> 　　　　　　 　　^

REPL的另一个有用的功能是它可以自动补全在特定上下文中使用的功能和方法。例如，如果你在一个`String`值后面输入`.re`，然后按下`Tab`键，REPL将会提供一个可用的补全列表比如`remove(at:)`和`replaceSubrange(bounds:with:)`：
> 　5> "Hi!".re
> Available completions:
> 　　　remove(at: String.Index) -> Character
> 　　　removeAll() -> Void
> 　　　removeAll(keepingCapacity: Bool) -> Void
> 　　　removeSubrange(bounds: ClosedRange<String.Index>) -> Void
> 　　　removeSubrange(bounds: Range<String.Index>) -> Void
> 　　　replaceSubrange(bounds: ClosedRange<String.Index>, with: Collection) -> Void
> 　　　replaceSubrange(bounds: ClosedRange<String.Index>, with: String) -> Void
> 　　　replaceSubrange(bounds: Range<String.Index>, with: Collection) -> Void
> 　　　replaceSubrange(bounds: Range<String.Index>, with: String) -> Void
> 　　　reserveCapacity(n: Int) -> Void

如果你启动一个代码块，例如使用`for-in`遍历一个数组，REPL将会自动缩进下一行，并且将提示符从`>`改为`.`以指示该行输入的代码属于代码块内。
> 　6> let numbers = [1,2,3]
> numbers: [Int] = 3 values {
> 　　[0] = 1
> 　　[1] = 2
> 　　[2] = 3
> }
> 　7> for n in numbers.reversed() {
> 　８.　　　　print(n)
> 　９. }
> ３
> ２
> １

Swift的所有功能都可以从REPL获得，从编写控制流程语句到声明、实例化结构体和类。

还可以导入任何可用的系统模块，例如macOS上的Darwin和Linux上的Glibc：
###在macOS上
> 1> import Darwin
> 2> arc4random_uniform(10)
> $R0: UInt32 = 8

###在Linux上
> 1> import Glibc
> 2> random() % 10
> $R0: Int32 = 6

##使用Package Manager



