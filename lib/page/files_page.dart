import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilesPage extends StatelessWidget {
  const FilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('分类'),
        actions: [
          // 点击搜索图标时，弹出搜索框
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/folder_transmission.svg',
              width: 24, // 可选：设置宽度
              height: 24, // 可选：设置高度
            ),
            onPressed: () {
              // 可以弹出搜索框或其他搜索功能
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // 搜索框
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '支持文档全文、图中文字搜索啦',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (text) {
                    // 实现搜索逻辑
                  },
                ),
              ),

              // 智能排序按钮和筛选图标、视图样式图标在同一行
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    // 智能排序按钮，点���后显示下拉菜单
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        // 根据选项做排序功能
                      },
                      itemBuilder: (BuildContext context) {
                        return {'修改时间', '创建时间', '文件大小', '名称'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              '智能排序',
                              style: TextStyle(fontSize: 12), // 修改字体大小
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    Spacer(), // 占据中间的空白空间

                    // 筛选图标
                    IconButton(
                      icon: const Icon(Icons.filter_alt),
                      onPressed: () {
                        // 实现筛选功能
                      },
                    ),

                    // 视图样式图标
                    IconButton(
                      icon: const Icon(Icons.view_module),
                      onPressed: () {
                        // 实现视图样式切换功能
                      },
                    ),
                  ],
                ),
              ),
              // 文件列表
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(10.0),
                  children: const [
                    FolderTile('我的卡包', '2024-11-27 21:08'),
                    FolderTile('隐藏空间', '2024-11-27 21:08'),
                    FolderTile('计算机软件', '2024-11-27 21:08'),
                    FolderTile('公务员', '2024-01-15 13:19'),
                    FolderTile('游戏', '2024-01-14 12:44'),
                    FolderTile('花生', '2023-09-02 21:50'),
                    FolderTile('我的资源', '2023-07-28 23:26'),
                    FolderTile('学习', '2023-01-06 16:52'),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                // 实现上传文件功能
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      )
    );
  }
}

class FolderTile extends StatelessWidget {
  final String title;
  final String date;

  const FolderTile(this.title, this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        'assets/icons/folder_icon.svg',
        width: 24, // 可选：设置宽度
        height: 24, // 可选：设置高度
      ),
      title: Text(title),
      subtitle: Text(date),
      onTap: () {
        // 文件夹点击操作
      },
    );
  }
}
