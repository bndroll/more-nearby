import 'dart:convert';
import 'package:flutter/services.dart';
//import 'package:flutter_svg/flutter_svg.dart';

// class SvgImageCaching {
//
//
//   Future<void> precacheAppSvgPictures() async {
//     final manifestContent = await rootBundle.loadString('AssetManifest.json');
//
//     final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//
//     final imagePaths = manifestMap.keys
//         .where((String key) => key.endsWith('.svg'))
//         .toList();
//
//
//
//     await Future.wait([
//       for (final imagePath in imagePaths) addToCache(imagePath)
//     ]);
//   }
//
//   Future<void> addToCache(String asset) async {
//     final svgLoader = SvgAssetLoader(asset);
//     svg.cache.putIfAbsent(svgLoader.cacheKey(null), () => svgLoader.loadBytes(null));
//   }
// }
