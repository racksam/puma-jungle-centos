该脚本是针对[puma-jungle]()和[niwo/puma](https://gist.github.com/niwo/4526179)两个脚本的综合、以及根据我的经验做出的整理。主要目的是简化CentOS下nginx+puma组合的启动配置。

该脚本在CentOS 6.5(64 bit) + rbenv(v1.0.0) + Ruby(v2.3.1) + Puma(v3.4) + Nginx(1.0.15)下验证通过。

*注：该脚本并非是运行puma项目必须要设置的。用户完全可以针对单个puma项目自行编写一个Linux服务启动脚本*


======
Installation
------------
1. 将脚本clone到CentOS本地用户目录下，例如deploy用户目录：
  ```
  $ cd /home/deploy
  $ git clone https://github.com/racksam/puma-jungle-centos.git
  ``` 
2. 将脚本分别复制到CentOS下相应目录
  ```
  $ cd puma-jungle-centos
  $ sudo cp ./usr/local/bin/run-puma /usr/local/bin/
  $ sudo cp ./etc/init.d/puma /etc/init.d/
  $ sudo cp ./etc/puma-manager.conf /etc/
  ```
3. 创建一个项目配置新文件
  ```
  $ sudo touch /etc/puma.conf
  ```
4. 将puma启动参数配置文件（puma.rb）复制到自己的ruby项目config目录下，例如：
  ```
  $ cp demo_app/config/puma.rb /home/deploy/my_app/config/
  ```
5. 查看jungle的命令参数说明。根据说明使用命令参数`add`增加自己的puma项目
  ```
  # 查看说明：
  $ sudo /etc/init.d/puma

  # 增加新项目，例如my_app
  $ sudo /etc/init.d/puma add /home/deploy/my_app deploy /home/deploy/my_app/config/puma.rb /home/deploy/my_app/log/puma.log
  ```
6. 设置ngnix网站配置文件，将样例中的配置修改成my_app的实际目录
  ```
  $ sudo cp ./etc/nginx/conf.d/demo_site.conf /etc/nginx/conf.d/my_app.conf
  $ sudo vi /etc/nginx/conf.d/my_app.conf
  ```
7. *建议将nginx的运行用户改成和puma的运行用户相同*
  修改`/etc/nginx/nginx.conf`文件，例如将user修改成`deploy`
8. 将puma及ngnix设置成自动启动
  ```
  $ sudo chkconfig nginx on
  $ sudo chkconfig puma on
  ```
9. 手动启动puma及ngnix的命令
  ```
  $ sudo service nginx start
  $ sudo service puma start
  ```
10. 如果需要增加其他的puma项目，请重复5步以后的操作。



