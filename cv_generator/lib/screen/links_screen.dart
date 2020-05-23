import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LinksScreen extends StatelessWidget{

  String linkName;
  String link;

  LinksScreen();

 @override
 Widget build(BuildContext context) {
   TextEditingController _controllerLinkName  = TextEditingController();
   TextEditingController _controllerLink= TextEditingController();
   return Scaffold(
     appBar: AppBar(

     ),
     body: ListView(children: <Widget>[
       SizedBox(height: 10.0),
       Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           SizedBox(height: 10.0,),
           Padding(
             padding: EdgeInsets.only(left:10.0,right: 10.0,bottom: 15.0),
             child: TextField(
               controller: _controllerLinkName,
               decoration: InputDecoration(
                   labelText: "Link Name" ,
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5.0))),
               keyboardType: TextInputType.text,
             ),
           ),
           SizedBox(height: 10.0),
           Padding(
             padding: EdgeInsets.only(left:10.0,right: 10.0,bottom: 15.0),
             child: TextField(
               controller: _controllerLink,
               decoration: InputDecoration(
                   labelText: "Link" ,
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5.0))),
               keyboardType: TextInputType.text,
             ),
           ),

           Padding(padding: EdgeInsets.only(left:25.0,right: 25.0,top:15.0),
               child:  SizedBox(
                   width: double.infinity,
                   child:RaisedButton(child: Text('Update',
                     style: TextStyle(
                         fontSize: 15.0
                     ),),
                       color: Colors.blue[600],
                       splashColor: Colors.indigo,
                       textColor: Colors.white,
                       onPressed:(){
                     link = _controllerLink.text;
                     linkName = _controllerLinkName.text;


                     if(link.isNotEmpty && linkName.isNotEmpty){
                       Map map = {'firstLabel': linkName, 'secondLabel': link};

                       Navigator.pop(context,map);
                     }

                   }
                   )
               )
           ),
         ],
       ),
     ],
     ),
   );
 }


}



