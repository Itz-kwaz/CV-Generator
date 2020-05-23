import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:cvgenerator/screen/create_cv.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      loaderColor: Colors.white,
      seconds: 5,
      title: Text('Cv Generator',
        style: TextStyle(color: Colors.blue,
            fontSize: 35.0,
            fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      navigateAfterSeconds: MainScreen(),
    );
  }

}

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {

  static const  popItem = <String>['Share', 'Delete'];
  static List<PopupMenuItem<String>> _pop  = popItem.map((String val) =>
      PopupMenuItem<String>(
        value: val,
        child: Text(val),
      )).toList();



  String value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cv generator"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 10.0),
            child: Text("Hello there,",
              style: TextStyle(
                fontSize: 20.0,
              ),),
          ),
          Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 10.0),
                child: Text("Create the perfect CV ",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                  ),),
              )
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 10.0),
            child: Text("with us.",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child:Card(elevation: 5.0,
                          child:Padding(padding: EdgeInsets.only(left:10.0,top:10.0,bottom: 10.0),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                child:Image(
                                    image:AssetImage('assets/resume.png')),
                                width: 60.0,
                                height: 60.0,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('My Cv',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500
                                      )),
                                  SizedBox(height: 5.0),
                                  Text('25 Jun 2020',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w300
                                      )),
                                ],
                              ),

                               Spacer(),
                              PopupMenuButton(
                                  onSelected: (String val) async {
                                    value = val;
                                    switch (value) {
                                      case "Share":
                                      print("object");
                                        break;
                                      case 'Delete':
                                        print("print('');");
                                        break;
                                    }
                                    },
                                  itemBuilder:(BuildContext context) =>_pop)
                            ],
                          ), )

                        ),)
                    );
                  }))

        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.create),
          onPressed: navigateTo
      ),
    );
  }

  void navigateTo() async {
    bool result = await Navigator.push(context, MaterialPageRoute(
      builder: (context)  => CreateCv(),
    )
    );
    if(result == true){
    }
  }
}



