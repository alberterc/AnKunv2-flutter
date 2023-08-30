import 'dart:convert';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:ankunv2_flutter/constants.dart';

class ApiService {
  static Future<List> getRecentUpdatesList({String mode = 'sub', String page = '1'}) async {
    final recentUpdatesEndpointUrl = '/public-api/index.php?page=$page&mode=$mode';
    final url = Uri.parse(Constants.apiBaseUrl + recentUpdatesEndpointUrl);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final responseBodyBytes = response.bodyBytes;
        final recentUpdatesListJSON = json.decode(HtmlUnescape().convert(utf8.decode(responseBodyBytes)));
        // JSON response [[Title, ID, UNKNOWN, TOTAL EP, THUMBNAIL, LAST EP RELEASE TIME]]
        return recentUpdatesListJSON;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return [];
  }

  static Future<List> getSearchList({String search = '', String season = '', String genres = '', String dub = '', String airing = '', String sort = '', String page = ''}) async {
    final searchEndpointUrl = '/public-api/search.php?search_text=$search&season=$season&genres=$genres&dub=$dub&airing=$airing&sort=$sort&page=$page';
    final url = Uri.parse(Constants.apiBaseUrl + searchEndpointUrl);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final responseBodyBytes = response.bodyBytes;
        final searchListJSON = json.decode(HtmlUnescape().convert(utf8.decode(responseBodyBytes)));
        // JSON response [[Title, ID, THUMBNAIL, SUB OR DUB (sub=0, dub=1)]]
        return searchListJSON;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return [];
  }

  static Future<List> getSliderList() async {
    const sliderEndpointUrl = '/public-api/slider.php';
    final url = Uri.parse(Constants.apiBaseUrl + sliderEndpointUrl);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final responseBodyBytes = response.bodyBytes;
        final sliderListJSON = json.decode(HtmlUnescape().convert(utf8.decode(responseBodyBytes)));
        // JSON response [[ID, TITLE, THUMBNAIL]]
        return sliderListJSON;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return [];
  }

  static Future<List<String>> getSeasons() async {
    const seasonEndpointUrl = '/seasons';
    final url = Uri.parse(Constants.apiBaseUrl + seasonEndpointUrl);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final responseBodyBytes = response.bodyBytes;
        final htmlDocument = parse(HtmlUnescape().convert(utf8.decode(responseBodyBytes)));
        final seasonDocumentList = htmlDocument.querySelector('ul.taxindex')!.querySelectorAll('span.name');
        List<String> seasonList = [];
        seasonDocumentList.map((e) => e.innerHtml).forEach((element) {
          seasonList.add(element);
        });
        return seasonList;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return [];
  }

  static Future<Map<String, String>> getDetails({int id = -1}) async {
    if (id != -1) {
      var detailsEndpointUrl = '/${id.toString()}';
      final url = Uri.parse(Constants.apiBaseUrl + detailsEndpointUrl);
      var temp = '';
      Map<String, String> detailsMap = {};
      try {
        var response = await http.get(url);
        if (response.statusCode == 200) {
          final responseBodyBytes = response.bodyBytes;
          final htmlDocument = parse(HtmlUnescape().convert(utf8.decode(responseBodyBytes)));
          final detailsDocument = htmlDocument.querySelector('div.infox')!;
          detailsMap['title'] = detailsDocument.querySelector('h1.entry-title')!.text.trim();
          detailsMap['description'] = detailsDocument.querySelector('div.desc')!.text.trim();
          detailsMap['small-thumbnail'] = htmlDocument.querySelector('div.thumbook')!.querySelector('img')!.attributes['src']!;
          try {
            temp = htmlDocument.querySelector('div.bigcover')!.querySelector('div')!.attributes['style']!;
            detailsMap['large-thumbnail'] = temp.substring(temp.indexOf("'"), temp.length).replaceAll("'", "").replaceAll(")", "").replaceAll(";", "").trim();
          } catch (e) {
            detailsMap['large-thumbnail'] = '';
          }
          for (var detail in detailsDocument.querySelector('div.spe')!.children) {
            var text = detail.text;
            if (text.substring(0, text.indexOf(':')) == 'Status') {
              detailsMap['status'] = text.substring(text.indexOf(':') + 1, text.length).trim();
            }
            else if (text.substring(0, text.indexOf(':')) == 'Episodes') {
              detailsMap['episode-count'] = text.substring(text.indexOf(':') + 1, text.length).trim();
            }
            else if (text.substring(0, text.indexOf(':')) == 'Type') {
              detailsMap['type'] = text.substring(text.indexOf(':') + 1, text.length).trim();
            }
            else if (text.substring(0, text.indexOf(':')) == 'Season') {
              detailsMap['season'] = text.substring(text.indexOf(':') + 1, text.length).trim();
            }
          }

          return detailsMap;
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }
    return {};
  }

  static Future<List<String>> getItemGenres({int id = -1}) async {
    if (id !=- 1) {
      var itemGenresEndpointUrl = '/${id.toString()}';
      final url = Uri.parse(Constants.apiBaseUrl + itemGenresEndpointUrl);
      try {
        var response = await http.get(url);
        if (response.statusCode == 200) {
          List<String> genreList = [];
          final responseBodyBytes = response.bodyBytes;
          final htmlDocument = parse(HtmlUnescape().convert(utf8.decode(responseBodyBytes)));
          final detailsDocument =
              htmlDocument.querySelector('div.infox')!.querySelector('div.genxed')!.querySelector('span')!.querySelectorAll('a');
          for (var detail in detailsDocument) {
            var text = detail.text;
            genreList.add(text.trim());
          }

          return genreList;
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }
    return [];
  }

  static Future<List>  getItemEpisodes({int id = -1}) async {
    if (id !=- 1) {
      var itemEpisodesEndpointUrl = '/public-api/episodes.php?id=$id';
      final url = Uri.parse(Constants.apiBaseUrl + itemEpisodesEndpointUrl);
      try {
        var response = await http.get(url);
        if (response.statusCode == 200) {
          final responseBodyBytes = response.bodyBytes;
          final episodeList = json.decode(HtmlUnescape().convert(utf8.decode(responseBodyBytes)));
          // [[UNKNOWN, EPISODE ID, EPISODE NUMBER, EPISODE RELEASE TIME]]
          return episodeList;
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }

    return [];
  }
}