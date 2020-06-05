import 'package:flutter/material.dart';
import 'package:climas/details.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.openweathermap.org/data/2.5/onecall?lat=-22.123228&lon=-45.059692&exclude=daily&appid=5701ac39467b37279afc1dd37946494a";
const requestConvert =
    "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyBAZyF4ZwJzIGwx5Rae0-B7SNrABw8q5As&address=Avenida%20Paulista,%201578,%20Sao%20Paulo";

void main() async {
  // print(await getConvert());
  runApp(MaterialApp(
      home: Home(),
      theme: ThemeData(
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ))));
}

class Todo {
  final String type;
  final String icon;
  final String main;
  final String description;

  /*
    response = await http.get(
          "https://api.openweathermap.org/data/2.5/onecall?lat=$search&lon=-45.059692&units=metric&lang=pt_br&appid=5701ac39467b37279afc1dd37946494a");
    */

  Todo(this.type, this.icon, this.main, this.description);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String search;
  String title;
  double temp;
  double sens;
  String icon;
  String main;
  String description;
  int cons = 0;

  Future<Map> _getCidade() async {
    http.Response response;
    if (search == null || search.isEmpty)
      response = await http.get("Erro");
    else
      response = await http.get(
          "http://api.openweathermap.org/data/2.5/weather?q=$search&appid=5701ac39467b37279afc1dd37946494a&units=metric&lang=pt_br");
    return json.decode(response.body);
  }

  @override
  @override
  Widget build(BuildContext context) {
    AppBar appBar =
     AppBar(
      centerTitle: true,
      title: Text("CLIMAS"),
      
    );
    return Scaffold(
      resizeToAvoidBottomInset : false,
        backgroundColor: Colors.blueGrey[100],
        appBar: appBar,
        body: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  
                    margin: const EdgeInsets.only(
                        left: 10.0, top: 30.0, right: 10.0),
                    height: 60.0,
                    child: new Directionality(
                        textDirection: TextDirection.ltr,
                        child: new TextField(
                            controller: null,
                            autofocus: false,
                            style: new TextStyle(
                                fontSize: 22.0, color: Colors.white),
                            textAlign: TextAlign.center,
                            decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors.blue[100],
                              hintText: 'Digite a cidade aqui',
                            ),
                            onSubmitted: (text) {
                              setState(() {
                                cons = 1;
                                search = text;
                              });
                            }))),
              ],
            ),
          ),
          Container( 
            child: cons == 0
                ? LayoutBuilder(
                    builder: (ctx, constraints) {
                      return Column(
                        children: <Widget>[
                          Text(
                            'Pesquise sobre o clima da sua cidade aqui!',
                            style: TextStyle(
                                    color: Colors.blue, fontSize: 15.0),
                                textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40),
                          Container(
                            height: 400,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:  AssetImage(
                              'assets\\images\\clima.png'),
                              fit: BoxFit.cover,
                            )
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : Expanded(
                    child: FutureBuilder<Map>(
                        future: _getCidade(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return Center(
                                  child: Text(
                                "Carregando Dados...",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 25.0),
                                textAlign: TextAlign.center,
                              ));
                            default:
                              if (snapshot.hasError)
                                return Center();
                              else
                                title = snapshot.data["name"];
                              temp = snapshot.data["main"]['temp'];
                              sens = snapshot.data["main"]['feels_like'];
                              icon = snapshot.data['weather'][0]["icon"];
                              main = snapshot.data['weather'][0]["main"];
                              description =
                                  snapshot.data['weather'][0]["description"];
                              return _climaTable();
                          }
                        })),
          )
        ]));
  }

  Widget _climaTable() {
    return ListView(children: <Widget>[
      Divider(height: 40),
      Card(
          margin: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: Container(
              width: 200,
              height: 100,
              child: ListTile(
                title: Text(
                  "Região",
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(title),
              ))),
      Divider(height: 20),
      Card(
          margin: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: Container(
              width: 300,
              height: 100,
              child: ListTile(
                title: Text(
                  "Temperatura",
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(' $temp C°'),
              ))),
      Divider(height: 20),
      Card(
          margin: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: Container(
              width: 300,
              height: 100,
              child: ListTile(
                title: Text(
                  "Sensação Termica",
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(' $sens C°'),
              ))),
      Divider(height: 40),
      Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Row(
            children: <Widget>[
              Container(
                  width: 350,
                  height: 60,
                  child: ListTile(
                    title: Text(
                      " mais informaçoes sobre o clima",
                      style: Theme.of(context).textTheme.title,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                    todo: Todo(search, icon, main, description),
                                  )));
                    },
                  )),
              Container(
                child: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
