class ViaCEPsModel {
  List<ViaCEPModel> results = [];

  ViaCEPsModel(this.results);

  ViaCEPsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ViaCEPModel>[];
      json['results'].forEach((v) {
        results.add(ViaCEPModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
      return data;
  }
}

class ViaCEPModel {
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? cep;
  String? logradouro;
  String? complemento;
  String? unidade;
  String? bairro;
  String? localidade;
  String? uf;
  String? estado;
  String? regiao;
  String? ibge;
  String? gia;
  String? ddd;
  String? siafi;

  ViaCEPModel(
      {this.objectId,
      this.createdAt,
      this.updatedAt,
      this.cep,
      this.logradouro,
      this.complemento,
      this.unidade,
      this.bairro,
      this.localidade,
      this.uf,
      this.estado,
      this.regiao,
      this.ibge,
      this.gia,
      this.ddd,
      this.siafi});

  ViaCEPModel.criar(
    this.cep,
    this.logradouro,
    this.complemento,
    this.unidade,
    this.bairro,
    this.localidade,
    this.uf,
    this.estado,
    this.regiao,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi
  );

  ViaCEPModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    unidade = json['unidade'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    estado = json['estado'];
    regiao = json['regiao'];
    ibge = json['ibge'];
    gia = json['gia'];
    ddd = json['ddd'];
    siafi = json['siafi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['unidade'] = unidade;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['estado'] = estado;
    data['regiao'] = regiao;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['unidade'] = unidade;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['estado'] = estado;
    data['regiao'] = regiao;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    return data;
  }
}
