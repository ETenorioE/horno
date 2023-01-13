import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:horno/models/index.dart';
import 'package:horno/preferences/index.dart';
import 'package:horno/provider/base_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbols.dart';

import '../theme/theme.dart';

class PartnerServicesProvider extends BaseProvider {
  String name = '';
  double price = 0;
  File? file;
  String? nameImage;
  List<ServiceModel> services = [];

  PartnerServicesProvider() {
    findAllByLocalId(enableLoading: true);
  }
  Future<String?> deleteById(int id) async {
    try {
      EasyLoading.instance.backgroundColor = ColorsApp.colorSecondary;
      EasyLoading.show(status: 'Procesando...');

      final res = await supabase
          .from('services')
          .update({'state': 'delete'}).eq('id', id);
      await findAllByLocalId(enableLoading: true);
      return null;
    } catch (e) {
      return 'No se puede eliminar';
    }
  }

  Future findAllByLocalId({bool enableLoading = false}) async {
    if (enableLoading) {
      isLoading = true;
    }

    final List<dynamic> res = await supabase
        .from('services')
        .select()
        .eq('local_id', Preferences.localId)
        .eq('state', 'active')
        .order('id');
    services.clear();
    for (var item in res) {
      final service = ServiceModel.fromJson(item);
      services.add(service);
    }

    if (enableLoading) {
      isLoading = false;
    } else {
      //notifyListeners();
    }
  }

  Future<String?> save() async {
    Map<String, dynamic> data = {
      'name': name,
      'service_id': 1,
      'local_id': Preferences.localId,
      'price': price,
      'image':
          'https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466_960_720.jpg',
    };

    int id;
    try {
      final res =
          await supabase.from('services').insert(data).select('id').single();
      id = res['id'];
    } catch (e) {
      return 'No se pudo completar el proceso';
    }
    final pathImage = await _uploadImageStorage(id.toString());

    await _updateImage(id: id, path: pathImage);

    //findAllByLocalId();

    activeCleanImage();

    return null;
  }

  Future<String> _uploadImageStorage(String name) async {
    final fileImage = File(file!.path);

    final ruta0 = "/data/user/0/com.example.horno/cache/${nameImage}";

    final ruta1 =
        file!.path.replaceAll('/data/user/0/com.example.horno/cache', 'img');

    final ruta2 = file!.path
        .replaceAll('/data/user/0/com.example.horno/app_flutter', 'img');

    String newPath = (file!.path == ruta0) ? ruta1 : ruta2;

    final split = newPath.split('.');

    newPath = newPath.replaceAll(split[0], name);

    final response =
        await supabase.storage.from('image').upload(newPath, fileImage);

    return response;
  }

  Future activeGalleryImage() async {
    final imageP = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageP == null) return;

    final imageTemp = File(imageP.path);

    nameImage = imageP.name;
    file = imageTemp;

    notifyListeners();
  }

  Future activeCleanImage() async {
    file = null;
    notifyListeners();
  }

  Future _updateImage({required int id, required String path}) async {
    final url =
        'https://sfqxztleugofniwjptbq.supabase.co/storage/v1/object/public/$path';

    await supabase.from('services').update({'image': url}).eq('id', id);
  }
}
