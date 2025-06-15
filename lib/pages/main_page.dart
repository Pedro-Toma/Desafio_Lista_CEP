import 'package:flutter/material.dart';
import 'package:listacep/models/viacep_model.dart';
import 'package:listacep/pages/cep_page.dart';
import 'package:listacep/repositories/cep_repository.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  CepRepository cepRepository = CepRepository();

  var cepController = TextEditingController();
  var registros = ViaCEPsModel([]);
  var carregando = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarCEPs();
  }

  carregarCEPs() async {
    setState(() {
      carregando = true;
    });
    registros = await cepRepository.obterRegistros();
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () async {
            cepController.text = "";
            showDialog(
              context: context, 
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: Text("Consulta CEP"),
                  content: TextField(
                    controller: cepController,
                    keyboardType: TextInputType.number,
                  ),
                  actions : [
                    TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Cancelar")
                  ),
                  TextButton(
                    onPressed: () async {
                      var cep = cepController.text.replaceAll(new RegExp(r'[^0-9]'), '');
                      if (cep.length != 8) {
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
                      }
                      ViaCEPModel? exists = await cepRepository.consultarCEP(cep);
                      if (exists == null) {
                        setState(() {
                          carregando = false;
                        });
                        showDialog(
                          context: context, 
                          builder: (BuildContext bc) {
                            return AlertDialog(
                              title: Text("CEP não existe.",
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
                      } else {
                        bool registered = await cepRepository.consultarRegistro(exists);
                        setState(() {
                          carregando = false;
                        });
                        if (registered) {
                          showDialog(
                            context: context, 
                            builder: (BuildContext bc) {
                              return AlertDialog(
                                title: Text("CEP já registrado.",
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
                        } else {
                          Navigator.pop(context);
                        }
                        
                      }
                      await carregarCEPs();
                      setState(() {});
                    },
                    child: Text("Salvar")
                  )
                  ]
                );
              }
            );
          }
        ),
        appBar: AppBar(
          title: Text("Consultar CEP"),
        ),
        body: carregando ?
        CircularProgressIndicator() :
        ListView.builder(
          itemCount: registros.results.length,
          itemBuilder: (BuildContext bc, int index) {
            var registro = registros.results[index];
            return Dismissible(
              onDismissed: (DismissDirection dismissDirection) async {
                await cepRepository.removerRegistro(registro.objectId!);
                carregarCEPs();
              },
              key: Key(registro.cep!),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                      CepPage(viaCEPModel: registro)
                    )
                  );
                },
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(registro.cep!, style: TextStyle(fontSize: 20)),
                            Text("Estado: ${registro.estado!}", style: TextStyle(fontSize: 20)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(registro.bairro!, style: TextStyle(fontSize: 15)),
                        Text(registro.localidade!, style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  )
                ),
              ),
            );
          }
        )
      )
    );
  }
}