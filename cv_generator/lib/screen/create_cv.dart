import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cvgenerator/screen/jobs_edu_screen.dart';
import 'package:cvgenerator/screen/links_screen.dart';
import 'package:cvgenerator/screen/skills_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cvgenerator/screen/pdf_preview_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


class CreateCv extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CreateCvState();

}

class _CreateCvState extends State<CreateCv> {

  final pdf = pw.Document();

  writeOnPdf(){
    pw.MultiPage(
      pageFormat:  PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build:(pw.Context context){
        return <pw.Widget> [
          pw.Header(
            level: 0,
            child: pw.Text('Example Dowcument')
          ),
          pw.Paragraph(text: "   Directory documentDirectory   Directory documentDirectory   Directory documentDirectory"
          ),
          pw.Paragraph(text: "   Directory documentDirectory   Directory documentDirectory   Directory documentDirectory"
          ),
          pw.Paragraph(text: "   Directory documentDirectory   Directory documentDirectory   Directory documentDirectory"
          ),
        ];
      }
    );
  }

  Future savePdf() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String docPath = documentDirectory.path;

    File file = File('$docPath/example.pdf');

    file.writeAsBytesSync(pdf.save());
  }

  String value;
  static const  popItem = <String>['Delete'];
  static List<PopupMenuItem<String>> _pop  = popItem.map((String val) =>
      PopupMenuItem<String>(
        value: val,
        child: Text(val),
      )).toList();

  //Variable for company List;
  List<Map> jobData = new List();
  int _jobCount = 0;
  double _jobListHeight = 0;
  String _jobImageUri = "assets/portfolio.png";

  //Number of educational achievements added by User.
  List<Map> eduData = new List();
  int _eduCount = 0;
  double _eduListHeight = 0.0;
  String _eduImageUri = 'assets/extension.png';

  //Number of Social Links,Website or Portfolio LInks added by User
  List<Map> linkData = new List();
  int _linkCount = 0;
  double _linkListHeight = 0.0;
  String _linkImageUri = "assets/extension.png";

  //Number of Skills added by User
  List<Map> skillData = new List();
  int _skillsCount = 0;
  double _skillsListHeight = 0.0;
  String _skillsImageUri = "assets/extension.png";

  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _emailController;
  TextEditingController _phoneNoController;
  TextEditingController _addressController;
  TextEditingController _aboutController;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.done), onPressed: () async{
            writeOnPdf();
            await savePdf();
            Directory documentDirectory = await getApplicationDocumentsDirectory();
            String docPath = documentDirectory.path;
            String fullpath =  '$docPath/example.pdf';

            Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewScreen(path:fullpath)
            )
            );
          }),
          SizedBox(width: 10)
        ],
      ),
      body:
      ListView.builder(
          itemCount: 1,
          itemBuilder: (context,index){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(child: Padding(padding: EdgeInsets.all(20.0),
            child:  TextField(showCursor: true,
              autofocus: false,
              decoration: InputDecoration(
                  hintText: "Title"
              ),
            ))
            ),
          SizedBox(height: 10.0,),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Personal Details",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),),
          ),
          Padding(
            padding: EdgeInsets.only(left:10.0,right: 10.0,bottom: 15.0),
            child: TextField(
               controller: _firstNameController,
              decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:10.0,right: 10.0,bottom: 15.0),
            child: TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:10.0,right: 10.0,bottom: 15.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:10.0,right: 10.0,bottom: 15.0),
            child: TextField(
              controller: _phoneNoController,
              decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              keyboardType: TextInputType.phone,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:10.0,right: 10.0,bottom: 8.0),
            child: TextField(
              controller: _addressController,
              decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text("Professional Summary",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Padding(
            padding: EdgeInsets.only(left:12.0,right: 12.0,bottom: 5.0),
            child: TextField(
              controller: _aboutController,
              maxLines: null,
              decoration: InputDecoration(
                 hintText: "I am very passionate developer with skills in java,flutter",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              keyboardType: TextInputType.multiline,
            ),
          ),
          SizedBox(height: 15.0),
          Divider(
            color: Colors.grey,
            height: 20,
            thickness: 1,
            indent: 15,
            endIndent: 15,
          ),
          Padding(
            padding: EdgeInsets.only(left:15.0,bottom: 10.0),
            child: Text("Employment",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Padding(
              padding: EdgeInsets.only(left:15.0,bottom: 12.0,right: 15.0),
              child:
              Text("Include your relevant work experience. List your most recent work experience first",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300
                ),)
          ),
          Container(
            height: _jobListHeight,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _jobCount,
                itemBuilder:(context,index){
                  return  Container(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child:GestureDetector(
                              child:Card(
                                  elevation: 5.0,
                                  child:Padding(padding: EdgeInsets.only(left:10.0,top:10.0,bottom: 10.0),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Container(
                                          child:Image(
                                              image:AssetImage(_skillsImageUri)),
                                          width: 40.0,
                                          height: 40.0,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(jobData[index]["firstLabel"],
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w500
                                                )),
                                            SizedBox(height: 5.0),
                                            Text(jobData[index]["secondLabel"],
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
                                            },
                                            itemBuilder:(BuildContext context) =>_pop)
                                      ],
                                    ), )

                              )
                          )
                      )
                  );
                }
            ),),
          InkWell(
              splashColor: Colors.purple[100],
              child:Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 30.0,),
                    Icon(Icons.add,
                      color: Colors.blue[700],
                    ),
                    SizedBox(width:3.0),
                    Text("Add Employment",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue[700]
                      ),),
                  ],
                ),),
              onTap:(){
                navigateToDetailsScreen("Company","Job title","work");
              }
          ),
          SizedBox(height:25.0),
          Padding(
            padding: EdgeInsets.only(left:15.0,bottom: 10.0),
            child: Text("Education",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Padding(
              padding: EdgeInsets.only(left:15.0,bottom: 12.0,right: 15.0),
              child:
              Text("Include recent educational achievements.",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300
                ),)
          ),
          Container(
            height: _eduListHeight,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _eduCount,
                itemBuilder:(context,index){
                  return  Container(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child:GestureDetector(
                              child:Card(
                                  elevation: 5.0,
                                  child:Padding(padding: EdgeInsets.only(left:10.0,top:10.0,bottom: 10.0),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Container(
                                          child:Image(
                                              image:AssetImage(_eduImageUri)),
                                          width: 40.0,
                                          height: 40.0,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(eduData[index]["firstLabel"],
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w500
                                                )),
                                            SizedBox(height: 5.0),
                                            Text(eduData[index]["secondLabel"],
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
                                            },
                                            itemBuilder:(BuildContext context) =>_pop)
                                      ],
                                    ), )

                              )
                          )
                      )
                  );
                }
            ),),
          InkWell(
              splashColor: Colors.purple[100],
              child:Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 30.0,),
                    Icon(Icons.add,
                      color: Colors.blue[700],
                    ),
                    SizedBox(width:3.0),
                    Text("Add Education",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue[700]
                      ),),
                  ],
                ),),
              onTap:(){
                navigateToDetailsScreen("School","Degree","study");
              }
          ),
          SizedBox(height:25.0),
          Padding(
            padding: EdgeInsets.only(left:15.0,bottom: 15.0),
            child: Text("Websites and Social Links",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Padding(
              padding: EdgeInsets.only(left:15.0,bottom: 15.0,right: 15.0),
              child:
              Text("Add links to websites you want hiring managers to see(e.g Linkedln profile,personal website)",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300
                ),)
          ),
            Container(
            height: _linkListHeight,
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: _linkCount,
                itemBuilder:(context,index){
                  return  Container(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child:GestureDetector(
                              child:Card(
                                  elevation: 5.0,
                                  child:Padding(padding: EdgeInsets.only(left:10.0,top:10.0,bottom: 10.0),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Container(
                                          child:Image(
                                              image:AssetImage(_linkImageUri)),
                                          width: 40.0,
                                          height: 40.0,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(linkData[index]["firstLabel"],
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w500
                                                )),
                                            SizedBox(height: 5.0),
                                            Text(linkData[index]["secondLabel"],
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
                                            },
                                            itemBuilder:(BuildContext context) =>_pop)
                                      ],
                                    ), )

                              )
                          )
                      )
                  );
                }
            ),),
          InkWell(
            splashColor: Colors.purple[100],
            child:Container(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            SizedBox(width: 30.0,),
            Icon(Icons.add,
            color: Colors.blue[700],
            ),
            SizedBox(width:3.0),
            Text("Add Link",
            style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Colors.blue[700]
            ),),
            ],
            ),),
              onTap:(){
                navigateToLinksScreen();
              }
          ),

          SizedBox(height: 30.0),
          Padding(
            padding: EdgeInsets.only(left:15.0,bottom: 15.0),
            child: Text("Skills",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Container(
            height: _skillsListHeight,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _skillsCount,
                itemBuilder:(context,index){
                  return  Container(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child:GestureDetector(
                              child:Card(
                                  elevation: 5.0,
                                  child:Padding(padding: EdgeInsets.only(left:10.0,top:10.0,bottom: 10.0),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Container(
                                          child:Image(
                                              image:AssetImage(_skillsImageUri)),
                                          width: 40.0,
                                          height: 40.0,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(skillData[index]["firstLabel"],
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w500
                                                )),
                                            SizedBox(height: 5.0),
                                            Text(skillData[index]["secondLabel"],
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
                                            },
                                            itemBuilder:(BuildContext context) =>_pop)
                                      ],
                                    ), )

                              )
                          )
                      )
                  );
                }
            ),),
          InkWell(
              splashColor: Colors.purple[100],
              child:Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 30.0,),
                    Icon(Icons.add,
                      color: Colors.blue[700],
                    ),
                    SizedBox(width:3.0),
                    Text("Add Skills",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue[700]
                      ),),
                  ],
                ),),
              onTap:(){
                navigateToSkillsScreen();
              }
          ),
          SizedBox(height: 50,)
        ],
        );
      })
    );
  }
  void navigateToDetailsScreen(String firstLabel, String secondLabel,String hintText) async {
    Map result = await Navigator.push(context, MaterialPageRoute(
      builder: (context)  => JobsEduScreen(firstLabel,secondLabel,hintText),
    )
    );
    if(result.isNotEmpty){
      if(result['hintText'] == 'work'){
        debugPrint("enter");
        setState(() {
          jobData.add(result);
          _jobCount += 1;
          _jobListHeight += 100.0;
        });
      }else if(result['hintText'] == 'study'){
        debugPrint('entered');
        setState(() {
          eduData.add(result);
          _eduCount += 1;
          _eduListHeight += 100.0;
        });
      }

    }
  }
  void navigateToSkillsScreen() async {

    Map result = await Navigator.push(context, MaterialPageRoute(
      builder: (context)  => SkillsScreen(),
    )
    );
    if(result.isNotEmpty){
      setState(() {
        skillData.add(result);
        _skillsCount += 1;
        _skillsListHeight += 100.0;
      });
    }
  }
  void navigateToLinksScreen() async {
    Map result = await Navigator.push(context, MaterialPageRoute(
      builder: (context)  => LinksScreen()
    )
    );
    if(result.isNotEmpty){
      setState(() {
        linkData.add(result);
        debugPrint(result["firstLabel"]);
        _linkCount += 1;
        _linkListHeight += 100.0;
      });
    }
  }
}

