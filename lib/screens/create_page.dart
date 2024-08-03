import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Import the color picker package
import 'package:intl/intl.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  DateTime? _selectedDate;
  bool _isBold = false;
  bool _isItalic = false;
  double _fontSize = 16.0;
  Color _textColor = Colors.black;
  String _selectedEmoji = ''; // To store the selected emoji

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _saveEntry() {
    final title = _titleController.text;
    final content = _contentController.text;
    final date = _selectedDate;

    if (title.isEmpty || content.isEmpty || date == null) {
      // Hata mesajı göster
      return;
    }

    // Kaydetme işlemi
    print('Title: $title');
    print('Content: $content');
    print('Date: ${DateFormat('yyyy-MM-dd').format(date)}');
  }

  void _pickTextColor() async {
    Color? selectedColor = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Yazı Rengini Seçin'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _textColor,
              onColorChanged: (color) {
                setState(() {
                  _textColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (selectedColor != null) {
      setState(() {
        _textColor = selectedColor;
      });
    }
  }

  void _selectEmoji(String emoji) {
    setState(() {
      _selectedEmoji = emoji;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Günlük Yaz'),
        toolbarHeight: 55.0, // AppBar'ın yüksekliğini daralt
        automaticallyImplyLeading: false, // Geri tuşunu gösterme
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              );
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menü',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Oluştur'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to CreatePage if not already there
                if (ModalRoute.of(context)?.settings.name != '/create') {
                  Navigator.pushReplacementNamed(context, '/create');
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Takvim'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/calendar');
              },
            ),
            ListTile(
              leading: const Icon(Icons.note),
              title: const Text('Notlar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/notes');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ayarlar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Başlık',
                        labelStyle: TextStyle(color: Color(0xFF636363)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF65dbff)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF65dbff)),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.calendar_today, color: Colors.red),
                        onPressed: () => _selectDate(context),
                      ),
                      if (_selectedDate != null)
                        Text(
                          '${DateFormat('dd MMMM yyyy').format(_selectedDate!)}',
                          style: const TextStyle(
                              fontSize: 14, color: Color(0xFF636363)),
                        )
                      else
                        Text(
                          'Tarih Seçin',
                          style: const TextStyle(
                              fontSize: 14, color: Color(0xFF636363)),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Toolbar for text formatting
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.format_bold,
                        color: _isBold ? Colors.blue : iconColor),
                    onPressed: () {
                      setState(() {
                        _isBold = !_isBold;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.format_italic,
                        color: _isItalic ? Colors.blue : iconColor),
                    onPressed: () {
                      setState(() {
                        _isItalic = !_isItalic;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.color_lens, color: iconColor),
                    onPressed: _pickTextColor,
                  ),
                  DropdownButton<double>(
                    value: _fontSize,
                    items: [10.0, 12.0, 14.0, 16.0, 18.0, 20.0, 22.0, 24.0]
                        .map((double size) {
                      return DropdownMenuItem<double>(
                        value: size,
                        child: Text('${size.toString()} pt'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _fontSize = value;
                        });
                      }
                    },
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.emoji_emotions, color: iconColor),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: '😊',
                          child: Text('Mutlu 😊'),
                        ),
                        PopupMenuItem<String>(
                          value: '😍',
                          child: Text('Aşık 😍'),
                        ),
                        PopupMenuItem<String>(
                          value: '😴',
                          child: Text('Yorgun 😴'),
                        ),
                        PopupMenuItem<String>(
                          value: '😢',
                          child: Text('Üzgün 😢'),
                        ),
                        PopupMenuItem<String>(
                          value: '😡',
                          child: Text('Kızgın 😡'),
                        ),
                      ];
                    },
                    onSelected: _selectEmoji,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _contentController,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Buraya günlük yazınızı ekleyin...',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                  color: _textColor,
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _saveEntry,
                  child: const Text('Kaydet'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
