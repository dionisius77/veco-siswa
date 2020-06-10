import 'package:equatable/equatable.dart';

class JadwalEntity extends Equatable {
  final List<Hari> senin, selasa, rabu, kamis, jumat;

  JadwalEntity(this.senin, this.selasa, this.rabu, this.kamis, this.jumat);

  static JadwalEntity fromJson(Map<String, dynamic> json) {
    List<Hari> senin = new List<Hari>();
    json['senin'].forEach((v) {
      senin.add(new Hari.fromJson(v));
    });
    List<Hari> selasa = new List<Hari>();
    json['selasa'].forEach((v) {
      selasa.add(new Hari.fromJson(v));
    });
    List<Hari> rabu = new List<Hari>();
    json['rabu'].forEach((v) {
      rabu.add(new Hari.fromJson(v));
    });
    List<Hari> kamis = new List<Hari>();
    json['kamis'].forEach((v) {
      kamis.add(new Hari.fromJson(v));
    });
    List<Hari> jumat = new List<Hari>();
    json['jumat'].forEach((v) {
      jumat.add(new Hari.fromJson(v));
    });
    return JadwalEntity(senin, selasa, rabu, kamis, jumat);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.senin != null) {
      data['senin'] = this.senin.map((v) => v.toJson()).toList();
    }
    if (this.selasa != null) {
      data['selasa'] = this.selasa.map((v) => v.toJson()).toList();
    }
    if (this.rabu != null) {
      data['rabu'] = this.rabu.map((v) => v.toJson()).toList();
    }
    if (this.kamis != null) {
      data['kamis'] = this.kamis.map((v) => v.toJson()).toList();
    }
    if (this.jumat != null) {
      data['jumat'] = this.jumat.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [senin, selasa, rabu, kamis, jumat];
}

class Hari {
  String guru;
  String matapelajaran;

  Hari({this.guru, this.matapelajaran});

  Hari.fromJson(Map<String, dynamic> json) {
    guru = json['guru'];
    matapelajaran = json['matapelajaran'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guru'] = this.guru;
    data['matapelajaran'] = this.matapelajaran;
    return data;
  }
}
