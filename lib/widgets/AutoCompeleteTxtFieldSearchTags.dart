import 'package:dating_app/screens/global_search_screen/global_search.dart';
import 'package:dating_app/resourses/colors.dart';
import 'package:dating_app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AutoCompeleteTextFieldSearchTags extends StatefulWidget {
  final List suggestions;
  final InputDecoration decoration;
  final double listElevation;
  final double barElevation;
  final double width;
  final onTextSubmited;
  final bool collapsed;
  final Color background;
  final BorderRadius borderRidus;
  final TextEditingController controller;
  final TextStyle style;
  final AppStatesInterface appStates;
  AutoCompeleteTextFieldSearchTags({Key key, @required this.appStates, @required this.suggestions, this.decoration, this.listElevation, this.barElevation = 0.0, this.width, this.onTextSubmited(String value), this.collapsed, this.background = Colors.transparent, this.borderRidus, this.controller, this.style});

  @override
  _MACTextFieldState createState() => _MACTextFieldState();
}

class _MACTextFieldState extends State<AutoCompeleteTextFieldSearchTags> {
  List<String> _list = [];
  List<String> tempList;
  var _size;
  var view;
  double _listHight;
  FocusNode focusNode = FocusNode();

  TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    _size = 0;
    _listHight = 0.0;
    print(_list);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          Theme(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: widget.borderRidus == null ? BorderRadius.circular(0) : widget.borderRidus),
              margin: EdgeInsets.all(0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TextField(
                    keyboardType: TextInputType.multiline,
                    cursorColor: Colors.black,
                    focusNode: focusNode,
                    cursorWidth: 1,
                    controller: widget.controller,
                    style: widget.style,
                    decoration: widget.decoration,
                    onChanged: (val) => _suggestionsFilter(val),
                    onSubmitted: (val) => widget.onTextSubmited(val),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.controller.text.isNotEmpty
                              ? widget.appStates.filledSearchTags.value.add(
                                  FilledTagSearch(
                                    tag: widget.controller.text,
                                  ),
                                )
                              : FocusScope.of(context).requestFocus(focusNode);
                        });
                        widget.appStates.filledSearchTags.refresh();
                        widget.controller.clear();
                      },
                      icon: SvgPicture.asset(
                        'assets/images/plus.svg',
                        color: AppColors.orange,
                        width: 12,
                      ),
                    ),
                  ),
                ],
              ),
              color: widget.background,
              elevation: (widget.background == null || widget.background == Colors.transparent) ? 0.0 : widget.barElevation,
            ),
            data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          ),
          (widget.collapsed == null || widget.collapsed == false)
              ? Card(
                  elevation: widget.listElevation,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Container(
                      transform: Matrix4.translationValues(0, _listHight * _size, 0),
                      height: _size * 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: _suggestionList(_list)),
                )
              : Container(
                  child: _suggestionList(_list),
                  height: 40.0,
                )
        ],
      ),
      width: widget.width,
    );
  }

  Widget _suggestionList(List sList) {
    return ScrollConfiguration(
      child: ListView.builder(scrollDirection: (widget.collapsed == null || widget.collapsed == false) ? Axis.vertical : Axis.horizontal, itemCount: sList.length, padding: EdgeInsets.only(top: 0), primary: true, itemBuilder: (context, indx) => (widget.collapsed == null || widget.collapsed == false) ? _nonCollapsed(sList, indx) : _collapsed(sList, indx)),
      behavior: NoGlow(),
    );
  }

  Widget _nonCollapsed(List sList, indx) {
    AppStates appStates = Get.put(AppStates());
    return ListTile(
      title: Text(sList[indx].toString()),
      onTap: () {
        setState(() {
          appStates.filledSearchTags.value.add(FilledTagSearch(tag: sList[indx].toString()));
          widget.controller.clear();
          _list.clear();
          _size = 0.0;
        });
        appStates.filledSearchTags.refresh();
      },
      onLongPress: () {
        _controller.text = sList[indx].toString();
        setState(() {
          _list.clear();
          _size = 0.0;
        });
      },
    );
  }

  Widget _collapsed(List sList, indx) {
    return GridTile(
        child: GestureDetector(
      child: Padding(
        child: Container(
          child: Center(
            child: Text(sList[indx].toString()),
          ),
        ),
        padding: EdgeInsets.only(right: 8, left: 8),
      ),
      onTap: () {
        setState(() {
          _list.clear();
          _size = 0.0;
        });
      },
      onLongPress: () {
        widget.controller.text = sList[indx].toString();
        setState(() {
          _list.clear();
          _size = 0.0;
        });
      },
    ));
  }

  void _suggestionsFilter(txtValue) {
    _list.clear();
    for (var value in widget.suggestions) {
      if (txtValue != '' && _igonreCaseSenstivity(value, txtValue)) {
        _list.add(value);
        view = _suggestionList(_list);
      }
    }
    setState(() {
      _size = _list.length;
    });
  }

  bool _igonreCaseSenstivity(String value, String txtValue) {
    var exprsion = (value.toLowerCase().startsWith(txtValue.toString().toLowerCase()) || value.toLowerCase().startsWith(txtValue.toString().toLowerCase()));
    return exprsion;
  }
}

class NoGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) => child;
}
