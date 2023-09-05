import 'package:flutter/material.dart';
import 'package:ankunv2_flutter/constants.dart';
import 'package:ankunv2_flutter/data/api_services.dart';
import 'package:ankunv2_flutter/screens/details/details_screen.dart';

class RecentUpdatesScreen extends StatefulWidget {
  const RecentUpdatesScreen({super.key, required this.title, required this.isDub});
  final String title;
  final String isDub;

  @override
  State<RecentUpdatesScreen> createState() => RecentUpdatesScreenState();
}
class RecentUpdatesScreenState extends State<RecentUpdatesScreen> {
  var currPage = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
        child: Column(
          children: [
            ChangePageMenu(
                pageNum: int.parse(currPage),
                onPageChange: (String value) {
                  if (currPage != value) {
                    setState(() {
                      currPage = value;
                    });
                  }
                }
            ),
            const SizedBox(height: 14,),
            Flexible(
              child: ItemList(currPage: currPage, isDub: widget.isDub == 'sub' ? 0 : 1,),
            )
          ],
        ),
      ),
    );
  }
}

class ChangePageMenu extends StatefulWidget {
  final ValueChanged<String> onPageChange;
  final int pageNum;
  const ChangePageMenu({required this.pageNum, required this.onPageChange, super.key});

  @override
  ChangePageMenuState createState() => ChangePageMenuState();
}
class ChangePageMenuState extends State<ChangePageMenu> {
  void incrementPageNum(int pageNum) {
    setState(() {
      pageNum++;
    });
    widget.onPageChange(pageNum.toString());
  }

  void decrementPageNum(int pageNum) {
    setState(() {
      if (pageNum > 1) { pageNum--; }
    });
    widget.onPageChange(pageNum.toString());
  }

  @override
  Widget build(BuildContext context) {
    int pageNum = widget.pageNum;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: pageNum > 1 ? () {
            decrementPageNum(pageNum);
          } : null,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Constants.darkBlue;
                }
                else if (!states.contains(MaterialState.disabled)) {
                  return Constants.lightBlue;
                }
                return null;
              })
          ),
          child: Text('Prev', style: pageNum > 1 ? Constants.primaryTextStyleClickable : null),
        ),
        const SizedBox(
          width: 40,
        ),
        Text('$pageNum'),
        const SizedBox(
          width: 40,
        ),
        ElevatedButton(
          onPressed: () {
            incrementPageNum(pageNum);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Constants.darkBlue;
                }
                else if (!states.contains(MaterialState.disabled)) {
                  return Constants.lightBlue;
                }
                return null;
              })
          ),
          child: const Text('Next', style: Constants.primaryTextStyleClickable),
        )
      ],
    );
  }}

class ItemList extends StatefulWidget {
  const ItemList({super.key, required this.currPage, required this.isDub});
  final String currPage;
  final int isDub;

  @override
  State<ItemList> createState() => ItemListState();
}
class ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: ApiService.getRecentUpdatesList(page: widget.currPage, mode: widget.isDub == 0 ? 'sub' : 'dub'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9/13),
              itemBuilder: (_, index) {
                var relativeTime = Constants.getRelativeTimeFromEpoch(snapshot.data![index][5]);
                return ItemCard(dataId: snapshot.data![index][1], dataImage: snapshot.data![index][4], dataTitle: snapshot.data![index][0], dataIsDub: widget.isDub, dataReleased: relativeTime,);
              },
            );
          }
          else if (snapshot.hasError) {
            Constants.scaffoldMessageToast(context, Text(snapshot.error.toString()));
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.dataImage, required this.dataTitle, required this.dataId, required this.dataIsDub, required this.dataReleased});
  final String dataImage;
  final String dataTitle;
  final int dataIsDub;
  final int dataId;
  final String dataReleased;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(dataId: dataId)));
      },
      child: Card(
        elevation: 0,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(dataImage),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                    stops: const [0, 1],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  )
              ),
            ),
            dataIsDub == 0 ? Container() : Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.fromLTRB(0, 7, 7, 0),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      child: Text(
                        'DUB',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    )
                )
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataTitle,
                    style: Constants.primarySmallTextStyle,
                  ),
                  Text(
                    dataReleased,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}