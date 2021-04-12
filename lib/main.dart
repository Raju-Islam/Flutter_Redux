import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() async {
  //store redux libery

  final store = Store(generateRandomValues, initialState: "lets do it");
  runApp(
    MaterialApp(
      home: new HomePage(store),
      debugShowCheckedModeBanner: false,
      theme: new ThemeData.dark(),
    ),
  );
}

enum RandomTypes { Numbers, Alphabets }
// create method and pure function
generateRandomValues(dynamic value, dynamic action) {
  if (action == RandomTypes.Numbers) {
    return value = randomNumeric(15);
  }
  if (action == RandomTypes.Alphabets) {
    return value = randomAlpha(15);
  }
  return value;
}

class HomePage extends StatelessWidget {
  final Store<dynamic> store;
  HomePage(this.store);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<dynamic>(
      store: store,
      child: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text("Redux App"),
        ),
        body: Container(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new StoreConnector<dynamic, String>(
                    builder: (context, text) {
                      return new Text(
                        text,
                        style: new TextStyle(fontSize: 25),
                      );
                    },
                    converter: (store) => store.state.toString(),
                  ),

                  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      new StoreConnector<dynamic, VoidCallback>(
                          builder: (context, callback) {
                        return new MaterialButton(
                          child: new Text(
                            "RandomNumber",
                            style: new TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          color: Colors.white,
                          onPressed: callback,
                        );
                      }, converter: (store) {
                        return () => store.dispatch(RandomTypes.Numbers);
                      }),
                      new StoreConnector<dynamic, VoidCallback>(
                        builder: (context, callback) {
                          return new MaterialButton(
                            child: new Text(
                              "RandomAlpha",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            color: Colors.white,
                            onPressed: callback,
                          );
                        },
                        converter: (store){
                          return () =>store.dispatch(RandomTypes.Alphabets);
                        },
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
