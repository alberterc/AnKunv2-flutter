import 'package:ankunv2_flutter/data/api_services.dart';
import 'package:flutter/material.dart';
import 'package:ankunv2_flutter/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => SearchScreenState();
}
class SearchScreenState extends State<SearchScreen> {
  var currSearch = '';
  var currPage = '1';
  var currSearchType = '';
  var currSearchStatus = '';
  var currSearchSort = Constants.searchSorts.values.elementAt(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
        child: Column(
          children: [
            SizedBox(
              height: AppBar().preferredSize.height,
            ),
             Column(
              children: [
                SearchTextBox(onContentChanged: (String value) {
                  if (currSearch != value) {
                    setState(() {
                      currSearch = value;
                    });
                  }
                }),
                const SizedBox(height: 5),
                SearchFilterMenu(onTypeChange: (String value) {
                  setState(() {
                    if (currSearchType != value) {
                      currSearchType = value;
                    }
                  });
                }, onStatusChange: (String value) {
                  if (currSearchStatus != value) {
                    setState(() {
                      currSearchStatus = value;
                    });
                  }
                }, onSortChange: (String value) {
                  if (currSearchSort != value) {
                    setState(() {
                      currSearchSort = value;
                    });
                  }
                }),
                const SizedBox(height: 5),
                ChangePageMenu(onPageChange: (String value) {
                  if (currPage != value) {
                    setState(() {
                      currPage = value;
                    });
                  }
                }),
              ],
            ),
            const SizedBox(height: 14),
            Flexible(
                child: GridList(currSearch: currSearch, currSearchType: currSearchType, currSearchStatus: currSearchStatus, currSearchSort: currSearchSort,)
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTextBox extends StatelessWidget {
  final ValueChanged<String> onContentChanged;
  const SearchTextBox({required this.onContentChanged, super.key});

  void sendSearchString(String str, BuildContext context) {
    onContentChanged(str.trim().toLowerCase().replaceAll(' ', '+'));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextField(
        onSubmitted: (value) => sendSearchString(value, context),
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: Constants.textFieldBorderRadius
            ),
            labelText: 'Search',
            hintText: 'Search'
        ),
      ),
    );
  }
}

class SearchFilterMenu extends StatefulWidget {
  final ValueChanged<String> onTypeChange;
  final ValueChanged<String> onStatusChange;
  final ValueChanged<String> onSortChange;
  const SearchFilterMenu({required this.onTypeChange, required this.onStatusChange, required this.onSortChange, super.key});

  @override
  SearchFilterMenuState createState() => SearchFilterMenuState();
}
class SearchFilterMenuState extends State<SearchFilterMenu> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    void showMenu() {
      setState(() {
        isVisible = !isVisible;
      });
    }

    return Column(
      children: [
        TextButton(
            onPressed: showMenu,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              splashFactory: NoSplash.splashFactory
            ),
            child: const Column(
              children: [
                Text('Filters', style: Constants.primarySmallTextStyle,),
                Icon(Icons.arrow_drop_down_sharp, color: Colors.white,)
              ],
            )
        ),
        SizedBox(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              Visibility(
                visible: isVisible,
                maintainAnimation: true,
                maintainState: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Type', style: Constants.primaryTextStyle),
                    const SizedBox(height: 15),
                    TypeChoiceChip(onTypeChanged: (String value) {
                      widget.onTypeChange(value);
                    }),
                    const SizedBox(height: 10),
                    Container(height: 1, color: Colors.white),
                    const SizedBox(height: 25),
                    const Text('Status', style: Constants.primaryTextStyle),
                    const SizedBox(height: 15),
                    StatusChoiceChip(onStatusChanged: (String value) {
                      widget.onStatusChange(value);
                    }),
                    const SizedBox(height: 10),
                    Container(height: 1, color: Colors.white),
                    const SizedBox(height: 25),
                    const Text('Sort', style: Constants.primaryTextStyle),
                    const SizedBox(height: 15),
                    SortChoiceChip(onSortChange: (String value) {
                      widget.onSortChange(value);
                    }),
                    const SizedBox(height: 10),
                    Container(height: 1, color: Colors.white),
                    const SizedBox(height: 25),
                    const Text('Seasons', style: Constants.primaryTextStyle),
                    const SizedBox(height: 15),
                    const SeasonDropdownMenu(),
                    const SizedBox(height: 10),
                    Container(height: 1, color: Colors.white),
                  ],
                ),
              ),
            ],
          )
        )
      ],
    );
  }

}

