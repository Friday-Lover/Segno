import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/genarator/text_input_page.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class MainPage extends StatefulWidget {
  final Folder folder;
  MainPage({required this.folder});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late Folder currentFolder;
  List<Folder> folders = [];
  List<FileItem> fileItems = [];

  @override
  void initState() {
    super.initState();
    currentFolder = widget.folder;
    loadFoldersFromPrefs().then((loadedFolders) {
      setState(() {
        folders = loadedFolders;
      });
    });
  }

  @override
  Future<void> saveFoldersToPrefs(List<Folder> folders) async {
    final prefs = await SharedPreferences.getInstance();
    final foldersJson = folders.map((folder) => folder.toJson()).toList();
    await prefs.setString('folders', json.encode(foldersJson));
  }

  Future<List<Folder>> loadFoldersFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final foldersJson = prefs.getString('folders');
    if (foldersJson != null) {
      return List<Folder>.from(
          json.decode(foldersJson).map((folderJson) => Folder.fromJson(folderJson)));
    }
    return [];
  }

  void _addFolder(String folderName) {
    setState(() {
      folders.add(Folder(name: folderName));
    });
    saveFoldersToPrefs(folders);
  }

  void _deleteFolder(Folder folder) {
    setState(() {
      folders.remove(folder);
      fileItems.addAll(folder.files);
    });
    saveFoldersToPrefs(folders);
  }

  void _deleteFile(FileItem file) {
    setState(() {
      currentFolder.files.remove(file);
    });
    saveFoldersToPrefs(folders);
  }

  void _moveFileToFolder(FileItem file, Folder destination) {
    setState(() {
      currentFolder.files.remove(file);
      destination.files.add(file);
    });
    saveFoldersToPrefs(folders);
  }

  void _setCurrentFolder(Folder folder) {
    setState(() {
      currentFolder = folder;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (false) {
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  '앱 종료',
                  style: AppTheme.textTheme.labelLarge,
                ),
                content: Text(
                  '앱을 종료하시겠습니까?',
                  style: AppTheme.textTheme.labelLarge,
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      '예',
                      style: AppTheme.textTheme.labelLarge,
                    ),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      '아니오',
                      style: AppTheme.textTheme.labelLarge,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppBar(
              backgroundColor: AppTheme.mainColor,
              centerTitle: true,
              title: Text(
                'Segno',
                textAlign: TextAlign.center,
                style: AppTheme.textTheme.displaySmall,
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.create_new_folder),
                  onPressed: () async {
                    final folderName = await showDialog<String>(
                      context: context,
                      builder: (context) {
                        String name = '';
                        return AlertDialog(
                          title: Text('폴더 이름 입력'),
                          content: TextField(
                            onChanged: (value) {
                              name = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              child: Text('취소'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text('확인'),
                              onPressed: () {
                                Navigator.pop(context, name);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    if (folderName != null && folderName.isNotEmpty) {
                      _addFolder(folderName);
                    }
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: Theme(
            data: ThemeData(
              tabBarTheme: TabBarTheme(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.amberAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                  color: AppTheme.mainColor,
                ),
              ),
            ),
            child: TabBar(
              tabs: [
                Tab(
                  text: '문제 만들기',
                ),
                Tab(
                  text: '문제 저장소',
                ),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppTheme.mainColor,
              ),
              labelStyle: AppTheme.textTheme.labelLarge,
              unselectedLabelStyle: AppTheme.textTheme.labelLarge,
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(150.0),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TextInputPage()),
                      );
                    },
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: folders.length,
                          itemBuilder: (context, index) {
                            final folder = folders[index];
                            return GestureDetector(
                              onTap: () {
                                _setCurrentFolder(folder);
                              },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('폴더 관리'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text('폴더 삭제'),
                                            onTap: () {
                                              setState(() {
                                                folders.remove(folder);
                                              });
                                              saveFoldersToPrefs(folders);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            title: Text('폴더 이름 변경'),
                                            onTap: () {
                                              Navigator.pop(context);
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String newName = folder.name;
                                                  return AlertDialog(
                                                    title: Text('폴더 이름 변경'),
                                                    content: TextField(
                                                      onChanged: (value) {
                                                        newName = value;
                                                      },
                                                      controller: TextEditingController(text: folder.name),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('취소'),
                                                        onPressed: () => Navigator.pop(context),
                                                      ),
                                                      TextButton(
                                                        child: Text('변경'),
                                                        onPressed: () {
                                                          setState(() {
                                                            folder.name = newName;
                                                          });
                                                          saveFoldersToPrefs(folders);
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder,
                                      size: 48,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      folder.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ReorderableListView.builder(
                          itemCount: currentFolder.files.length,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }
                              final fileItem = fileItems.removeAt(oldIndex);
                              fileItems.insert(newIndex, fileItem);
                            });
                            saveFoldersToPrefs(folders);
                          },
                          itemBuilder: (context, index) {
                            final fileItem = currentFolder.files[index];
                            return Dismissible(
                              key: Key(fileItem.name),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                setState(() {
                                  fileItems.removeAt(index);
                                });
                                saveFoldersToPrefs(folders);
                              },
                              confirmDismiss: (direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('파일 관리'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text('파일 삭제'),
                                            onTap: () {
                                              setState(() {
                                                fileItems.removeAt(index);
                                              });
                                              saveFoldersToPrefs(folders);
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                          ListTile(
                                            title: Text('파일 이름 변경'),
                                            onTap: () {
                                              Navigator.pop(context);
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String newName = fileItem.name;
                                                  return AlertDialog(
                                                    title: Text('파일 이름 변경'),
                                                    content: TextField(
                                                      onChanged: (value) {
                                                        newName = value;
                                                      },
                                                      controller: TextEditingController(text: fileItem.name),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('취소'),
                                                        onPressed: () => Navigator.pop(context),
                                                      ),
                                                      TextButton(
                                                        child: Text('변경'),
                                                        onPressed: () {
                                                          setState(() {
                                                            fileItem.name = newName;
                                                          });
                                                          saveFoldersToPrefs(folders);
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          ListTile(
                                            title: Text('파일을 폴더로 이동'),
                                            onTap: () {
                                              Navigator.pop(context);
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text('파일을 폴더로 이동'),
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text('파일을 이동할 폴더를 선택하세요.'),
                                                        SizedBox(height: 16),
                                                        ...folders.map((folder) {
                                                          return ListTile(
                                                            title: Text(folder.name),
                                                            onTap: () {
                                                              setState(() {
                                                                fileItems.removeAt(index);
                                                                folder.files.add(fileItem);
                                                              });
                                                              saveFoldersToPrefs(folders);
                                                              Navigator.pop(context);
                                                            },
                                                          );
                                                        }).toList(),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: Container(
                                key: Key(fileItem.name),
                                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.insert_drive_file,
                                    color: Colors.blue,
                                  ),
                                  title: Text(
                                    fileItem.name,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onTap: () {
                                    // TODO: 파일 열기 기능 구현
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Folder {
  String name;
  final List<FileItem> files;

  Folder({required this.name, this.files = const []});

  Map<String, dynamic> toJson() => {
    'name': name,
    'files': files.map((file) => file.toJson()).toList(),
  };

  factory Folder.fromJson(Map<String, dynamic> json) => Folder(
    name: json['name'],
    files: List<FileItem>.from(
        json['files'].map((fileJson) => FileItem.fromJson(fileJson))),
  );
}

class FileItem {
  late final String name;

  FileItem({required this.name});

  Map<String, dynamic> toJson() => {'name': name};

  factory FileItem.fromJson(Map<String, dynamic> json) =>
      FileItem(name: json['name']);
}
