# Git命令备忘

## Git 配置SSH Key
    
1. 生成ssh ssh-keygen

        $ ssh-keygen -t rsa -C "邮件地址"
        Generating public/private rsa key pair.
        Enter file in which to save the key (/Users/your_user_directory/.ssh/id_rsa):<回车就好>
        Enter passphrase (empty for no passphrase):<输入加密串，建议输入>
        Enter same passphrase again:<再次输入加密串，建议输入>

2. 添加SSH Key到GitHub
    
        复制文件/Users/your_user_directory/.ssh/id_rsa.pub中的内容到GitHub系统Settings-->SSH and GPG keys-->New SSH key, Title自定义。

3. 测试SSH连接GitHub是否成功

    输入以下命令：

        $ssh -T git@github.com

    如果输出为以下：

        $ ssh -T git@github.com
        ssh_exchange_identification: Connection closed by remote host

    可能是防火墙屏蔽了SSH的22端口，使用以下命令测试HTTPS端口是否可用：

        $ ssh -T -p 443 git@ssh.github.com
        Hi username! You've successfully authenticated, but GitHub does not
        provide shell access.

    如果输出出现github Permission denied错误，执行以下命令

        //start the ssh-agent in the background
        $eval "$(ssh-agent -s)"
        $ssh-add ~/.ssh/id_rsa

    编辑SSH配置文件 ~/.ssh/config 如下:

        Host github.com
        Hostname ssh.github.com
        Port 443

    再测试是否成功

        $ ssh -T git@github.com
        Hi username! You've successfully authenticated, but GitHub does not
        provide shell access.

## Git常用配置命令

>git config --global user.name "robbin"  
>git config --global user.email "fankai@gmail.com"  
>git config --global color.ui true  
>git config --global alias.co checkout  
>git config --global alias.ci commit  
>git config --global alias.st status  
>git config --global alias.br branch  
>git config --global core.editor "mate -w"    # 设置Editor使用textmate  
>git config -l  # 列举所有配置  
>用户的git配置文件~/.gitconfig

## Git常用文件操作命令

>git help <command>  # 显示command的help  
>git show            # 显示某次提交的内容  
>git show $id  
>git co  -- <file>   # 抛弃工作区修改  
>git co  .           # 抛弃工作区修改  
>git add <file>      # 将工作文件修改提交到本地暂存区  
>git add .           # 将所有修改过和新增的工作文件提交暂存区,对于删除的文件操作不提交
>git add -u          #  将所有修改过和删除的工作文件提交暂存区，不包括新增
>git add -A          # 所有修改（包括新增和删除）添加到暂存区
>git rm <file>       # 从版本库中删除文件  
>git rm <file> --cached  # 从版本库中删除文件，但不删除文件  
>git reset <file>    # 从暂存区恢复到工作文件  
>git reset -- .      # 从暂存区恢复到工作文件  
>git reset --hard    # 恢复最近一次提交过的状态，即放弃上次提交后的所有本次修改  
>git ci <file>         
>git ci .  
>git ci -a           # 将git add, git rm和git ci等操作都合并在一起做  
>git ci -am "some comments"  
>git ci --amend      # 修改最后一次提交记录  
>git commit --amend  #修改最后一次提交注释的，利用–amend参数    
>git revert <$id>    # 恢复某次提交的状态，恢复动作本身也创建了一次提交对象  
>git revert HEAD     # 恢复最后一次提交的状态  

## Git分支管理命令

>git br -r           # 查看远程分支  
>git br <new_branch> # 创建新的分支  
>git br -v           # 查看各个分支最后提交信息  
>git br --merged     # 查看已经被合并到当前分支的分支  
>git br --no-merged  # 查看尚未被合并到当前分支的分支  
>git co <branch>     # 切换到某个分支  
>git co -b <new_branch> # 创建新的分支，并且切换过去  
>git co -b <new_branch> <branch>  # 基于branch创建新的new_branch  
>git co $id          # 把某次历史提交记录checkout出来，但无分支信息，切换到其他分支会自动删除  
>git co $id -b <new_branch>  # 把某次历史提交记录checkout出来，创建成一个分支  
>git br -d <branch>  # 删除某个分支  
>git br -D <branch>  # 强制删除某个分支 (未被合并的分支被删除的时候需要强制)  

## Git远程仓库管理

>git remote -v                    # 查看远程服务器地址和仓库名称  
>git remote show origin           # 查看远程服务器仓库状态  
>git remote add origin git@github:robbin/robbin_site.git         # 添加远程仓库地址  
>git remote set-url origin git@github.com:robbin/robbin_site.git # 设置远程仓库地址(用于修改远程仓库地址)  
>git remote rm <repository>       # 删除远程仓库  

## Git远程分支管理

>git pull                         # 抓取远程仓库所有分支更新并合并到本地  
>git pull --no-ff                 # 抓取远程仓库所有分支更新并合并到本地，不要快进合并  
>git fetch origin                 # 抓取远程仓库更新  
>git merge origin/master          # 将远程主分支合并到本地当前分支  
>git co --track origin/branch     # 跟踪某个远程分支创建相应的本地分支  
>git co -b <local_branch> origin/<remote_branch>  # 基于远程分支创建本地分支，功能同上  
>git push                         # push所有分支  
>git push origin master           # 将本地主分支推到远程主分支  
>git push -u origin master        # 将本地主分支推到远程(如无远程主分支则创建，用于初始化远程仓库)  
>git push origin <local_branch>   # 创建远程分支， origin是远程仓库名  
>git push origin <local_branch>:<remote_branch>  # 创建远程分支  
>git push origin :<remote_branch>  #先删除本地分支(git br -d <branch>)，然后再push删除远程分支  


### 命令参考或转载地址

[SSH Key配置](http://zuyunfei.com/2013/04/10/setup-github-ssh-key/)  
[Git命令](http://www.jeffjade.com/2014/12/22/2014-12-22-gitmemo/)