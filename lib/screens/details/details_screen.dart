import 'package:ankunv2_flutter/data/api_services.dart';
import 'package:flutter/material.dart';
import 'package:ankunv2_flutter/constants.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.dataId});
  final int dataId;

  @override
  State<DetailsScreen> createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: FutureBuilder<Map> (
        future: ApiService.getDetails(id: widget.dataId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: SizedBox(
                          height: 225,
                          child: TopThumbnail(dataImage: snapshot.data!['large-thumbnail'])
                      ),
                    ),
                    FutureBuilder<List> (
                      future: ApiService.getItemGenres(id: widget.dataId),
                      builder: (context, snapshotGenre) {
                        if (snapshotGenre.hasData) {
                          return FutureBuilder<List> (
                            future: ApiService.getItemEpisodes(id: widget.dataId),
                            builder: (context, snapshotEpisodes) {
                              if (snapshotEpisodes.hasData) {
                                return Description(
                                  dataLargeImage: snapshot.data!['large-thumbnail'],
                                  dataImage: snapshot.data!['small-thumbnail'],
                                  dataTitle: snapshot.data!['title'],
                                  dataStatus: snapshot.data!['status'],
                                  dataSeason: snapshot.data!['season'] ?? '',
                                  dataType: snapshot.data!['type'],
                                  dataDescription: snapshot.data!['description'],
                                  dataGenres: snapshotGenre.data!,
                                  dataEpisodes: snapshotEpisodes.data!,
                                );
                              }
                              else if (snapshotGenre.hasError) {
                                Constants.scaffoldMessageToast(context, Text(snapshotGenre.error.toString()));
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        }
                        else if (snapshotGenre.hasError) {
                          Constants.scaffoldMessageToast(context, Text(snapshotGenre.error.toString()));
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                )
              ],
            );
          } else if (snapshot.hasError) {
            Constants.scaffoldMessageToast(context, Text(snapshot.error.toString()));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}

class TopThumbnail extends StatelessWidget {
  final String dataImage;
  const TopThumbnail({this.dataImage = '', super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        dataImage == '' ? const SizedBox() :
        Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(dataImage),
                fit: BoxFit.fitHeight,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken)
            ),
          ),
        ),
      ],
    );
  }
}

class Description extends StatelessWidget {
  final String dataLargeImage;
  final String dataImage;
  final String dataTitle;
  final String dataStatus;
  final String dataSeason;
  final String dataType;
  final List dataGenres;
  final String dataDescription;
  final List dataEpisodes;

  const Description({
    this.dataLargeImage = '',
    required this.dataImage,
    required this.dataTitle,
    required this.dataStatus,
    this.dataSeason = '',
    required this.dataType,
    required this.dataGenres,
    this.dataDescription = '',
    required this.dataEpisodes,
    super.key});

  @override
  Widget build(BuildContext context) {
    const smallThumbnailCardWidth = 150.0;
    const smallThumbnailCardHeight = 200.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dataLargeImage != '' ? SizedBox(
          height: MediaQuery.of(context).size.height * 1/7,
        ) : const SizedBox(),
        SizedBox(
          child: Row(
            children: [
              Card(
                elevation: 0,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: smallThumbnailCardHeight,
                  width: smallThumbnailCardWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          dataImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              SizedBox(
                height: smallThumbnailCardHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: dataLargeImage != '' ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 3),
                      width: MediaQuery.of(context).size.width - smallThumbnailCardWidth - 10,
                      child: Text(
                        dataTitle,
                        softWrap: true,
                        style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text(
                        dataStatus,
                        style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                      child: Text(
                        dataEpisodes.length > 1 ? '${dataEpisodes.length.toString()} episodes' : '${dataEpisodes.length.toString()} episode',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    dataSeason != '' ? Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text(
                        dataSeason,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ) : const SizedBox(),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text(
                        dataType,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Wrap(
              spacing: 7,
              runSpacing: 7,
              children: List<Widget>.generate(
                  dataGenres.length,
                      (index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        child: Text(
                          dataGenres[index],
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue
                          ),
                        ),
                      ),
                    );
                  }
              ).toList(),
            ),
          ),
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              dataDescription,
              softWrap: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                letterSpacing: 0.5
              ),
            )
          )
        ),
        const SizedBox(height: 10),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Wrap(
              spacing: 7,
              runSpacing: 10,
              children: List<Widget>.generate(
                  dataEpisodes.length,
                      (index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text(
                          'Episode ${dataEpisodes[index][2].toString()}',
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue
                          ),
                        ),
                      ),
                    );
                  }
              ).toList(),
            ),
          )
        )
      ],
    );
  }
}