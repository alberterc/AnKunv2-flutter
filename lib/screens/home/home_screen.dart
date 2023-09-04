import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ankunv2_flutter/constants.dart';
import 'package:ankunv2_flutter/data/api_services.dart';
import 'package:ankunv2_flutter/screens/details/details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            SizedBox(
                width: double.infinity,
              child: SizedBox(
                height: 225,
                child: FutureBuilder<List> (
                  future: ApiService.getSliderList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TopThumbnailSlider(data: snapshot.data!);
                    } else if (snapshot.hasError) {
                      Constants.scaffoldMessageToast(context, Text(snapshot.error.toString()));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              )
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Recent updates list (mode: sub, page: 1)
                const Padding(
                  padding: EdgeInsets.fromLTRB(14, 10, 14, 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Updates (Sub)', style: Constants.primaryTextStyle),
                      Text('Show All', style: Constants.primaryTextStyleClickable)
                    ],
                  ),
                ),
                Flexible(
                    child: SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: FutureBuilder<List>(
                          future: ApiService.getRecentUpdatesList(mode: 'sub', page: '1'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return SmallThumbnail(dataId: snapshot.data![index][1], dataImage: snapshot.data![index][4], dataText: snapshot.data![index][0], dataIsDub: 0);
                                },
                              );
                            } else if (snapshot.hasError) {
                              Constants.scaffoldMessageToast(context, Text(snapshot.error.toString()));
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )
                      ),
                    )
                ),

                // Recent updates list (mode: dub, page: 1)
                const Padding(
                  padding: EdgeInsets.fromLTRB(14, 20, 14, 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Updates (Dub)', style: Constants.primaryTextStyle),
                      Text('Show All', style: Constants.primaryTextStyleClickable)
                    ],
                  ),
                ),
                Flexible(
                    child: SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: FutureBuilder<List>(
                          future: ApiService.getRecentUpdatesList(mode: 'dub', page: '1'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return SmallThumbnail(dataId: snapshot.data![index][1], dataImage: snapshot.data![index][4], dataText: snapshot.data![index][0], dataIsDub: 1);
                                },
                              );
                            } else if (snapshot.hasError) {
                              Constants.scaffoldMessageToast(context, Text(snapshot.error.toString()));
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )
                      ),
                    )
                ),

                // Most Popular This Week
                const Padding(
                  padding: EdgeInsets.fromLTRB(14, 20, 14, 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Most Popular This Week', style: Constants.primaryTextStyle),
                      Text('Show All', style: Constants.primaryTextStyleClickable)
                    ],
                  ),
                ),
                Flexible(
                    child: SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: FutureBuilder<List> (
                          future: ApiService.getSearchList(sort: Constants.searchSorts['Popular (Week)']!),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return SmallThumbnail(dataId: snapshot.data![index][1], dataImage: snapshot.data![index][2], dataText: snapshot.data![index][0], dataIsDub: snapshot.data![index][3]);
                                },
                              );
                            } else if (snapshot.hasError) {
                              Constants.scaffoldMessageToast(context, Text(snapshot.error.toString()));
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    )
                ),

                // Most Popular This Year
                const Padding(
                  padding: EdgeInsets.fromLTRB(14, 20, 14, 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Most Popular This Year', style: Constants.primaryTextStyle),
                      Text('Show All', style: Constants.primaryTextStyleClickable)
                    ],
                  ),
                ),
                Flexible(
                    child: SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: FutureBuilder<List> (
                          future: ApiService.getSearchList(sort: Constants.searchSorts['Popular (Year)']!),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return SmallThumbnail(dataId: snapshot.data![index][1], dataImage: snapshot.data![index][2], dataText: snapshot.data![index][0], dataIsDub: snapshot.data![index][3]);
                                },
                              );
                            } else if (snapshot.hasError) {
                              Constants.scaffoldMessageToast(context, Text(snapshot.error.toString()));
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    )
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                )
              ],
            ),
          ],
        ));
  }
}

class TopThumbnailSlider extends StatefulWidget {
  final List data;
  const TopThumbnailSlider({required this.data, super.key});

  @override
  State<TopThumbnailSlider> createState() => TopThumbnailSliderState();
}
class TopThumbnailSliderState extends State<TopThumbnailSlider> {
  int selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: widget.data.length,
            itemBuilder: (context, itemIndex, pageViewIndex) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.data[itemIndex][2]),
                        fit: BoxFit.fitHeight,
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
                    padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      widget.data[itemIndex][1],
                      style: Constants.primaryTextStyle,
                    ),
                  )
                ],
              );
            },
            options: CarouselOptions(
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 7),
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                enlargeCenterPage: false,
                initialPage: 0,
                height: 200,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    selectedItemIndex = index;
                  });
                }
            )
        ),
        const SizedBox(height: 5),
        DotsIndicator(
          dotsCount: widget.data.length,
          position: selectedItemIndex,
          decorator: DotsDecorator(
            spacing: const EdgeInsets.all(3),
            size: const Size(10, 7),
            activeColor: Colors.blue,
            activeSize: const Size(10, 7),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          ),
        )
      ],
    );
  }

}

class SmallThumbnail extends StatelessWidget {
  final String dataImage;
  final String dataText;
  final int dataIsDub;
  final int dataId;
  const SmallThumbnail({required this.dataId, required this.dataImage, required this.dataText, required this.dataIsDub, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: InkWell(
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
        ),
      )
    );
  }
}