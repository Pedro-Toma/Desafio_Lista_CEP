import 'package:flutter/material.dart';
import 'package:listacep/models/viacep_model.dart';
import 'package:listacep/repositories/cep_repository.dart';
import 'package:listacep/shared/widgets/text_label.dart';

class CepPage extends StatefulWidget {

  final ViaCEPModel viaCEPModel;

  const CepPage({super.key, required this.viaCEPModel});

  @override
  State<CepPage> createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {

  var cepRepository = CepRepository();

  var cepController = TextEditingController();
  var logradouroController = TextEditingController();
  var complementoController = TextEditingController();
  var unidadeController = TextEditingController();
  var bairroController = TextEditingController();
  var localidadeController = TextEditingController();
  var ufController = TextEditingController();
  var estadoController = TextEditingController();
  var regiaoController = TextEditingController();
  var ibgeController = TextEditingController();
  var giaController = TextEditingController();
  var dddController = TextEditingController();
  var siafiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() {
    cepController.text = widget.viaCEPModel.cep ?? '';
    logradouroController.text = widget.viaCEPModel.logradouro ?? '';
    complementoController.text = widget.viaCEPModel.complemento ?? '';
    unidadeController.text = widget.viaCEPModel.unidade ?? '';
    bairroController.text = widget.viaCEPModel.bairro ?? '';
    localidadeController.text = widget.viaCEPModel.localidade ?? '';
    ufController.text = widget.viaCEPModel.uf ?? '';
    estadoController.text = widget.viaCEPModel.estado ?? '';
    regiaoController.text = widget.viaCEPModel.regiao ?? '';
    ibgeController.text = widget.viaCEPModel.ibge ?? '';
    giaController.text = widget.viaCEPModel.gia ?? '';
    dddController.text = widget.viaCEPModel.ddd ?? '';
    siafiController.text = widget.viaCEPModel.siafi ?? '';
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.viaCEPModel.cep!)
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(
            children: [
              TextLabel(texto: "CEP"),
              TextField(
                controller: cepController,
              ),
              TextLabel(texto: "Logradouro"),
              TextField(
                controller: logradouroController,
              ),
              TextLabel(texto: "Complemento"),
              TextField(
                controller: complementoController,
              ),
              TextLabel(texto: "Unidade"),
              TextField(
                controller: unidadeController,
              ),
              TextLabel(texto: "Bairro"),
              TextField(
                controller: bairroController,
              ),
              TextLabel(texto: "Localidade"),
              TextField(
                controller: localidadeController,
              ),
              TextLabel(texto: "UF"),
              TextField(
                controller: ufController,
              ),
              TextLabel(texto: "Estado"),
              TextField(
                controller: estadoController,
              ),
              TextLabel(texto: "Região"),
              TextField(
                controller: regiaoController,
              ),
              TextLabel(texto: "IBGE"),
              TextField(
                controller: ibgeController,
              ),
              TextLabel(texto: "GIA"),
              TextField(
                controller: giaController,
              ),
              TextLabel(texto: "DDD"),
              TextField(
                controller: dddController,
              ),
              TextLabel(texto: "SIAFI"),
              TextField(
                controller: siafiController,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () async {
            var cep = cepController.text.replaceAll(new RegExp(r'[^0-9]'), '');
            if (cep.length != 8){
              showDialog(
                context: context, 
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: Text("CEP inválido \n(digite 8 números)",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Ok",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          )
                        )
                      )
                    ]
                  );
                }
              );
              return;
            } else {
              widget.viaCEPModel.cep = cepController.text;
              widget.viaCEPModel.logradouro = logradouroController.text;
              widget.viaCEPModel.complemento = complementoController.text;
              widget.viaCEPModel.unidade = unidadeController.text;
              widget.viaCEPModel.bairro = bairroController.text;
              widget.viaCEPModel.localidade = localidadeController.text;
              widget.viaCEPModel.uf = ufController.text;
              widget.viaCEPModel.estado = estadoController.text;
              widget.viaCEPModel.regiao = regiaoController.text;
              widget.viaCEPModel.ibge = ibgeController.text;
              widget.viaCEPModel.gia = giaController.text;
              widget.viaCEPModel.ddd = dddController.text;
              widget.viaCEPModel.siafi = siafiController.text;
              await cepRepository.atualizarRegistro(widget.viaCEPModel);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: 
                  Text("CEP Atualizado.")
                )
              );
            }
          }
        ),
      )
    );
  }
}