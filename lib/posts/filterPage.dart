import 'package:flutter/material.dart';

var included = [true, true, true, true, true, true, true, true, true, true, true, true];
class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final colors = [Colors.cyan, Colors.blue, Colors.orange,
   Colors.purple, Colors.red, Colors.indigo, Colors.green,
    Colors.green[400], Colors.blueGrey, Colors.amber, Colors.brown];
    
    var tagsList = ['pewdiepie', 'asmr', 'music', 'markiplier', 'old town road', 'pewdiepie vs t series', 'billie eilish', 'fortnite', 'david dobrik', 'jacksepticeye','james charles','joe rogan','baby shark','bts','dantdm','snl','game grumps','cnn','wwe','lofi','minecraft','shane dawson','t series','fox news','msnbc','ssundee','fgteev','lofi hip hop','mrbeast','ariana grande','stephen colbert','gacha life','flamingo','nightcore','jake paul','songs','lazarbeam','eminem','tyt','vanossgaming','taylor swift','post malone','jeffree star','memes','game of thrones','cardi b','trump','study music','avengers endgame','espn','john oliver','blackpink','coryxkenshin','juice wrld','logan paul','unspeakable','nba youngboy','try not to laugh','mr beast','roblox','dude perfect','last week tonight','peppa pig','dunkey','andrew yang','ufc','popularmmos','game theory','chad wild clay','jre','ninja','buzzfeed unsolved','drake','colbert','borderlands 3','ben shapiro','sml','projared','nfl','seth meyers','rachel maddow','itsfunneh','tik tok','undisputed','critical role','jeffy','trevor noah','trisha paytas','queen','blippi','tati','gmm','nintendo','sssniperwolf','tfue','first take','ryan’s toy review','7 rings','sunflower post malone','pokemon sword and shield',];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tags to include'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runSpacing: 10,
                    spacing: 10,
                    children: List.generate(10, (index){
                      return GestureDetector(
                        onTap: (){
                          included[index] = !included[index];
                          setState((){});
                        },
                                              child: Opacity(
                                                opacity: included[index]?1.0:0.3,
                                                                                              child: Container(
                          height: 30, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), 
                            color:colors[index],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10,),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(tagsList[index], style: TextStyle(
                                  fontSize: 18, 
                                )),
                              ],
                            ),
                          ),
                        ),
                                              ),
                      ); 
                    })
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: double.maxFinite,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Padding(
                       padding: EdgeInsets.only(right: 10),
                                            child: GestureDetector(
                                              onTap: (){
                                                included.fillRange(0, included.length, false);
                                                setState((){});
                                              },
                                                                                          child: Container(
                        height: 35, 
                        decoration: BoxDecoration(
                          color: Colors.red, 
                          borderRadius: BorderRadius.circular(4), 
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Deselect all', style: TextStyle(
                                fontSize: 18, 
                              )),
                            ],
                          ),
                        ),
                    ),
                                            ),
                     ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                                          child: Container(
                        height: 35, 
                        decoration: BoxDecoration(
                          color: Colors.teal, 
                          borderRadius: BorderRadius.circular(4), 
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Save Changes', style: TextStyle(
                                fontSize: 18, 
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ), 
    );
  }
}