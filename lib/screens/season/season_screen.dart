import 'package:flutter/material.dart';
import 'package:ankunv2_flutter/constants.dart';

class SeasonScreen extends StatelessWidget {
  const SeasonScreen({super.key});

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
                SeasonDropdownMenu(),
                SizedBox(height: 14),
                ChangePageMenu()
              ],
            ),
            const SizedBox(height: 14,),
            const Flexible(child: GridList())
          ],
        ),
      )
    );
  }
}

class SeasonDropdownMenu extends StatefulWidget {
  const SeasonDropdownMenu({super.key});

  @override
  State<SeasonDropdownMenu> createState() => SeasonDropdownMenuState();
}
final List<String> list = <String>['Summer', 'Winter'];
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
              labelText: 'Season'
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