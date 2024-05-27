import 'package:flutter/material.dart';
import 'services.dart';

class HalamanDua extends StatefulWidget {
  @override
  _HalamanDuaState createState() => _HalamanDuaState();
}

class _HalamanDuaState extends State<HalamanDua> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Dua'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Judul',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan judul';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bodyController,
                decoration: InputDecoration(
                  labelText: 'Isi',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan isi';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Services.createPost(
                      _titleController.text,
                      _bodyController.text,
                    ).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Data berhasil dibuat'),
                        ),
                      );
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Gagal membuat data: $error'),
                        ),
                      );
                    });
                  }
                },
                child: Text('Buat Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}