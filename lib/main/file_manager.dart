import 'package:flutter/material.dart';
import 'package:segno/main/start_page.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/genarator/text_input_page.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

//분리하기 테스트중 .....

class LayoutBuilderWidget extends StatefulWidget {
  final Folder currentFolder;
  final List<Folder> folders;
  final List<FileItem> fileItems;
  final Function(Folder) setCurrentFolder;
  final Function(List<Folder>) saveFoldersToPrefs;

  LayoutBuilderWidget({
    required this.currentFolder,
    required this.folders,
    required this.fileItems,
    required this.setCurrentFolder,
    required this.saveFoldersToPrefs,
  });

  @override
  _LayoutBuilderWidgetState createState() => _LayoutBuilderWidgetState();
}

class _LayoutBuilderWidgetState extends State<LayoutBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
                itemCount: widget.folders.length,
                itemBuilder: (context, index) {
                  final folder = widget.folders[index];
                  return GestureDetector(
                    onTap: () {
                      widget.setCurrentFolder(folder);
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
                                      widget.folders.remove(folder);
                                    });
                                    widget.saveFoldersToPrefs(widget.folders);
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
                                            controller: TextEditingController(
                                                text: folder.name),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text('취소'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                            TextButton(
                                              child: Text('변경'),
                                              onPressed: () {
                                                setState(() {
                                                  folder.name = newName;
                                                });
                                                widget.saveFoldersToPrefs(
                                                    widget.folders);
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
                itemCount: widget.currentFolder.files.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final fileItem = widget.currentFolder.files.removeAt(oldIndex);
                    widget.currentFolder.files.insert(newIndex, fileItem);
                  });
                  widget.saveFoldersToPrefs(widget.folders);
                },
                itemBuilder: (context, index) {
                  final fileItem = widget.currentFolder.files[index];
                  return Dismissible(
                    key: Key(fileItem.name),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        widget.currentFolder.files.removeAt(index);
                      });
                      widget.saveFoldersToPrefs(widget.folders);
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
                                      widget.currentFolder.files.removeAt(index);
                                    });
                                    widget.saveFoldersToPrefs(widget.folders);
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
                                            controller: TextEditingController(
                                                text: fileItem.name),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text('취소'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                            TextButton(
                                              child: Text('변경'),
                                              onPressed: () {
                                                setState(() {
                                                  fileItem.name = newName;
                                                });
                                                widget.saveFoldersToPrefs(
                                                    widget.folders);
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
                                              ...widget.folders.map((folder) {
                                                return ListTile(
                                                  title: Text(folder.name),
                                                  onTap: () {
                                                    setState(() {
                                                      widget.currentFolder.files
                                                          .removeAt(index);
                                                      folder.files.add(fileItem);
                                                    });
                                                    widget.saveFoldersToPrefs(
                                                        widget.folders);
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
    );
  }
}