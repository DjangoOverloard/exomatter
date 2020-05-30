import 'dart:io';

import 'package:exom/posts/postPage.dart';
import 'package:exom/widgets/container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exom/homeFuncs.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

TextEditingController tagControl = new TextEditingController();
 var usedLinks = [];
 var images = [];
var temp = '';
class PostCreation extends StatefulWidget {
  final inHero;

  const PostCreation({Key key, this.inHero}) : super(key: key);
  @override
  _PostCreationState createState() => _PostCreationState();
}

class _PostCreationState extends State<PostCreation> {
  bool snackbaractive = false;
  String selectedTag = '';
 getPath() async {
    temp = (await getTemporaryDirectory()).path;
  }
  @override
  void initState(){
    if(temp == ''){
      getPath();
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Hero(
      tag: 'postCreation',
      child: Material(
        color: Colors.white,
        borderRadius:
            widget.inHero ? BorderRadius.circular(0) : BorderRadius.circular(4),
        child: GestureDetector(
          onTap: (){
                                      if (!widget.inHero) {
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => CreationHero(),
                            ));
                          }
          },
                  child: ExContainer(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 16.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              userDoc.data['nickname'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.teal),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  widget.inHero
                      ? Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Post Title',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 45,
                        maxHeight: widget.inHero ? 90 : 45,
                      ),
                      child: TextField(
                        onTap: (){
                                     if (!widget.inHero) {
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => CreationHero(),
                            ));
                          }
                        },
                        readOnly: !widget.inHero,
                        maxLines: null,
                        maxLength: 60,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Want to write a post? Start from a title.',
                        ),
                      ),
                    ),
                  ),
                  widget.inHero
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text('Short Description',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Container(
                                constraints: BoxConstraints(
                                  minHeight: 45,
                                  maxHeight: 235,
                                ),
                                child: TextField(
                                  maxLength: 500,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          'Enter a short description for your activity'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text('Links',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 200),
                              child: usedLinks.length != 0
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Wrap(
                                          runSpacing: 10,
                                          spacing: 10,
                                          children: List.generate(usedLinks.length,
                                              (index) {
                                            return Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: Colors.teal,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(usedLinks[index].length>60?usedLinks[index].substring(0, 60)+'...'
                                                        :usedLinks[index],
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              height: 1.0,
                                                              color: Colors.white,
                                                            ), ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              usedLinks.remove(
                                                                  usedLinks[
                                                                      index]);
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .black38,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 15),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })),
                                    )
                                  : SizedBox.shrink(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: TextField(
                                onChanged: (val){
                                  if(val.trim().length == 0||val.trim().length == 1){
                                    setState((){});
                                  }
                                },
                                controller: tagControl,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter a link (articles)',
                                ),
                              ),
                            ),
                            tagControl.text.trim().length!=0?Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: (){
                                  final val = tagControl.text.trim();
                                    if (usedLinks.indexWhere((d) =>
                                            d.toLowerCase() ==
                                            val.toLowerCase()) ==
                                        -1 && RegExp(linkregex).hasMatch(val)) {
                                      usedLinks.add(val);
                                      setState(() {});
                                      tagControl.clear();
                                    } else {
                                      tagControl.clear();
                                      if (!snackbaractive) {
                                        snackbaractive = true;
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  Colors.blueGrey[900],
                                              content: Text(
                                                  'You either repeated the link or entered invalid url',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  )),
                                              action: SnackBarAction(
                                                label: 'OK',
                                                textColor: Colors.teal,
                                                onPressed: () {
                                                  Scaffold.of(context)
                                                      .hideCurrentSnackBar();
                                                },
                                              ),
                                            ))
                                            .closed
                                            .then((done) {
                                          snackbaractive = false;
                                        });
                                      }
                                    }
                                },
                                                            child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.teal, 
                                    borderRadius: BorderRadius.circular(5), 
                                  ),
                                  height: 40, 
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text('Enter', style: TextStyle(
                                          color: Colors.white, 
                                          fontSize: 16, 
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ):SizedBox.shrink(),
                                                   Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text('Photos',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Wrap(
                                runSpacing: 10,
                                children:List.generate(images.length!=3?images.length+1:3, (index){
                                  return Padding(
                                    padding: EdgeInsets.only(right: (index+1).isOdd?10:0),
                                                                      child: index!=images.length?Container(
                                      width: (w - 42)/2,
                                      height: 100, 
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Stack(
                                          children: <Widget>[
                                            Center(
                                              child: Image(
                                                  height: 100, 
                                                  width: (w-26)/2,
                                                  fit: BoxFit.cover,
                                                  image: FileImage(images[index]),
                                                ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding: EdgeInsets.only(top: 5, right: 5),
                                                child: GestureDetector(
                                                  onTap: (){
                                                    File fileToRemove = images[index];
                                                    images.remove(images[index]);
                                                    setState((){});
                                                    fileToRemove.deleteSync();
                                                  },
                                                                                                  child: Container(
                                                    height: 20, 
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black38, 
                                                      shape: BoxShape.circle, 
                                                    ),
                                                    child: Center(
                                                      child: Icon(Icons.delete, color: Colors.red, size: 15),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ):GestureDetector(
                                      onTap: (){
                                       MultiImagePicker.pickImages(maxImages: 3 - images.length).then((files) {
      var iterator = 0;
      files.forEach((g) async {
        final byteData = await g.getByteData();
        var date = DateTime.now();
        // var orderId = messages[messages.indexWhere((d)=>d.data['storeNumber'] == widget.storeNumber)].data['storeName'];
        final file = File('$temp/pic#${iterator}Date$date.jpg');
        await file.writeAsBytes(byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
        images.add(file);
        setState(() {});
        iterator = iterator + 1;
      });
    });
                                      },
                                                                          child: Container(
                                        height: 100, 
                                        width: (w - 42)/2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5), 
                                          color: Colors.white, 
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26, 
                                              blurRadius: 2, 
                                              offset: Offset(0.0, 1.0), 
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Icon(Icons.image, color: Colors.teal,size: 20),
                                              Icon(Icons.add, color: Colors.teal, size: 20)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ); 
                                })
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(selectedTag != ''?'Tag':'Select a tag',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                                                          child: selectedTag == ''? Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: List.generate(tagDoc.data['tags'].length, (index){
                                  return Container(
                                    height: 30, 
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(tagDoc.data['tags'][index], style: TextStyle(
                                            color: Colors.white, fontSize: 16, height: 1.0, 
                                          )),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ):Container(
                                height: 30, 
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(selectedTag, style: TextStyle(
                                        color: Colors.white, fontSize: 16
                                      )),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                                                              child: Container(
                                          height: 20, 
                                          width: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle, 
                                            color: Colors.black38, 
                                          ),
                                          child: Center(
                                            child: Icon(Icons.close, color: Colors.red, size: 20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Opacity(
                                opacity: 0.3,
                                child: Container(
                                  height: 45,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text('Send',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CreationHero extends StatefulWidget {
  @override
  _CreationHeroState createState() => _CreationHeroState();
}

class _CreationHeroState extends State<CreationHero> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Post Creation'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 200),
        child: PostCreation(
          //
          inHero: true,
        ),
      ),
    );
  }
}

final linkregex = r"(?:(?:https?|ftp):\/\/|\b(?:[a-z\d]+\.))(?:(?:[^\s()<>]+|\((?:[^\s()<>]+|(?:\([^\s()<>]+\)))?\))+(?:\((?:[^\s()<>]+|(?:\(?:[^\s()<>]+\)))?\)|[^\s`!()\[\]{};:''.,<>?«»“”‘’]))+";