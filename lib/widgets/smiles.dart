import 'package:dating_app/resourses/colors.dart';
import 'package:flutter/material.dart';
import 'package:emojis/emoji.dart';
import 'package:get/get.dart';

class SmilesWidget extends StatelessWidget {
  final BuildContext context;
  final Function(int index, Iterable<Emoji> loveEmojis) onSmileTap;
  final VoidCallback close;
  const SmilesWidget({
    @required this.context,
    @required this.onSmileTap,
    @required this.close,
  });
  Widget get smilesWidget => Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: context.mediaQuerySize.width > 500 && context.mediaQuerySize.width < 768 ? context.mediaQuerySize.height * 0.5 : context.mediaQuerySize.height * 0.42,
        padding: EdgeInsets.only(
          top: 25,
          left: 15,
          right: 15,
        ),
        child: Column(
          children: [
            Container(
              width: context.mediaQuerySize.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Выберите смайл',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: close,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
                child: SingleChildScrollView(
              child: StreamBuilder(
                stream: smileListGenerate((index, loveEmojis) => onSmileTap(index, loveEmojis)),
                builder: (_, data) {
                  if (data.hasData) {
                    return Wrap(alignment: WrapAlignment.center, spacing: 5, runSpacing: 5, children: data.data);
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              ),
            )),
          ],
        ),
      );
  Stream<List<Widget>> smileListGenerate(Function onTap(int index, Iterable<Emoji> loveEmojis)) async* {
    final loveEmojis = Emoji.byKeyword('face');
    final list = <Widget>[];
    for (final i in loveEmojis) {
      list.add(InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () => onTap(loveEmojis.toList().indexOf(i), loveEmojis),
        child: Text(
          i.toString(),
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ));
    }
    yield list;
    /* final _list = List.generate(
      loveEmojis.length,
      (_) =>,
    );
    return _list;*/
  }

  @override
  Widget build(BuildContext context) {
    return smilesWidget;
  }
}
