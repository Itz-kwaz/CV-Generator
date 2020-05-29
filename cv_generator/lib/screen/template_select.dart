import 'package:flutter/material.dart';
import 'package:cvgenerator/screen/create_cv.dart';

class TemplateScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30.0,),
             Center(child:  Text("Please select a Template",style: TextStyle(
               color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontSize: 20.0
             ),)),
          SizedBox(height: 30.0,),
              GestureDetector(
                child: Image(image: AssetImage('assets/template_one.png'),
                  height: 300.0,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)  => CreateCv(1),
                  )
                  );
                },
              ),
              SizedBox(height:10.0),
              GestureDetector(
                child: Image(image: AssetImage('assets/template_two.png'),
                    height: 300.0),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)  => CreateCv(2),
                  )
                  );
                },
              ),
          SizedBox(height:30.0),

        ],
      ),
    );
  }

}