import 'package:ankunv2_flutter/data/api_services.dart';
import 'package:flutter/material.dart';
import 'package:ankunv2_flutter/constants.dart';

class SeasonScreen extends StatefulWidget {
  const SeasonScreen({super.key});

  @override
  State<SeasonScreen> createState() => SeasonScreenState();
}
class SeasonScreenState extends State<SeasonScreen> {
  var currSeason = '';
  var currPage = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
        child: FutureBuilder<List> (
          future: ApiService.getSeasons(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (currSeason == '') {
                currSeason = snapshot.data!.first;
              }
              return Column(
                  children: [
                    SizedBox(
                      height: AppBar().preferredSize.height,
                    ),
                    Column(
                      children: [
                        SeasonDropdownMenu(seasons: snapshot.data!, onSelectItem: (String value) {
                          if (currSeason != value) {
                            setState(() {
                              currSeason = value;
                              currPage = '1';
                            });
                          }
                        }),
                        const SizedBox(height: 14),
                        ChangePageMenu(pageNum: int.parse(currPage), onPageChange: (String value) {
                          if (currPage != value) {
                            setState(() {
                              currPage = value;
                            });
                          }
                        }),
                      ],
                    ),
                    const SizedBox(height: 14,),
                    Flexible(child: GridList(currSeason: currSeason, currPage: currPage))
                  ],
              );
            }
            else if (snapshot.hasError) {
              Constants.scaffoldMessageToast(context, Text(snapshot.error.toString()));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      )
    );
  }
}

class SeasonDropdownMenu extends StatefulWidget {
  final List seasons;
  final ValueChanged<String> onSelectItem;
  const SeasonDropdownMenu({required this.seasons, required this.onSelectItem, super.key});

  @override
  State<SeasonDropdownMenu> createState() => SeasonDropdownMenuState();
}
class SeasonDropdownMenuState extends State<SeasonDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 60,
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          value: widget.seasons.first,
          borderRadius: Constants.textFieldBorderRadius,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: Constants.textFieldBorderRadius
              ),
              labelText: 'Season'
          ),
          onChanged: (String? value) {
            widget.onSelectItem(value!);
          },
          items: widget.seasons.map((e) {
            return DropdownMenuItem(
              value: e.toString(),
              child: Text(e.toString()),
            );
          }).toList(),
        )
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

class GridList extends StatefulWidget {
  final String currSeason;
  final String currPage;
  const GridList ({required this.currSeason, super.key, required this.currPage});

  @override
  GridListState createState() => GridListState();
}
class GridListState extends State<GridList> {
  @override
  Widget build(BuildContext context) {
    var selectedSeason = widget.currSeason.toLowerCase().replaceAll(' ', '-');
    return FutureBuilder<List> (
      future: ApiService.getSearchList(season: selectedSeason, page: widget.currPage),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9/13),
              itemBuilder: (_, index) {
                return ThumbnailCard(dataImage: snapshot.data![index][2], dataText: snapshot.data![index][0], dataIsDub: snapshot.data![index][3]);
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

class ThumbnailCard extends StatelessWidget {
  final String dataImage;
  final String dataText;
  final int dataIsDub;
  const ThumbnailCard({required this.dataImage, required this.dataText, required this.dataIsDub, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  image: NetworkImage(
                      dataImage),
                  fit: BoxFit.cover,
                ),
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
              child: Text(
                dataText,
                style: Constants.primarySmallTextStyle,
              ),
            )
          ],
        )
    );
  }
}