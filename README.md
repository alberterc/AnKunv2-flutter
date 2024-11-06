# AnKunv2 in Flutter

***The API used is not maintained by me and may cause issues.***

A clone of AnkunV2 with Flutter.

Updated from [AnKunv2](https://github.com/RadXGH/AnKunv2) that was built using Jetpack Compose. Also, removed some features to reduce performance impact.

## Requirements
- Minimum of Android SDK level 21

## Tech Stack
- Flutter 3.10.6
- Material App
- Flutter packages (check [pubspec.yaml](https://github.com/RadXGH/AnKunv2-flutter/blob/master/pubspec.yaml) for details): [http](https://pub.dev/packages/http), [html_unescape](https://pub.dev/packages/html_unescape), [carousel_slider](https://pub.dev/packages/carousel_slider), [dots_indicator](https://pub.dev/packages/dots_indicator), [better_player](https://pub.dev/packages/better_player), [timeago](https://pub.dev/packages/timeago)
- IntelliJ IDEA 2023.2 (Community Edition)
- Android Virtual Devices of Pixel 7 with API level 34

## App Preview
| Images                                                                                           | Behaviors                                                                                                                                                               |
|--------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img src='readme_assets/home_screen.png' width="300" alt="home_screen.png"/>                     | <ul><li>Top thumbnail is a carousel which auto slides horizontally</li><li>Every section is a list which scrolls horizontally.</li></ul>                                |
| <img src='readme_assets/recent_updates_screen.png' width="300" alt="recent_updates_screen.png"/> | <ul><li>Each card item is clickable.</li><li>Shows the relative time of when each item is released.</li><li>List will be updated when a new item is released.</li></ul> |
| <img src='readme_assets/season_screen.png' width="300" alt="recent_updates_screen.png"/>         | <ul><li>Season list will be updated when a new one is present.</li></ul>                                                                                                |
| <img src='readme_assets/search_screen.png' width="300" alt="search_screen.png"/>                 | <ul><li>Search is available with both English and Japanese titles.</li><li>Search will use each word input.</li></ul>                                                   |
| <img src='readme_assets/search_screen_filters.png' width="300" alt="search_screen_filters.png"/> | <ul><li>Every filter change will update the item list.</li></ul>                                                                                                        |
| <img src='readme_assets/details_screen.png' width="300" alt="details_screen.png"/>               | <ul><li>Episode list will be updated when a new one is released.</li><li>Each episode will have their relative release time.</li></ul>                                  |
| <img src='readme_assets/video_player_screen.png' width="300" alt="video_player_screen.png"/>     | <ul><li>Currently only uses 1 source therefore the video might be unavailable.</li><li>Changing video quality causes video not to fill up the video screen.</li></ul>   |
