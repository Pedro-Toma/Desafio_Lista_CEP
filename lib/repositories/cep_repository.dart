import 'package:listacep/models/viacep_model.dart';
import 'package:listacep/repository/custom_dio.dart';

class CepRepository {

  final customDio = CustomDio();

  CepRepository();

  Future<ViaCEPModel?> consultarCEP(String cep) async {
    var url = "https://viacep.com.br/ws/$cep/json/";
    var result = await customDio.dio.get(url);
    if (result.data == null || result.data.containsKey("erro")) {
      return null;
    }
    ViaCEPModel viaCEPModel = ViaCEPModel.fromJson(result.data);
    
    return viaCEPModel;
  }

  Future<ViaCEPsModel> obterRegistros() async {
    var url = "/CEP";
    var result = await customDio.dio.get(url);
    return ViaCEPsModel.fromJson(result.data);
  }

  Future<bool> consultarRegistro(ViaCEPModel viaCEPModel) async {
   
    var query = "where={\"cep\":\"${viaCEPModel.cep}\"}";
    var url = "/CEP?$query";
    
    var result = await customDio.dio.get(url);

    var results = result.data['results'];

    if (results.isEmpty){
      await salvarRegistro(viaCEPModel);
      return false;
    }
    return true;

  }

    Future<void> salvarRegistro(ViaCEPModel viaCEPModel) async {

      try {
        await customDio.dio.post("/CEP",
          data: viaCEPModel.toJson()
        );
      } catch (e) {
        throw(e);
      }
    }

    Future<void> atualizarRegistro(ViaCEPModel viaCEPModel) async {

      try {
        await customDio.dio.put("/CEP/${viaCEPModel.objectId}",
          data: viaCEPModel.toJsonEndpoint()
        );
      } catch (e) {
        throw(e);
      }
    }

    Future<void> removerRegistro(String objectId) async {

      try {
        await customDio.dio.delete("/CEP/$objectId",
        );
      } catch (e) {
        throw(e);
      }
    }

}