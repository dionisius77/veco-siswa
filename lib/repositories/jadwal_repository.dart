import 'package:cloud_functions/cloud_functions.dart';

class JadwalRepository {
  final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(functionName: 'getJadwalFromFLutter');
  
  Future<Map> getJadwal(String nik) async{
    try {
      var jadwalResult = await callable.call(<String, String>{'nik': nik});
      return jadwalResult.data['jadwal'];
    } catch (e) {
      return e;
    }
  }
}