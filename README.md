# git-flowTest
git-flow-work
##<center>git-flow 工作流程</center>
###1.git-flow 说明
一旦安装安装 git-flow，你将会拥有一些扩展命令。这些命令会在一个预定义的顺序下自动执行多个操作。
#######
git-flow 并不是要替代 Git，它仅仅是非常聪明有效地把标准的 Git 命令用脚本组合了起来。
####git-flow把分支划分了几个类别

#####Master

就是平时我们看到的master，项目的主要分支，可以把它理解成  稳定无bug发布版 。（任何时候都ready to deploy）
所以，git-flow 要求我们不能在master下做开发。

#####Develop

处于功能开发最前线的版本，查看develop分支就能知道下一个发布版有哪些功能了。
develop一开始是从master里分出来的，并且定期会合并到master里，
每一次合并到master，表示我们完成了一个阶段的开发，产生一个稳定版。
同样的，develop下也不建议直接开发代码，develop代表的是已经开发好的功能

#####Feature


feature的作用是为每一个新功能从develop里创建出来的一个分支。
例如A和B分别做两个功能，一个为人脸识别，一个为绑卡界面。就可以创建两个分支，各自开发完以后，先后合并到develop里，这就叫做回归。
在这个过程里，A 和 B不需要任何的沟通，分别并行地开发，
git-flow能很好的处理好分支间并行开发的关系。
而develop，则会在适当的时候，由合适的人，合并到master，作为下一个稳定版本。

#####Hotfix

以上3种以外，还有一个很重要的类型，hotfix。
它是用来修复紧急bug的，而bug通常是来自线上的，
所以hotfix分支是从master里创建出来的，并且，在bug修改好以后，
要同时合并到master和develop，这一点需要特别注意。

#####Release
release更多倾向与版本发布，项目上线前的一些全面测试以及上线准备。
同样也肩负着版本归档，回滚支持等

![git-flow 流程图](/Users/Yan/Desktop/图片/git-flow 流程图.png)

###2.git-flow 安装
####1.Mac下安装
通过 homebrew 安装

