# 如何向本仓库贡献你的文章

<!--你有两种方式向[本仓库](https://github.com/CSTGit/CST-Live-Guide)发起贡献，我个人称为 _在线_ 的和 _离线_ 的方式。-->

我们欢迎任何建设性的贡献。小到修正标点符号、错别字，大到写下一小篇文章甚至一整章，只要是帮助建设本仓库的，我们都非常欢迎。

<!-- 本文章假定读者有基础的计算机使用能力但是对 Git 完全不了解。如果你对 Git 和 GitHub 比较了解的话，可以直接跳转到[仓库路径约定](#project_directory_mapping)小节。

## <a name="create_github_account"></a>创建 GitHub 帐号

这一步非常简单。[GitHub 的主页](https://github.com)右边就是一个注册框。填写那个注册框，验证一下邮箱，你就拥有一个 GitHub 帐号以用来发起贡献了。

## <a name="fork_this_repository"></a>Fork 本仓库

_如果你只是想做一点小小的贡献例如修正错别字的话，这一步可以忽略，具体请看下边的[在线编辑](#edit_online)。_

打开[本仓库的主页](https://github.com/CSTGit/CST-Live-Guide)，你可以在页面右上角看到一个按钮 <kbd>Fork</kbd>。单击它，你将会得到这个仓库的一个 **fork**。

这里的术语 ["fork"](https://git-scm.com/book/zh/v2/GitHub-%E5%AF%B9%E9%A1%B9%E7%9B%AE%E5%81%9A%E5%87%BA%E8%B4%A1%E7%8C%AE) 指的是 _当前_ 的仓库的一份复制。这就有点像它的原文意思“叉子”一样，它在某点开始分叉，然后各个分叉一起毫不干涉地向上跑。

当你拥有一个仓库的 fork 之后，你就有了本仓库的一个你可以自由修改的版本。你现在可以在别人的基础上开始进行自己的开发，当你需要的时候还可以向原来的作者请求接受你的开发。

## <a name="edit_online"></a>在线编辑

_你可以选择在线编辑，也可以选择下边会说到的离线编辑。个人建议是，当你只是想做一点小修改的时候，在线编辑比离线编辑方便很多；但是如果你想做个大修改例如写一整篇之类，那还是离线编辑比较好。_

[找到](#project_directory_mapping)你要修改的那个文件，点击主框体右上角的铅笔 :pencil: 按钮，你将来到在线编辑的界面。

当你没有本仓库的 fork 的时候，在你提交更改时 GitHub 将会自动给你创建一个 fork，这就是上一步提到的“可以忽略”的原因。

做完修改之后，你必须填写这一次提交的信息（_commit message_, 这是 Git 的要求）。这个信息没有任何要求限制，但是一般来说有个建议就是“简明扼要地描述你做了什么”。你还可以选择要不要填写附加信息，这个不是必须的。

填写完提交信息之后，你就可以点击绿色按钮以确认（对你的 fork 的）更改。然后请跳到[发起合并请求](#create_pull_request)。

## <a name="edit_offline"></a>离线编辑

在进行离线编辑之前，你首先得在你自己的设备上有相关的工具。一个是用于 Git 或者 GitHub 相关操作的工具，一个是“好用”的编辑器。

### <a name="install_git"></a>安装 Git

_你也可以安装 GitHub Desktop。_

#### Windows

在[Git 的](https://git-scm.com/)右边就有 Git 的安装包下载。安装时建议勾选 `Windows Explorer integration`，同时在 `line ending conversions` 界面（三选一）上建议选择第一个 `Checkout Windows-style, commit Unix-style line endings`，其余基本可以使用默认选项。

安装完成后，打开 Git Bash，输入以下信息以配置全局提交信息。

    git config --global user.name <name>
    git config --global user.email <email> 

将 `<name>` 替换为你的 GitHub 账户名，将 `<email>` 替换为你的 GitHub 注册邮箱。（其实这个 name 和 email 的内容是可以任意填的，但是填成这个方便一些。）

#### Linux

你不应该看到这里的。

#### Mac

**待补充。**~~（穷）~~

#### Android

可以试试使用 [Pocket Git](http://pocketgit.com/)。~~什么？你说你没法下载？~~

### <a name="install_github_desktop"></a>安装 GitHub Desktop

如果你只是想做关于 GitHub 的工作，可以直接安装 [GitHub Desktop](https://desktop.github.com/)。然后使用你的 GitHub 账号登录。

### <a name="what_is_git"></a>Git 是什么

## <a name="create_pull_request"></a>发起合并请求（_Pull Request_）

你说我为什么要注释掉这一段呢？

-->

本文章假定用户有[一定的 Git 使用基础](https://git-scm.com/book/zh/v2/)（例如，知道 Git 和 GitHub 的区别），同时至少能使用 Markdown 或者 L<sup>A</sup>T<sub>E</sub>X。

## <a name="project_directory_mapping"></a>仓库路径约定

本项目其实是用 pdfLaTeX 构建的，Markdown 被拿来通过 Pandoc 转化为 LaTeX 并添加入最终的预构建文档。为了防止过多的冲突，我目前使用这样的约定：

章（Chapter）为一个大的模块 / 领域，包括了若干个节（Section），每节都是一篇完整的对该领域一个小方向 / 知识点的描述 / 说明 / 讲解。

每一章为一个文件夹，文件夹以该章主题命名，空格分词，每单词首字母大写。每一节为一个文件，文件以该节主题命名，不分词，大驼峰式命名。

在最终的文档中添加相关章节的方式为，修改仓库根目录下的 `build.sh` 文件夹，在底部的 `Write book` 段落中按照顺序添加对应的文章。

- 如果是 L<sup>A</sup>T<sub>E</sub>X 的话，添加的形式为：

      includetex "<Chapter Name>/" SectionName

  例如：

      includetex "Basic Math/" ChapterIntro

- 如果是 Markdown 的话，添加的形式为：

      includemd "<Chapter Name>/" SectionName

  例如：

      includemd "Deep Learning/" Classification


`<Chapter Name>` 被用来查找文件夹，`SectionName` 则直接指向文件（注意不需要带扩展名）。

建议每一章都以一个 L<sup>A</sup>T<sub>E</sub>X 格式的 `ChapterIntro` 开头，在其中使用 `\chapter{}` 命令。（Markdown 的 Pandoc 自动转换好像没法做到这个）。

最后不要忘了在根目录下的 `cover.tex` 的 `\author{}` 命令和 `README.md` 的底部添加尊姓大名~ 

**待补充。**
