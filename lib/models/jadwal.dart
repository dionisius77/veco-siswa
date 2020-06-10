class Jadwal {
  List senin, selasa, rabu, kamis, jumat;

  // Jadwal(this.senin, this.selasa, this.rabu, this.kamis, this.jumat);

  Jadwal.fromJson(Map json) {
    if (json['senin'] != null) {
      senin = new List<Hari>();
      json['senin'].forEach((v) {
        senin.add(new Hari.fromJson(v));
      });
    }
    if (json['selasa'] != null) {
      selasa = new List<Hari>();
      json['selasa'].forEach((v) {
        selasa.add(new Hari.fromJson(v));
      });
    }
    if (json['rabu'] != null) {
      rabu = new List<Hari>();
      json['rabu'].forEach((v) {
        rabu.add(new Hari.fromJson(v));
      });
    }
    if (json['kamis'] != null) {
      kamis = new List<Hari>();
      json['kamis'].forEach((v) {
        kamis.add(new Hari.fromJson(v));
      });
    }
    if (json['jumat'] != null) {
      jumat = new List<Hari>();
      json['jumat'].forEach((v) {
        jumat.add(new Hari.fromJson(v));
      });
    }
    // Jadwal(senin, selasa, rabu, kamis, jumat);
    this.senin = senin;
    this.selasa = selasa;
    this.rabu = rabu;
    this.kamis = kamis;
    this.jumat = jumat;
  }
}

class Hari {
  String guru;
  String matapelajaran;

  // Hari(this.guru, this.matapelajaran);

  Hari.fromJson(Map<String, dynamic> json) {
    this.guru = json['guru'];
    this.matapelajaran = json['matapelajaran'];
    // Hari(guru, matapelajaran);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['guru'] = this.guru;
  //   data['matapelajaran'] = this.matapelajaran;
  //   return data;
  // }
}