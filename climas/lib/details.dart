import 'package:flutter/material.dart';
import 'package:climas/main.dart';

void main() async {
  // print(await getConvert());
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
  ));
}

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Todo todo;

  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[200],
        title: Text("Climas"),
        
      ),
      body: ListView(
        children: <Widget>[
          Column(children: <Widget>[

          Divider( height: 40, ),
 CircleAvatar(
            radius: 150.0,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
                child: Image.network(
            "http://openweathermap.org/img/wn/${todo.icon}@2x.png",
            scale: 0.5,
            alignment: Alignment.topRight,
            ),
              
            ),
          ),
              
          Divider(
            height: 40,
          ),
          Card(
             elevation: 2,
            margin: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Container(
              width: 380,
              height: 80,
              child: ListTile(
                title: Text(
                  "Tempo",
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(todo.main,
                textAlign: TextAlign.center,),
              ),
            ),
          ),
           Divider( ),
          Card(
             elevation: 2,
            margin: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Container(
              width: 380,
              height: 80,
              child: ListTile(
                title: Text(
                  "Descriçao",
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(todo.description,
                textAlign: TextAlign.center,),
              ),
            ),
          ),
          ],)
          
        ],
      ),


      
    );
  }
}



