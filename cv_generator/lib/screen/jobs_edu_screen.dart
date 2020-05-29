import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JobsEduScreen extends StatefulWidget {
  final String firstLabel;
  final String switchHintText;
  final String secondLabel;

  const JobsEduScreen(this.firstLabel, this.secondLabel,this.switchHintText);

  @override
  State<StatefulWidget> createState() {
    return _JobsEduScreenState();
  }
}

class _JobsEduScreenState extends State<JobsEduScreen> {
  TextEditingController _controllerOne = TextEditingController();
  TextEditingController _controllerTwo = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(),
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                  child: TextField(
                    controller: _controllerOne,
                    decoration: InputDecoration(
                        labelText: widget.firstLabel,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding:
                      EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                  child: TextField(
                    controller: _controllerTwo,
                    decoration: InputDecoration(
                        labelText: widget.secondLabel,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _startDateController,
                            onTap: () {
                              _selectDate(context, 1);
                            },
                            decoration: InputDecoration(
                                labelText: 'Start Date',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _endDateController,
                            onTap: () {
                              _selectDate(context, 2);
                            },
                            decoration: InputDecoration(
                                labelText: 'End Date',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                    ]),
                       Row(
                         children: <Widget>[
                           Padding(padding: EdgeInsets.only(left:10,right: 10.0),
                             child: CupertinoSwitch(
                               value: isSwitched,
                               onChanged: (bool value) {
                                 setState(() {
                                   isSwitched = value;
                                   if(isSwitched){
                                     _endDateController.text = "Present";
                                   }else{
                                     _endDateController.text = "";
                                   }

                                 });
                               },
                             ),
                           ),
                           Text("Currently "  + widget.switchHintText +" here",
                             style: TextStyle(
                                 fontSize: 16.0,
                                 fontWeight: FontWeight.w400,
                                  color: Colors.black87
                             ),),
                         ],
                       ),
                Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
                    child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                            child: Text(
                              'Update',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            color: Colors.blue[500],
                            splashColor: Colors.indigo,
                            textColor: Colors.white,
                            onPressed: () {
                              if(_controllerOne.text.isNotEmpty && _controllerTwo.text.isNotEmpty
                                  && _startDateController.text.isNotEmpty && _endDateController.text.isNotEmpty
                              ){
                                Map map = {'firstLabel': _controllerOne.text, 'secondLabel': _controllerTwo.text,
                                  'startDate': _startDateController.text, 'endDate': _endDateController.text,'hintText': widget.switchHintText};
                                Navigator.pop(context,map);
                              }else{
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                    'Please fill empty fields',
                                  ),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            }
                            )
                    )
                ),
              ],
            ),
          ],
        ));
  }

  Future<Null> _selectDate(BuildContext context, int num) async {
    DateTime _currentDate = new DateTime.now();
    final DateTime _selDate = await showDatePicker(
        context: context,
        initialDate: _currentDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2030),
        builder: (context, child) {
          return SingleChildScrollView(child: child);
        });
    if (_selDate != null) {
      setState(() {
        String formattedDate = new DateFormat.yMMM().format(_selDate);
        debugPrint(formattedDate);

        if (num == 1) {
          _startDateController.text = formattedDate;
        } else {
          _endDateController.text = formattedDate;
        }
      });
    }
  }
}
