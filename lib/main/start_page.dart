import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/genarator/text_input_page.dart';
import 'package:segno/main/file_manager.dart';
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

  void setCurrentFolder(Folder folder) {
    setState(() {
      currentFolder = folder;
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
          json.decode(foldersJson).map((folderJson) =>
              Folder.fromJson(folderJson)));
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
        if (false) {} else {
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
        length: 3,
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
                Tab(
                  text: '그룹',
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
            child: IconButton(
              icon: Image.asset(
                'assets/images/add_color.png', width: 300, height: 300,),
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
        LayoutBuilderWidget(
          currentFolder: currentFolder,
          folders: folders,
          fileItems: fileItems,
          setCurrentFolder: setCurrentFolder,
          saveFoldersToPrefs: saveFoldersToPrefs,
        ),
        Container(
          width: 20.0,
          height: 20.0,
          child: IconButton(
            icon: Image.asset(
              'assets/images/add_color.png', width: 300, height: 300,),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TextInputPage()),
              );
            },
          ),
        ),
      ],
    ),)
    ,
    )
    ,
    );
  }
}

class Folder {
  String name;
  final List<FileItem> files;

  Folder({required this.name, this.files = const []});

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'files': files.map((file) => file.toJson()).toList(),
      };

  factory Folder.fromJson(Map<String, dynamic> json) =>
      Folder(
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
