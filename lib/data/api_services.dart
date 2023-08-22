import 'dart:convert';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:http/http.dart' as http;
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
}