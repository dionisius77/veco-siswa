import 'package:cloud_functions/cloud_functions.dart';

class NilaiRepository {
  final HttpsCallable listMapelCall = CloudFunctions.instance.getHttpsCallable(functionName: 'getListMapelFromFlutter');
  final HttpsCallable listNilaiCall = CloudFunctions.instance.getHttpsCallable(functionName: 'getNilaiFromFlutter');

  Future<Map> getListMapel(String nik) async {
    try {
      var resultMapel = await listMapelCall.call(<String, String>{'nik': nik});
      return resultMapel.data;
    } catch (e) {
      return e;
    }
  }

  Future<Map> getListNilai(String nik, String mapel, String kelas) async {
    try {
      var resultNilai = await listNilaiCall.call(<String, String>{
        'nik': nik,
        'kelas': kelas,
        'mataPelajaran': mapel,
      });
      return resultNilai.data;
    } catch (e) {
      return e;
    }
  }
}