import 'package:flutter/material.dart';
import 'package:ankunv2_flutter/constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
            const Column(
              children: [
                SearchTextBox(),
                SizedBox(height: 5),
                SearchFilterMenu(),
                SizedBox(height: 5),
                ChangePageMenu()
              ],
            ),
            const SizedBox(height: 14),
            const Flexible(
                child: GridList()
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTextBox extends StatelessWidget {
  const SearchTextBox({super.key});

  void sendSearchString(String str, BuildContext context) {
    Constants.scaffoldMessageToast(context, Text('Search value: "$str"'));
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
  const SearchFilterMenu({super.key});

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
          child: Flexible(
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
                      const TypeChoiceChip(),
                      const SizedBox(height: 10),
                      Container(height: 1, color: Colors.white),
                      const SizedBox(height: 25),
                      const Text('Status', style: Constants.primaryTextStyle),
                      const SizedBox(height: 15),
                      const StatusChoiceChip(),
                      const SizedBox(height: 10),
                      Container(height: 1, color: Colors.white),
                      const SizedBox(height: 25),
                      const Text('Sort', style: Constants.primaryTextStyle),
                      const SizedBox(height: 15),
                      const SortChoiceChip(),
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
            ),
          )
        )
      ],
    );
  }

}

class TypeChoiceChip extends StatefulWidget {
  const TypeChoiceChip({super.key});

  @override
  State<StatefulWidget> createState() => TypeChoiceChipState();
}
class TypeChoiceChipState extends State<TypeChoiceChip> {
  int? selectedTypeChip = 1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(
          3,
          (index) {
            return ChoiceChip(
              label: Text('Type $index'),
              selected: index == selectedTypeChip,
              onSelected: (bool selected) {
                setState(() {
                  selectedTypeChip = selected ? index : null;
                });
              },
            );
          }
      ).toList(),
    );
  }
}

class StatusChoiceChip extends StatefulWidget {
  const StatusChoiceChip ({super.key});

  @override
  State<StatefulWidget> createState() => StatusChoiceChipState();
}
class StatusChoiceChipState extends State<StatusChoiceChip> {
  int? selectedStatusChip = 1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(
          3,
          (index) {
            return ChoiceChip(
              label: Text('Status $index'),
              selected: index == selectedStatusChip,
              onSelected: (bool selected) {
                setState(() {
                  selectedStatusChip = selected ? index : null;
                });
              },
            );
          }
      ).toList(),
    );
  }
}

class SortChoiceChip extends StatefulWidget {
  const SortChoiceChip({super.key});

  @override
  State<StatefulWidget> createState() => SortChoiceChipState();
}
class SortChoiceChipState extends State<SortChoiceChip> {
  int? selectedSortChip = 1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(
          5,
          (index) {
            return ChoiceChip(
              label: Text('Sort $index'),
              selected: index == selectedSortChip,
              onSelected: (bool selected) {
                setState(() {
                  selectedSortChip = selected ? index : null;
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
  const ChangePageMenu({super.key});

  @override
  ChangePageMenuState createState() => ChangePageMenuState();
}
class ChangePageMenuState extends State<ChangePageMenu> {
  int pageNum = 1;

  void incrementPageNum() {
    setState(() {
      pageNum++;
    });
  }

  void decrementPageNum() {
    setState(() {
      if (pageNum > 1) { pageNum--; }
    });
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
  const GridList ({super.key});

  @override
  GridListState createState() => GridListState();
}
class GridListState extends State<GridList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: 7,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9/13),
      itemBuilder: (_, index) {
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
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://placehold.co/200x100/png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                      stops: const [0, 1],
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                    )
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10),
                child: const Text(
                  'This is an example of a long title text on top of an image',
                  style: Constants.primarySmallTextStyle,
                ),
              )
            ],
          ),
        );
      },
    );
  }

}
