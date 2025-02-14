import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_cloud_app/api/FileApi.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  _FilesPageState createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  List<dynamic> _userDir = [];

  bool get isAnySelected => _userDir.any((e) => e['isSelected'] ?? false);

  int _currentId = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserDir(0);
  }

  _fetchUserDir(int parentId) async {
    try {
      final response = await FileApi.getUserMenuApi(parentId);
      setState(() {
        _userDir.clear();
        _userDir.addAll(response.data);
        // for (var item in response.data) {
        //   _userDir.add(item as Map);
        // }
      });
    } catch (e) {
      //提示，获取目录失败
    }
  }

  // 页面初始化之后获取数据
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
                          return {'修改时间', '创建时间', '文件大小', '名称'}
                              .map((String choice) {
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
                      const Spacer(), // 占据中间的空白空间

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
                  child: ListView.builder(
                    itemCount: _userDir.length,
                    itemBuilder: (BuildContext context, int index) {
                      var e = _userDir[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FolderTile(e['name'], e['updateTime']),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  e['isSelected'] = !(e['isSelected'] ?? false);
                                });
                              },
                              child: IconButton(
                                icon: Icon(
                                  e['isSelected'] ?? false
                                      ? Icons.check_circle // 选中时显示勾选圆圈图标
                                      : Icons.radio_button_unchecked,
                                  // 未选中时显示未勾选圆圈图标
                                  size: 24, // 设置图标大小
                                  color: e['isSelected'] ?? false
                                      ? Colors.green
                                      : Colors.grey, // 根据选中状态改变颜色
                                ),
                                onPressed: () {
                                  setState(() {
                                    e['isSelected'] =
                                        !(e['isSelected'] ?? false); // 切换选中状态
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            if (isAnySelected)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.download),
                        onPressed: () {
                          // 下载操作
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          // 分享操作
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // 删除操作
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // 重命名操作
                        },
                      ),
                    ],
                  ),
                ),
              ),
            if (!isAnySelected)
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    // 实现上传文件功能
                    //弹出上传文件抽屉，选择类型
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      elevation: 10,
                      isDismissible: true,
                      // 点击外部区域关闭弹窗
                      enableDrag: true,
                      // 启用拖动关闭
                      builder: (context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            color: Colors.white,
                          ),
                          height: 200, // 设置弹窗高度
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // 设置弹窗的标题
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  '上传到云盘',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              // 选择文件、图片和视频、新建文件夹按钮
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // 选择文件按钮
                                  GestureDetector(
                                    onTap: () {
                                      // 实现选择文件功能
                                      print("选择文件");
                                    },
                                    child: Column(
                                      children: [
                                        Icon(Icons.upload_file,
                                            color: Colors.blue, size: 40),
                                        SizedBox(height: 8),
                                        Text('选择文件',
                                            style:
                                                TextStyle(color: Colors.blue)),
                                      ],
                                    ),
                                  ),
                                  // 选择图片和视频按钮
                                  GestureDetector(
                                    onTap: () {
                                      // 实现选择图片或视频功能
                                      print("选择图片/视频");
                                    },
                                    child: Column(
                                      children: [
                                        Icon(Icons.image,
                                            color: Colors.green, size: 40),
                                        SizedBox(height: 8),
                                        Text('图片/视频',
                                            style:
                                                TextStyle(color: Colors.green)),
                                      ],
                                    ),
                                  ),
                                  // 新建文件夹按钮
                                  GestureDetector(
                                    onTap: () {
                                      // 实现新建文件夹功能
                                      //_currentId
                                      //弹出对话框 ，标题就是新建文件夹，然后输入文件夹名称，然后把抽屉关闭，键盘自动弹出，焦点在输入框
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          TextEditingController
                                              _folderNameController =
                                              TextEditingController();
                                          return AlertDialog(
                                            title: Text('新建文件夹'),
                                            content: TextField(
                                              controller: _folderNameController,
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                  hintText: '请输入文件夹名称'),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  // 关闭对话框
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('取消'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  // 实现新建文件夹功能
                                                  String folderName =
                                                      _folderNameController
                                                          .text;
                                                  if (folderName.isNotEmpty) {
                                                    // 调用API创建文件夹
                                                    final response =
                                                        await FileApi
                                                            .createFolderApi(
                                                                folderName,
                                                                _currentId);
                                                    // 关闭对话框
                                                    Get.back();
                                                  } else {
                                                    // 提示用户输入文件夹名称
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                '请输入文件夹名称')));
                                                  }
                                                },
                                                child: Text('确定'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Icon(Icons.folder,
                                            color: Colors.purple, size: 40),
                                        SizedBox(height: 8),
                                        Text('新建文件夹',
                                            style: TextStyle(
                                                color: Colors.purple)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              // 分隔线
                              Divider(),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
          ],
        ));
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
