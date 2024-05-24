import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:segno/answer/answer_main.dart';
import 'package:segno/quiz/quiz_info.dart';
import 'package:get_it/get_it.dart';
import '../db/file_db.dart';
import '../style/style.dart';

final getIt = GetIt.instance;
final isar = getIt.get<Isar>();

class LayoutBuilderWidget extends StatefulWidget {
  const LayoutBuilderWidget({super.key});

  @override
  State<LayoutBuilderWidget> createState() => _LayoutBuilderWidgetState();

  static _LayoutBuilderWidgetState? of(BuildContext context) {
    return context.findAncestorStateOfType<_LayoutBuilderWidgetState>();
  }
}

//나중에 제거 예정
class Question {
  final String question;
  final List<String> choices;
  final int answer;
  final String comment;

  Question(this.question, this.choices, this.answer, this.comment);
}

//for testing

List<Question> questions = [
  Question('문제 1 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 1, "해설 ㅁㅁㅁㅁ"),
  Question('문제 2!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 2, "해설 ㅁㅁㅁㅁ"),
  Question('문제 3 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 3, "해설 ㅁㅁㅁㅁ"),
  Question('문제 4!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 4, "해설 ㅁㅁㅁㅁ"),
  Question('문제 5 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 5, "해설 ㅁㅁㅁㅁ"),
  Question('문제 6!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 2, "해설 ㅁㅁㅁㅁ"),
  Question('문제 7 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 3, "해설 ㅁㅁㅁㅁ"),
  Question('문제 8!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 3, "해설 ㅁㅁㅁㅁ"),
  Question('문제 9 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 1, "해설 ㅁㅁㅁㅁ"),
  Question('문제 10!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 2, "해설 ㅁㅁㅁㅁ"),
  Question('문제 11 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 3, "해설 ㅁㅁㅁㅁ"),
  Question('문제 12!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
      ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 3, "해설 ㅁㅁㅁㅁ"),
];
List<int> userAnswers = [1, 2, 3, 4, 5, 1, 1, 1, 1, 1, 1, 1];

class _LayoutBuilderWidgetState extends State<LayoutBuilderWidget> {
  List<Folder> folders = [];
  List<ExamFile> examFiles = [];
  Folder? currentFolder;

  @override
  void initState() {
    currentFolder = Folder(folderName: "root", path: '/');
    loadFolders();
    loadExamFiles();
    super.initState();
  }

  Future<void> loadExamFiles() async {
    examFiles =
        await isar.examFiles.filter().pathEqualTo('/').findAll(); // ExamFile 로드
    setState(() {});
  }

  Future<void> loadFolders() async {
    if (currentFolder!.path == '/') {
      folders = await isar.folders.filter().pathEqualTo('/').findAll();
      examFiles = await isar.examFiles.filter().pathEqualTo('/').findAll();
    } else {
      folders = await isar.folders
          .filter()
          .pathEqualTo('${currentFolder!.path}/')
          .findAll();
      examFiles = await isar.examFiles
          .filter()
          .pathEqualTo('${currentFolder!.path}/')
          .findAll();
    }
    setState(() {});
  }

  Future<void> createFolder(String folderName) async {
    // 폴더 이름 중복 확인
    final existingFolder = await isar.folders
        .filter()
        .folderNameEqualTo(folderName)
        .and()
        .pathEqualTo(currentFolder!.path)
        .findFirst();

    if (existingFolder != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이미 존재하는 폴더 이름입니다.')),
      );
      return;
    }

    final Folder newFolder;
    if (currentFolder!.path == '/') {
      newFolder = Folder(
        folderName: folderName,
        path: '/',
      );
    } else {
      newFolder = Folder(
        folderName: folderName,
        path: '${currentFolder!.path}/',
      );
    }
    await isar.writeTxn(() async {
      await isar.folders.put(newFolder);
    });
    await loadFolders();
    setState(() {});
  }

  void openFolder(Folder folder) {
    setState(() {
      currentFolder = folder;
      currentFolder!.path = folder.path + folder.folderName;
    });
    loadFolders();
  }

  void goToParentFolder() {
    if (currentFolder != null && currentFolder!.path != '/') {
      final parentPath = currentFolder!.path
          .split('/')
          .sublist(0, currentFolder!.path.split('/').length - 1)
          .join('/');
      if (parentPath.isEmpty) {
        currentFolder = Folder(folderName: 'root', path: '/');
      } else {
        currentFolder =
            Folder(folderName: parentPath.split('/').last, path: parentPath);
      }
      setState(() {
        loadFolders();
      });
    }
  }

  Future<void> moveExamFile(ExamFile examFile, Folder targetFolder) async {
    if (targetFolder.path == '/') {
      await isar.writeTxn(() async {
        examFile.path = '/${targetFolder.folderName}/';
        await isar.examFiles.put(examFile);
      });
    } else {
      await isar.writeTxn(() async {
        examFile.path = '${examFile.path}${targetFolder.folderName}/';
        await isar.examFiles.put(examFile);
      });
    }
    loadFolders();
  }

  Future<void> deleteExamFile(ExamFile examFile) async {
    bool? shouldDelete = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('파일 삭제'),
          content: Text('${examFile.examName} 파일을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await isar.writeTxn(() async {
        await isar.examFiles.delete(examFile.id);
      });
      loadFolders();
    }
  }

  Future<void> deleteFolder(Folder folder) async {
    bool? shouldDelete = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('폴더 삭제'),
          content:
              Text('${folder.folderName} 폴더와 그 안에 있는 모든 파일과 폴더를 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await isar.writeTxn(() async {
        // 폴더 내의 모든 파일 삭제
        final examFiles = await isar.examFiles
            .filter()
            .pathStartsWith('${folder.path}${folder.folderName}/')
            .findAll();
        await isar.examFiles
            .deleteAll(examFiles.map((file) => file.id).toList());

        // 폴더 내의 모든 하위 폴더 삭제
        final subFolders = await isar.folders
            .filter()
            .pathStartsWith('${folder.path}${folder.folderName}/')
            .findAll();
        await isar.folders
            .deleteAll(subFolders.map((folder) => folder.id).toList());

        // 폴더 삭제
        await isar.folders.delete(folder.id);
      });
      loadFolders();
    }
  }

  ExamFile? draggedExamFile;
  Folder? draggedFolder;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (currentFolder == null || currentFolder!.path == "/") {
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
        } else {
          goToParentFolder();
        }
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(children: [
            Column(
              children: [
                Row(
                  children: [
                    //for testing
                    ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: const Text("logout")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuizResultScreen(
                                    questions: questions,
                                    userAnswers: userAnswers,
                                    score: 6)),
                          );
                        },
                        child: const Text("commit")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.subColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: AppTheme.textTheme.labelLarge,
                        fixedSize: const Size(200, 50),
                      ),
                      onPressed: () async {
                        String folderName = await showDialog(
                          context: context,
                          builder: (context) {
                            String name = '';
                            return AlertDialog(
                              title: const Text('폴더 추가'),
                              content: TextField(
                                onChanged: (value) {
                                  name = value;
                                },
                                decoration: const InputDecoration(
                                  hintText: '폴더 이름',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, name);
                                  },
                                  child: const Text('추가'),
                                ),
                              ],
                            );
                          },
                        );
                        if (folderName.isNotEmpty) {
                          await createFolder(folderName);
                        }
                      },
                      child: const Text("폴더 추가"),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: folders.length,
                    itemBuilder: (context, index) {
                      final folder = folders[index];
                      return LongPressDraggable<Folder>(
                        data: folder,
                        onDragStarted: () {
                          setState(() {
                            draggedFolder = folder;
                          });
                        },
                        onDraggableCanceled: (velocity, offset) {
                          setState(() {
                            draggedFolder = null;
                          });
                        },
                        //drag 시 나오는 거
                        feedback: Card(
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.folder_open_outlined,
                                    size: 100.0, color: AppTheme.mainColor),
                                Text(folder.folderName,
                                    style: AppTheme.textTheme.labelLarge),
                              ],
                            )),
                        child: DragTarget<ExamFile>(
                          onAcceptWithDetails:
                              (DragTargetDetails<Object> details) {
                            final data = details.data;
                            if (data is ExamFile) {
                              setState(() {
                                draggedExamFile = null;
                              });
                              moveExamFile(data, folder);
                            }
                          },
                          onWillAcceptWithDetails:
                              (DragTargetDetails<Object> details) {
                            final data = details.data;
                            return data is ExamFile;
                          },
                          builder: (context, candidateData, rejectedData) {
                            //폴더 아이콘
                            return GestureDetector(
                              onTap: () => openFolder(folder),
                              child: Card(
                                color: candidateData.isNotEmpty
                                    ? AppTheme.subColor
                                    : Colors.white,
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final iconSize = constraints.maxWidth *
                                        0.6; // 아이콘 크기를 Card 너비의 60%로 설정
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.folder_open_outlined,
                                            size: iconSize,
                                            color: AppTheme.mainColor),
                                        Text(folder.folderName,
                                            style:
                                                AppTheme.textTheme.labelLarge),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: examFiles.length,
                    itemBuilder: (context, index) {
                      final examFile = examFiles[index];
                      return LongPressDraggable<ExamFile>(
                        data: examFile,
                        onDragStarted: () {
                          setState(() {
                            draggedExamFile = examFile;
                          });
                        },
                        onDraggableCanceled: (velocity, offset) {
                          setState(() {
                            draggedExamFile = null;
                          });
                        },
                        feedback: Card(
                          color: AppTheme.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(examFile.examName),
                        ),
                        child: Card(
                          child: ExpansionTile(
                            title: Text(examFile.examName),
                            trailing: const Icon(Icons.expand_more),
                            backgroundColor: Colors.white,
                            collapsedBackgroundColor: Colors.grey[200],
                            iconColor: Colors.blue,
                            collapsedIconColor: Colors.black,
                            textColor: Colors.black,
                            collapsedTextColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.subColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        textStyle:
                                            AppTheme.textTheme.labelLarge,
                                        fixedSize: const Size(200, 50),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => QuizInfo(
                                              examName: examFile.examName,
                                              passage: examFile.passage,
                                              examResults:
                                                  examFile.examResults.toList(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('상세 정보'),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.subColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        textStyle:
                                            AppTheme.textTheme.labelLarge,
                                        fixedSize: const Size(200, 50),
                                      ),
                                      onPressed: () {},
                                      child: const Text('공유 하기'),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.subColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        textStyle:
                                            AppTheme.textTheme.labelLarge,
                                        fixedSize: const Size(200, 50),
                                      ),
                                      onPressed: () async {
                                        String newName = await showDialog(
                                          context: context,
                                          builder: (context) {
                                            String name = examFile.examName;
                                            return AlertDialog(
                                              title: const Text('파일 이름 변경'),
                                              content: TextField(
                                                onChanged: (value) {
                                                  name = value;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: '새로운 파일 이름을 입력하세요',
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, name);
                                                  },
                                                  child: const Text('변경'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        if (newName.isNotEmpty) {
                                          await isar.writeTxn(() async {
                                            examFile.examName = newName;
                                            await isar.examFiles.put(examFile);
                                          });
                                          setState(() {});
                                        }
                                      },
                                      child: const Text('이름 변경'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (draggedExamFile != null || draggedFolder != null)
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: DragTarget<Object>(
                      onAcceptWithDetails:
                          (DragTargetDetails<Object> details) async {
                        final data = details.data;
                        if (data is ExamFile) {
                          await deleteExamFile(data);
                        } else if (data is Folder) {
                          await deleteFolder(data);
                        }
                        setState(() {
                          draggedExamFile = null;
                          draggedFolder = null;
                        });
                      },
                      onWillAcceptWithDetails:
                          (DragTargetDetails<Object> details) {
                        final data = details.data;
                        return data is ExamFile || data is Folder;
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: candidateData.isNotEmpty
                                ? Colors.red
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ]);
        },
      ),
    );
  }
}
