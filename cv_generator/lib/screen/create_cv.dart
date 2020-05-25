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

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';


class CreateCv extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CreateCvState();

}

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

class _CreateCvState extends State<CreateCv> {

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController  = TextEditingController();
  TextEditingController _emailController  = TextEditingController();
  TextEditingController _phoneNoController  = TextEditingController();
  TextEditingController _addressController  = TextEditingController();
  TextEditingController  controller = TextEditingController();



  final pdf = pw.Document();

  final pw.Document doc = pw.Document(title: 'My Résumé', author: 'David PHAM-VAN');

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



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.done), onPressed: () async{
           /* generateResume(PdfPageFormat.a4);*/
            writeOnPdf();
            await savePdf();
            Directory documentDirectory = await getApplicationDocumentsDirectory();
            String documentPath = documentDirectory.path;
            String fullPath = "$documentPath/example.pdf";
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => PDFViewScreen(fullPath,pdf)
            ));

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
              controller: controller,
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
  void writeOnPdf() async {
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) => <pw.Widget>[
                                pw.Text(_firstNameController.text + " " + _lastNameController.text,
                                    textScaleFactor: 2.1,
                                    style: pw.Theme.of(context)
                                        .defaultTextStyle
                                        .copyWith(fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(height:30.0),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: <pw.Widget>[
                                      pw.Column(
                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                          children: <pw.Widget>[
                                            pw.Row(
                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                children: <pw.Widget>[
                                                  pw.Text('Email:',
                                                      textScaleFactor: 1.5),
                                                  pw.SizedBox(width: 5.0),
                                                  _UrlText(_emailController.text,
                                                      'mailto:'+ _emailController.text),
                                                ]),
                                            pw.SizedBox(height: 10.0),
                                            pw.Row(
                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                children: <pw.Widget>[
                                                  pw.Text('Phone: ',
                                                      style: pw.TextStyle(
                                                        fontSize: 15.0,
                                                      )),
                                                  pw.SizedBox(width: 3.0),
                                                  pw.Text(_phoneNoController.text,
                                                      style: pw.TextStyle(
                                                        fontSize: 15.0,
                                                      ))
                                                ]),
                                            pw.SizedBox(height: 5.0),
                                            pw.RichText(text: pw.TextSpan(
                                                text: _addressController.text,
                                                style: pw.TextStyle(
                                                    fontSize: 15.0,
                                                    color: PdfColors.black
                                                )
                                            )
                                            ),
                                          ]),
                                      pw.ListView.builder(
                                        itemCount: linkData.length,
                                        itemBuilder: (context,index){
                                          return  pw.Column(
                                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                                              children: <pw.Widget>[
                                                pw.Row(
                                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                    children: <pw.Widget>[
                                                      pw.Text(linkData[index]['firstLabel']+ ";",
                                                          style: pw.TextStyle(
                                                            fontSize: 15.0,
                                                          )),
                                                      pw.SizedBox(width: 3.0),
                                                      _UrlText(linkData[index]['secondLabel'],
                                                          linkData[index]['secondLabel']),
                                                    ]
                                                ),
                                                pw.SizedBox(height: 6.0),
                                              ]
                                          );
                                        }, ),
                                    ]),
                                pw.SizedBox(height: 8.0),
                                pw.Container(
                                    width: double.infinity,
                                    height: 2,
                                    color: PdfColors.grey
                                ),
                                pw.RichText(text: pw.TextSpan(
                                    text: controller.text,
                                    style: pw.TextStyle(
                                        fontSize: 15.0,
                                        color: PdfColors.black
                                    )
                                )
                                ),
                                pw.SizedBox(height: 10.0),
                                _Category(jobData,"Work Experience"),
                                _Block(data: jobData),
                                _Category(eduData, 'Education'),
                                _Block(data: eduData),
                                _Category(skillData, "Skills"),
                                _Skill(data: skillData)


          ]
    )
    );

  }



  Future savePdf() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(pdf.save());
  }

}

class _UrlText extends pw.StatelessWidget {
  _UrlText(this.text, this.url);

  final String text;
  final String url;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(text,
          style: const pw.TextStyle(
            fontSize: 15.0,
            decoration: pw.TextDecoration.underline,
            color: PdfColors.blue,
          )),
    );
  }
}

class _Block extends pw.StatelessWidget {
  _Block({this.data});
  final List data;

  @override
  pw.Widget build(pw.Context context) {
    return pw.ListView.builder(
      itemCount: data.length,
        itemBuilder: (context,index){
      return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(width: 6, height: 6,
                    margin: const pw.EdgeInsets.only(top: 2.5, left: 2, right: 5),
                    decoration: const pw.BoxDecoration(shape: pw.BoxShape.circle,
                        color: PdfColors.indigo),
                  ),
                  pw.Text(data[index]['firstLabel'],
                      textScaleFactor: 1.7,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold
                  )),
                ]),
            pw.Container(
              decoration: const pw.BoxDecoration(
                  border: pw.BoxBorder(left: true, color: PdfColors.indigo, width: 2)),
              padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
              margin: const pw.EdgeInsets.only(left: 5),
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: <pw.Widget>[
                    pw.Text(data[index]['secondLabel'],
                        textScaleFactor: 1.5),
                    pw.SizedBox(height: 4.0),
                    pw.Text(' ' + data[index]['startDate'] + ' - '+ data[index]['endDate'] ,
                        textScaleFactor: 1.5),
                  ]),
            ),
          ]);
    });
  }
}

class _Category extends pw.StatelessWidget {
  final String title;
  final List data;

  _Category(this.data,this.title);

  @override
  pw.Widget build(pw.Context context) {
      if(data.isNotEmpty){
        return pw.Container(
            decoration: const pw.BoxDecoration(color: lightGreen, borderRadius: 6),
            margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
            padding: const pw.EdgeInsets.fromLTRB(10, 7, 10, 4),
            child: pw.Text(title, textScaleFactor: 1.8));
      }else{
        return pw.Container(
          height: 0.0
        );
      }
  }
}


class _Skill extends pw.StatelessWidget {
  _Skill({this.data});
  final List data;

  @override
  pw.Widget build(pw.Context context) {
    return pw.ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index){
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Container(width: 6, height: 6,
                        margin: const pw.EdgeInsets.only(top: 2.5, left: 2, right: 5),
                        decoration: const pw.BoxDecoration(shape: pw.BoxShape.circle,
                            color: PdfColors.indigo),
                      ),
                      pw.Text(data[index]['firstLabel'],
                          style: pw.TextStyle(
                              fontSize: 20.0
                          )),
                    ]),
                pw.Container(
                  decoration: const pw.BoxDecoration(
                      border: pw.BoxBorder(left: true, color: PdfColors.indigo, width: 2)),
                  padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  margin: const pw.EdgeInsets.only(left: 5),
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Text(data[index]['secondLabel'],
                            style: pw.TextStyle(
                              fontSize: 15.0,
                            )),
                        pw.SizedBox(width: 4.0),
                      ]),
                ),
              ]);
        });
  }
}