class TypeChoiceChip extends StatefulWidget {
  final ValueChanged<String> onTypeChanged;
  const TypeChoiceChip({required this.onTypeChanged, super.key});

  @override
  State<StatefulWidget> createState() => TypeChoiceChipState();
}
class TypeChoiceChipState extends State<TypeChoiceChip> {
  int? selectedTypeChip = 0;

  @override
  Widget build(BuildContext context) {
    const searchTypes = Constants.searchTypes;
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(
          searchTypes.length,
          (index) {
            return ChoiceChip(
              label: Text(searchTypes.keys.elementAt(index)),
              selected: index == selectedTypeChip,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    widget.onTypeChanged(searchTypes.values.elementAt(index));
                    selectedTypeChip = selected ? index : null;
                  }
                });
              },
            );
          }
      ).toList(),
    );
  }
}

class StatusChoiceChip extends StatefulWidget {
  final ValueChanged<String> onStatusChanged;
  const StatusChoiceChip ({required this.onStatusChanged, super.key});

  @override
  State<StatefulWidget> createState() => StatusChoiceChipState();
}
class StatusChoiceChipState extends State<StatusChoiceChip> {
  int? selectedStatusChip = 0;

  @override
  Widget build(BuildContext context) {
    const searchStatuses = Constants.searchStatuses;
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(
          searchStatuses.length,
          (index) {
            return ChoiceChip(
              label: Text(searchStatuses.keys.elementAt(index)),
              selected: index == selectedStatusChip,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    widget.onStatusChanged(searchStatuses.values.elementAt(index));
                    selectedStatusChip = selected ? index : null;
                  }
                });
              },
            );
          }
      ).toList(),
    );
  }
}

class SortChoiceChip extends StatefulWidget {
  final ValueChanged<String> onSortChange;
  const SortChoiceChip({required this.onSortChange, super.key});

  @override
  State<StatefulWidget> createState() => SortChoiceChipState();
}
class SortChoiceChipState extends State<SortChoiceChip> {
  int? selectedSortChip = 0;

  @override
  Widget build(BuildContext context) {
    const searchSorts = Constants.searchSorts;
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(
          searchSorts.length,
          (index) {
            return ChoiceChip(
              label: Text(searchSorts.keys.elementAt(index)),
              selected: index == selectedSortChip,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    widget.onSortChange(searchSorts.values.elementAt(index));
                    selectedSortChip = selected ? index : null;
                  }
                });
              },
            );
          }
      ).toList(),
    );
  }
}

class SeasonDropdownMenu extends StatefulWidget {
  const SeasonDropdownMenu({super.key});

  @override
  State<SeasonDropdownMenu> createState() => SeasonDropdownMenuState();
}
List<String> list = <String>['Summer', 'Winter'];
class SeasonDropdownMenuState extends State<SeasonDropdownMenu> {
  final TextEditingController seasonController = TextEditingController();
  String selectedSeason = list.first;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 60,
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          value: selectedSeason,
          borderRadius: Constants.textFieldBorderRadius,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: Constants.textFieldBorderRadius
              ),
          ),
          onChanged: (String? value) {
            setState(() {
              selectedSeason = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String label) {
            return DropdownMenuItem<String>(
              value: label,
              child: Text(label),
            );
          }).toList(),
        )
    );
  }
}

class ChangePageMenu extends StatefulWidget {
  final ValueChanged<String> onPageChange;
  const ChangePageMenu({required this.onPageChange, super.key});

  @override
  ChangePageMenuState createState() => ChangePageMenuState();
}
class ChangePageMenuState extends State<ChangePageMenu> {
  int pageNum = 1;

  void incrementPageNum() {
    setState(() {
      pageNum++;
    });
    widget.onPageChange(pageNum.toString());
  }

  void decrementPageNum() {
    setState(() {
      if (pageNum > 1) { pageNum--; }
    });
    widget.onPageChange(pageNum.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: pageNum > 1 ? decrementPageNum : null,
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
          onPressed: incrementPageNum,
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
  final String currSearch;
  final String currSearchType;
  final String currSearchStatus;
  final String currSearchSort;
  const GridList ({required this.currSearch, required this.currSearchType, required this.currSearchStatus, required this.currSearchSort, super.key});

  @override
  GridListState createState() => GridListState();
}
class GridListState extends State<GridList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List> (
      future: ApiService.getSearchList(search: widget.currSearch, dub: widget.currSearchType, airing: widget.currSearchStatus, sort: widget.currSearchSort),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
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
            else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Result', style: TextStyle(fontSize: 24, color: Colors.grey)),
              );
            }
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