import 'package:cloud_functions/cloud_functions.dart';

class KBMRepository {
  final HttpsCallable callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'getKBMFromFLutter');

  Future<Map> getKBM(String nik) async {
    var jadwalResult = await callable.call(<String, String>{'nik': nik});
    return jadwalResult.data;
  }
}
