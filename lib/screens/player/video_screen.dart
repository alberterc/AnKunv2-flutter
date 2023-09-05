import 'package:flutter/material.dart';
import 'package:ankunv2_flutter/data/api_services.dart';
import 'package:ankunv2_flutter/constants.dart';
import 'package:ankunv2_flutter/screens/player/player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.episodeId, required this.episodeNum, required this.itemName, required this.dataEpisodes});
  final int episodeId;
  final int episodeNum;
  final String itemName;
  final List dataEpisodes;

  @override
  State<VideoScreen> createState() => VideoScreenState();
}
class VideoScreenState extends State<VideoScreen> {
  var currSource = '';

  @override
  Widget build(BuildContext context) {
    var dataEpisodes = widget.dataEpisodes;
    var dataTitle = widget.itemName;
    var nextEpisode = dataEpisodes.length - widget.episodeNum - 1;
    var prevEpisode = dataEpisodes.length - widget.episodeNum + 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: FutureBuilder<Map> (
        future: ApiService.getItemEpisodeUrls(episodeId: widget.episodeId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var urls = snapshot.data!['un-sources'];
            // only use VidCDN-embed which provides .m3u8
            currSource = urls['VidCDN-embed'];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.itemName,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        softWrap: true,
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        'Episode ${widget.episodeNum.toString()}',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                VideoPlayerContainer(episodeUrl: currSource),
                // const SizedBox(height: 15,),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: ChangeSourceDropdown(sources: urls, onSourceChanged: (val) {
                //     currSource = val;
                //   }),
                // ),
                // const SizedBox(height: 15,),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: widget.episodeNum > 1 ? () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreen(
                              episodeId: dataEpisodes[prevEpisode][1],
                              episodeNum: dataEpisodes[prevEpisode][2],
                              itemName: dataTitle,
                              dataEpisodes: dataEpisodes,
                            )
                          ));
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
                        child: Text('Previous', style: widget.episodeNum > 1 ? Constants.primaryTextStyleClickable : null),
                      ),
                      ElevatedButton(
                        onPressed: nextEpisode >= 0 ? () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreen(
                              episodeId: dataEpisodes[nextEpisode][1],
                              episodeNum: dataEpisodes[nextEpisode][2],
                              itemName: dataTitle,
                              dataEpisodes: dataEpisodes,
                            )
                          ));
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
                        child: Text('Next', style: nextEpisode >= 0 ? Constants.primaryTextStyleClickable : null),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Text(
                        'Episodes',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      ),
                      const SizedBox(height: 5,),
                      SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Wrap(
                              spacing: 7,
                              runSpacing: 10,
                              children: List<Widget>.generate(
                                  dataEpisodes.length,
                                      (index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreen(
                                            episodeId: dataEpisodes[index][1],
                                            episodeNum: dataEpisodes[index][2],
                                            itemName: dataTitle,
                                            dataEpisodes: dataEpisodes,
                                          )
                                        ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            border: Border.all(color: Colors.grey)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Episode ${dataEpisodes[index][2].toString()}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.blue
                                                ),
                                              ),
                                              Text(
                                                Constants.getRelativeTimeFromEpoch(dataEpisodes[index][3]),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey
                                                ),
                                              )
                                            ],
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
                  ),
                )
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
    );
  }
}

// class ChangeSourceDropdown extends StatefulWidget {
//   const ChangeSourceDropdown({super.key, required this.sources, required this.onSourceChanged});
//   final Map sources;
//   final ValueChanged onSourceChanged;
//
//   @override
//   State<ChangeSourceDropdown> createState() => ChangeSourceDropdownState();
// }
// class ChangeSourceDropdownState extends State<ChangeSourceDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     List sourceNames = widget.sources.keys.toList();
//     List sourceUrls = widget.sources.values.toList();
//     String selectedDropdown = sourceNames.first;
//
//     return DropdownButtonFormField<String>(
//       value: selectedDropdown,
//       isExpanded: true,
//       borderRadius: Constants.textFieldBorderRadius,
//       decoration: const InputDecoration(
//         border: OutlineInputBorder(
//             borderRadius: Constants.textFieldBorderRadius,
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 10)
//       ),
//       items: sourceNames.map((val) => DropdownMenuItem(
//         value: val.toString(),
//         child: Text(val.toString()),
//       )).toList(),
//       onChanged: (val) {
//         setState(() {
//           selectedDropdown = val!;
//           widget.onSourceChanged(selectedDropdown);
//         });
//       }
//     );
//   }
// }