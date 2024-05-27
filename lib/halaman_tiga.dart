import 'package:flutter/material.dart';
import 'services.dart';

class HalamanTiga extends StatefulWidget {
 @override
 _HalamanTigaState createState() => _HalamanTigaState();
}

class _HalamanTigaState extends State<HalamanTiga> {
 List<dynamic> data = [];

 @override
 void initState() {
   super.initState();
   fetchData();
 }

 Future<void> fetchData() async {
   data = await Services.getPosts();
   setState(() {});
 }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Halaman Tiga'),
     ),
     body: ListView.builder(
       itemCount: data.length,
       itemBuilder: (context, index) {
         return ListTile(
           title: Text(data[index]['title']),
           subtitle: Text(data[index]['body']),
           trailing: Row(
             mainAxisSize: MainAxisSize.min,
             children: [
               IconButton(
                 icon: Icon(Icons.edit),
                 onPressed: () {
                   showDialog(
                     context: context,
                     builder: (context) {
                       final titleController =
                           TextEditingController(text: data[index]['title']);
                       final bodyController =
                           TextEditingController(text: data[index]['body']);
                       return AlertDialog(
                         title: Text('Edit Data'),
                         content: Column(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             TextFormField(
                               controller: titleController,
                               decoration: InputDecoration(
                                 labelText: 'Judul',
                               ),
                             ),
                             TextFormField(
                               controller: bodyController,
                               decoration: InputDecoration(
                                 labelText: 'Isi',
                               ),
                             ),
                           ],
                         ),
                         actions: [
                           TextButton(
                             onPressed: () {
                               Navigator.of(context).pop();
                             },
                             child: Text('Batal'),
                           ),
                           ElevatedButton(
                             onPressed: () {
                               Services.updatePost(
                                 data[index]['id'],
                                 titleController.text,
                                 bodyController.text,
                               ).then((value) {
                                 fetchData();
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Data berhasil diupdate'),
                                   ),
                                 );
                                 Navigator.of(context).pop();
                               }).catchError((error) {
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Gagal mengupdate data: $error'),
                                   ),
                                 );
                               });
                             },
                             child: Text('Simpan'),
                           ),
                         ],
                       );
                     },
                   );
                 },
               ),
               IconButton(
                 icon: Icon(Icons.delete),
                 onPressed: () {
                   showDialog(
                     context: context,
                     builder: (context) {
                       return AlertDialog(
                         title: Text('Konfirmasi'),
                         content: Text('Anda yakin ingin menghapus data ini?'),
                         actions: [
                           TextButton(
                             onPressed: () {
                               Navigator.of(context).pop();
                             },
                             child: Text('Batal'),
                           ),
                           ElevatedButton(
                             onPressed: () {
                               Services.deletePost(data[index]['id'])
                                   .then((value) {
                                 fetchData();
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Data berhasil dihapus'),
                                   ),
                                 );
                                 Navigator.of(context).pop();
                               }).catchError((error) {
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Gagal menghapus data: $error'),
                                   ),
                                 );
                               });
                             },
                             child: Text('Hapus'),
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
     ),
   );
 }
}