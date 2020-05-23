import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SkillsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SkillsScreenState();

}

class _SkillsScreenState extends State<SkillsScreen> {

  final _expertise_level = ['Novice', 'Beginner', 'Skillful','Experienced', 'Expert'];
  bool isSwitched = true;
  String _value ;
  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerSkill  = TextEditingController();
    return Scaffold(
      appBar: AppBar(

      ),
      body: ListView(children: <Widget>[
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50.0,),
            Padding(
              padding: EdgeInsets.only(left:10.0,right: 10.0,bottom: 10.0),
              child: TextField(
                controller: _controllerSkill,
                decoration: InputDecoration(
                    labelText: "Skill" ,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.text,
              ),
            ),

            showDropDownList(),
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left:10,right: 10.0),
                  child: CupertinoSwitch(
                    value: isSwitched,
                    onChanged: (bool value) {
                      setState(() {
                        isSwitched = value;

                      });
                    },
                  ),
                ),
                Text('Show Expertise',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87
                  ),),
              ],
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
                      if(_value == null){
                        _value = "";
                      }
                      if(_controllerSkill.text.isNotEmpty){
                            Map map = {'firstLabel': _controllerSkill.text, 'secondLabel': _value};

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

  Widget showDropDownList(){
    if(isSwitched){
      return  Padding(padding: EdgeInsets.all(20.0),
        child: DropdownButton<String>(
            isExpanded: true,
            hint: Text('Expertise'),
            items: _expertise_level.map((String value){
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: _value,
            onChanged: (String value){
              _onTypeChanged(value);
            }
        ),
      );
    }else{
      return Container(
        height: 0.0,
      );
    }
  }

  _onTypeChanged(String val){
    setState(() {
      this._value = val;

    });
  }
}











