import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final Function(bool) toggleDarkMode;

  SettingsPage({Key? key, required this.toggleDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
         SwitchListTile(
          title: Text('Karanlık Mod'),
          value: Theme.of(context).brightness == Brightness.dark,
          onChanged: (value) {
            toggleDarkMode(value);
          },

        ),
        const Divider(),

          // Language Secici
          ListTile(
            title: const Text('Dil Seçimi'),
            trailing: DropdownButton<String>(
              value: 'Türkçe', // Varsayilan deger
              items: <String>['English', 'Türkçe'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
              },
            ),
          ),
          const Divider(),

          // Hakkinda ve Destek kismi
          ListTile(
            title: const Text('Hakkında'),
            onTap: () {
             
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Yardım ve Destek'),
            onTap: () {
              
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