在终端执行``brew install git-flow-avh```![homebrew 安装 gitflow](/Users/Yan/Desktop/图片/homebrew 安装 gitflow.png)

####2.windows下安装
``wget -q -O - --no-check-certificate https://raw.github.com/petervanderdoes/gitflow-avh/develop/contrib/gitflow-installer.sh install stable | bash``
安装 git-flow, 你需要 wget 和 util-linux。PS:我没有 windows，也没实践过。

####3.开始使用
#####初始化
使用 git-flow，从初始化一个现有的 git 库内开始:

``git flow init``

你必须回答几个关于分支的命名约定的问题。
建议使用默认值。![终端使用 git-flow](/Users/Yan/Desktop/图片/终端使用 git-flow.png)





#####增加新功能
新功能的开发是基于 'develop' 分支的。

通过下面的命令开始开发新功能 比如人脸识别功能：

``git flow feature start MYFEATURE``

这个操作创建了一个基于'develop'的特性分支，并切换到这个分支之下。

完成开发新功能。这个动作执行下面的操作.

合并 MYFEATURE 分支到 'develop'
删除这个新特性分支
切换回 'develop' 分支

``git flow feature finish MYFEATURE``
最重要的是，这个 “feature finish” 命令会把我们的工作整合到主 “develop” 分支中去。在这里它需要等待：

一个在更广泛的 “开发” 背景下的全面测试。
稍后和所有积攒在 “develop” 分支中的其它功能一起进行发布。
之后，git-flow 也会进行清理操作。它会删除这个当下已经完成的功能分支，并且换到 “develop” 分支。

#### ![完成提交之后](/Users/Yan/Desktop/图片/完成提交之后.png)发布新特性
合作开发一项新功能
可以发布新功能分支到远程服务器，这样，其它用户也可以使用这分支
``git flow feature publish MYFEATURE``
取得其它用户发布的新特性分支，并签出远程的变更。

``git flow feature pull origin MYFEATURE``

可以使用 ``git flow feature track MYFEATURE`` 跟踪在origin上的特性分支。

#### 发布 release 版本
当你认为现在在 “develop” 分支的代码已经是一个成熟的 release 版本时，这意味着：第一，它包括所有新的功能和必要的修复；第二，它已经被彻底的测试过了。如果上述两点都满足，那就是时候开始生成一个新的 release 了

开始准备release版本，使用 ``git flow release ``命令.

它从 'develop' 分支开始创建一个 release 分支

请注意，release 分支是使用版本号命名的。这是一个明智的选择，这个命名方案还有一个很好的附带功能，那就是当我们完成了release 后，git-flow 会适当地_自动_去标记那些 release 提交。

有了一个 release 分支，再完成针对 release 版本号的最后准备工作（如果项目里的某些文件需要记录版本号），并且进行最后的编辑。![发布 release](/Users/Yan/Desktop/图片/发布 release.png)
完成 release
现在是时候按下那个危险的红色按钮来完成我们的release了：

``git flow release finish 3.6.0``![finish](/Users/Yan/Desktop/图片/finish.png)


这个命令会完成如下一系列的操作：

首先，git-flow 会拉取远程仓库，以确保目前是最新的版本。
然后，release 的内容会被合并到 “master” 和 “develop” 两个分支中去，这样不仅产品代码为最新的版本，而且新的功能分支也将基于最新代码。
为便于识别和做历史参考，release 提交会被标记上这个 release 的名字（在我们的例子里是 “3.6.0”）。
清理操作，版本分支会被删除，并且回到 “develop”。
从 Git 的角度来看，release 版本现在已经完成。依据你的设置，对 “master” 的提交可能已经触发了你所定义的部署流程



####hotfix

很多时候，仅仅在几个小时或几天之后，当对 release 版本作做全面测试时，可能就会发现一些小错误。
在这种情况下，git-flow 提供一个特定的 “hotfix” 工作流程（因为在这里不管使用 “功能” 分支流程，还是 “release” 分支流程都是不恰当的）。

#### 创建 Hotfixes

```
$ git flow hotfix start missing-link
```

![hotfix](/Users/Yan/Desktop/图片/hotfix.png)

这个命令会创建一个名为 “hotfix/missing-link” 的分支。因为这是对产品代码进行修复，所以这个 hotfix 分支是基于 “master” 分支。
这也是和 release 分支最明显的区别，release 分支都是基于 “develop” 分支的。因为你不应该在一个还不完全稳定的开发分支上对产品代码进行地修复。

就像 release 一样，修复这个错误当然也会直接影响到项目的版本号！

#### 完成 Hotfixes

在把我们的修复提交到 hotfix 分支之后，就该去完成它了：

```
$ git flow hotfix finish missing-link
```

![hotfixfinish](/Users/Yan/Desktop/图片/hotfixfinish.png)这个过程非常类似于发布一个 release 版本：

- 完成的改动会被合并到 “master” 中，同样也会合并到 “develop” 分支中，这样就可以确保这个错误不会再次出现在下一个 release 中。
- 这个 hotfix 程序将被标记起来以便于参考。
- 这个 hotfix 分支将被删除，然后切换到 “develop” 分支上去。

还是和产生 release 的流程一样，现在需要编译和部署你的产品（如果这些操作不是自动被触发的话）。

git-flow 并不会为 Git 扩展任何新的功能，它仅仅使用了脚本来捆绑了一系列 Git 命令来完成一些特定的工作流程。



####PS:sourcetree 提供了 git-flow 功能

![image-20180530104132334](/var/folders/qd/y0chqf6d7dn99l7x8rxklnv80000gn/T/abnerworks.Typora/image-20180530104132334.png)

参考链接 http://danielkummer.github.io/git-flow-cheatsheet/index.zh_CN.html
