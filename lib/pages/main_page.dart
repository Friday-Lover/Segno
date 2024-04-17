import 'package:flutter/material.dart';
import '../Style/style.dart';
import 'text_input_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<FileItem> fileItems = [
    FileItem(name: '파일 1', isFolder: false),
    FileItem(name: '파일 2', isFolder: false),
    FileItem(name: '폴더 1', isFolder: true),
    FileItem(name: '파일 3', isFolder: false),
    FileItem(name: '파일 4', isFolder: false),
    FileItem(name: '폴더 2', isFolder: true),
    FileItem(name: '폴더 3', isFolder: true)
  ];

  List<FileItem> selectedFiles = [];
  bool isSelectionMode = false;
  bool isMenuOpen = false;
  late AnimationController _animationController;
  final _buttonDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: _buttonDuration, vsync: this)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
      if (isMenuOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _enterSelectionMode(FileItem fileItem) {
    setState(() {
      isSelectionMode = true;
      selectedFiles.add(fileItem);
    });
  }

  void _exitSelectionMode() {
    setState(() {
      isSelectionMode = false;
      selectedFiles.clear();
    });
  }

  void _toggleFileSelection(FileItem fileItem) {
    setState(() {
      if (selectedFiles.contains(fileItem)) {
        selectedFiles.remove(fileItem);
      } else {
        selectedFiles.add(fileItem);
      }
    });
  }

  void _addFolder(String folderName) {
    setState(() {
      fileItems.add(FileItem(name: folderName, isFolder: true));
    });
  }

  void _deleteSelectedFiles() {
    setState(() {
      fileItems.removeWhere((file) => selectedFiles.contains(file));
      selectedFiles.clear();
      isSelectionMode = false;
    });
  }

  void _renameSelectedFile() {
    // TODO: 파일 이름 변경 로직 구현
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isMenuOpen) {
          _toggleMenu();
          return false;
        }
        if (isSelectionMode) {
          _exitSelectionMode();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '메인 페이지',
            textAlign: TextAlign.center,
            style: AppTheme.textTheme.displayMedium,
          ),
          actions: isSelectionMode
              ? [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: _renameSelectedFile,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: _deleteSelectedFiles,
                  ),
                ]
              : null,
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final crossAxisCount = constraints.maxWidth < 600 ? 4 : 6;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 1,
              ),
              itemCount: fileItems.length,
              itemBuilder: (context, index) {
                final fileItem = fileItems[index];
                return GestureDetector(
                  onLongPress: () => _enterSelectionMode(fileItem),
                  onTap: () {
                    if (isSelectionMode) {
                      _toggleFileSelection(fileItem);
                    } else {
                      // TODO: 파일 또는 폴더 열기 로직 구현
                    }
                  },
                  child: FileItemWidget(
                    fileItem: fileItem,
                    isSelected: selectedFiles.contains(fileItem),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: AnimatedContainer(
          duration: _buttonDuration,
          curve: Curves.easeInOut,
          width: isMenuOpen ? MediaQuery.of(context).size.width - 112 : 56,
          height: 56,
          decoration: BoxDecoration(
            color: isMenuOpen ? Colors.black54 : Colors.blue,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              AnimatedOpacity(
                opacity: isMenuOpen ? 1 : 0,
                duration: _buttonDuration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMenuItem(Icons.create_new_folder, '폴더 추가'),
                    _buildMenuItem(Icons.note_add, '문제 추가'),
                  ],
                ),
              ),
              FloatingActionButton(
                onPressed: _toggleMenu,
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _animationController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (label == '폴더 추가') {
                _toggleMenu();
                showDialog(
                  context: context,
                  builder: (context) {
                    String folderName = '';
                    return AlertDialog(
                      title: const Text('폴더 추가'),
                      content: TextField(
                        onChanged: (value) {
                          folderName = value;
                        },
                        decoration: const InputDecoration(hintText: '폴더 이름 입력'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _addFolder(folderName);
                          },
                          child: const Text('추가'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('취소'),
                        ),
                      ],
                    );
                  },
                );
              } else if (label == '문제 추가') {
                _toggleMenu();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TextInputPage()),
                );
              }
            },
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(label),
        ),
      ],
    );
  }
}

class FileItem {
  final String name;
  final bool isFolder;

  FileItem({required this.name, required this.isFolder});
}

class FileItemWidget extends StatelessWidget {
  final FileItem fileItem;
  final bool isSelected;

  const FileItemWidget(
      {super.key, required this.fileItem, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected ? Colors.blue.withOpacity(0.5) : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            fileItem.isFolder ? Icons.folder : Icons.insert_drive_file,
            size: 64,
          ),
          const SizedBox(height: 8),
          Text(
            fileItem.name,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
