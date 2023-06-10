import 'dart:convert';
import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';

void main() async {
  // MongoDB'ye bağlan
  var db = Db('mongodb://localhost:27017/yazlab2');
  await db.open();

  // words.json dosyasını oku
  var file = File('C:\Users\Sezer\Desktop\ders\yazlab2\project2\flutter_application_1\words.json');
  var jsonString = await file.readAsString();
  var jsonList = jsonDecode(jsonString);

  // words koleksiyonunu al
  var collection = db.collection('words');

  // Verileri koleksiyona ekle
  await collection.insertAll(jsonList);

  // Bağlantıyı kapat
  await db.close();
}