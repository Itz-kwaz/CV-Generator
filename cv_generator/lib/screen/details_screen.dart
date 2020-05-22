import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _DetailsScreenState();
  }

}

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController _controllerOne  = TextEditingController();
  TextEditingController _controllerTwo= TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController  _endDateController = TextEditingController();
  String _firstLabel = "School";
  String _secondLabel = "Degree";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0,),
          Padding(
            padding: EdgeInsets.only(left:10.0,right: 10.0,bottom: 15.0),
            child: TextField(
              controller: _controllerOne,
              decoration: InputDecoration(
                  labelText: _firstLabel ,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              keyboardType: TextInputType.text,
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left:10.0,right: 10.0,bottom: 15.0),
            child: TextField(
              controller: _controllerTwo,
              decoration: InputDecoration(
                  labelText: _secondLabel ,
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
                    child:TextField(
                      controller: _startDateController,
                      onTap: () {
                        _selectDate(context,1);
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
                    child:TextField(
                      controller: _endDateController,
                      onTap: () {
                        _selectDate(context,2);
                      },
                      decoration: InputDecoration(
                          labelText: 'End Date',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
              ]
          ),
        ],
      ),


    );
  }


  Future<Null>_selectDate(BuildContext context,int num) async{
    DateTime _currentDate = new DateTime.now();
    final DateTime _selDate = await showDatePicker(context: context, initialDate:_currentDate, firstDate: DateTime(1990),
        lastDate: DateTime(2030),
        builder: (context,child){
          return SingleChildScrollView(child: child);
        });
    if(_selDate != null){
      setState(() {
        String formattedDate = new DateFormat.yMMM().format(_selDate);
        debugPrint(formattedDate);

        if(num == 1){
            _startDateController.text = formattedDate;
        }else{
        _endDateController.text = formattedDate;
        }

      });
    }
  }
}