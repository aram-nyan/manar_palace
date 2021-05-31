import 'package:alux/services/ListViewProvide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AppBar.dart';

class TabData {
  final String header;

  const TabData(this.header);
}

class TabPageFabril extends StatefulWidget {
  final List<TabData> tabs;
  final length;
  final List<Widget> views;
  final content;
  TabPageFabril({ Key key, this.tabs, this.views,this.content ,this.length})
      : super(key: key);

  @override
  _TabPageFabrilState createState() => _TabPageFabrilState();
}

class _TabPageFabrilState extends State<TabPageFabril> with TickerProviderStateMixin {
  TabController _controller;

  List<TabData> tabs = [];
  void initState() {
    super.initState();
    var p = Provider.of<ListViewProvider>(context,listen: false);
    retrieveTabs(p.categoriesFabrikat);
  }
  Future retrieveTabs(cats)async{
    cats.forEach((element) {
      tabs.add(TabData(element.categoryName));
    });
    _controller = TabController(length: tabs.length, vsync: this);
    _controller.addListener(() {
      Provider.of<ListViewProvider>(context,listen: false).goToIndexFabrik(_controller.index);
    },);
  }

  Widget build(BuildContext context) {
    var provide = Provider.of<ListViewProvider>(context);
    return Scaffold(
      appBar: AluxAppBar(
        bottom: PreferredSize(
          preferredSize: provide.isSearchMode ? Size.fromHeight(100) : Size.fromHeight(40),
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                height: provide.isSearchMode ? 50 : 0,
                child: provide.isSearchMode ?  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffEDEDED),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    height: 52,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: TextField(
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(
                            prefixIcon: GestureDetector(
                                onTap: (){

                                },
                                child: Icon(Icons.search)),
                            focusColor: Colors.white,
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            hintText: 'Поиск',
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xffEDEDED),
                          ),
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            color: Colors.black,
                          ),
                          onChanged: (search){
                            provide.filterSearchResultsFabricat(search);
                          }
                      ),
                    ),
                  ),
                ) : SizedBox(),
              ),
              TabBar(
                controller: _controller,
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
                indicatorColor: Colors.transparent,
                tabs: tabs.map((tab) {
                  final index = tabs.indexOf(tab);
                  final isCurrent = index == _controller.index;
                  return Container(
                      alignment: Alignment.center,
                      child: Text(tab.header,
                          style: TextStyle(
                              color: isCurrent
                                  ? Theme.of(context).textTheme.bodyText1.color
                                  : Color.fromRGBO(0xA8, 0x67, 0x26, 1.0)
                          )
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          color: isCurrent
                              ? Color.fromRGBO(0xA8, 0x67, 0x26, 1.0)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(40),
                          border: Border(
                            left: BorderSide(color: Color.fromRGBO(0xA8, 0x67, 0x26, 1.0), width: 2),
                            top: BorderSide(color: Color.fromRGBO(0xA8, 0x67, 0x26, 1.0), width: 2),
                            bottom: BorderSide(color: Color.fromRGBO(0xA8, 0x67, 0x26, 1.0), width: 2),
                            right: BorderSide(color: Color.fromRGBO(0xA8, 0x67, 0x26, 1.0), width: 2),
                          )
                      )
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),

      body: widget.content,
    );
  }
}
