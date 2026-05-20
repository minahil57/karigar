import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:karigar/modules/provider_screens/home/model/provider_model.dart';

// In-memory cache so the same avatar URL isn't downloaded twice per session.
final Map<String, BitmapDescriptor> _markerIconCache = {};

// ── Location grouping ─────────────────────────────────────────────────────────

/// Groups providers that share the same coordinates (~1 m precision).
String locationKey(double lat, double lng) =>
    '${lat.toStringAsFixed(5)}_${lng.toStringAsFixed(5)}';

Map<String, List<ProviderData>> groupProvidersByLocation(
  List<ProviderData> providers,
) {
  final groups = <String, List<ProviderData>>{};
  for (final provider in providers) {
    final key = locationKey(provider.lat, provider.lng);
    groups.putIfAbsent(key, () => []).add(provider);
  }
  return groups;
}

// ── Public API ────────────────────────────────────────────────────────────────

/// Returns a placeholder marker (initials circle) immediately.
Future<BitmapDescriptor> buildPlaceholderMarker({required String title}) async {
  return _buildMarkerBitmap(title: title);
}

/// Downloads [imageUrl] and returns a circular avatar marker.
/// Falls back to initials if the download fails.
/// Results are cached by (url + title) key.
Future<BitmapDescriptor> buildNetworkLogoMarker(
  String? imageUrl, {
  required String title,
}) async {
  final cacheKey = '${imageUrl ?? ''}_$title';

  if (_markerIconCache.containsKey(cacheKey)) {
    return _markerIconCache[cacheKey]!;
  }

  ui.Image? image;
  if (imageUrl != null && imageUrl.isNotEmpty) {
    try {
      final bytes = await http.readBytes(Uri.parse(imageUrl));
      final codec = await ui.instantiateImageCodec(bytes, targetWidth: 150);
      final frame = await codec.getNextFrame();
      image = frame.image;
    } catch (_) {
      image = null;
    }
  }

  final descriptor = await _buildMarkerBitmap(image: image, title: title);
  _markerIconCache[cacheKey] = descriptor;
  return descriptor;
}

/// Cluster marker with a count badge (placeholder).
Future<BitmapDescriptor> buildClusterPlaceholderMarker({
  required String title,
  required int count,
}) {
  return _buildClusterMarkerBitmap(title: title, count: count);
}

/// Cluster marker with avatar + count badge.
Future<BitmapDescriptor> buildNetworkClusterMarker(
  String? imageUrl, {
  required String title,
  required int count,
}) async {
  final cacheKey = 'cluster_${imageUrl ?? ''}_${title}_$count';

  if (_markerIconCache.containsKey(cacheKey)) {
    return _markerIconCache[cacheKey]!;
  }

  ui.Image? image;
  if (imageUrl != null && imageUrl.isNotEmpty) {
    try {
      final bytes = await http.readBytes(Uri.parse(imageUrl));
      final codec = await ui.instantiateImageCodec(bytes, targetWidth: 150);
      final frame = await codec.getNextFrame();
      image = frame.image;
    } catch (_) {
      image = null;
    }
  }

  final descriptor =
      await _buildClusterMarkerBitmap(image: image, title: title, count: count);
  _markerIconCache[cacheKey] = descriptor;
  return descriptor;
}

// ── Internals ─────────────────────────────────────────────────────────────────

Future<BitmapDescriptor> _buildMarkerBitmap({
  ui.Image? image,
  required String title,
}) async {
  const double size = 150;
  const double borderWidth = 3;
  const double center = size / 2;

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint();

  // Outer ring (grey border)
  paint.color = Colors.grey.shade400;
  canvas.drawCircle(const Offset(center, center), center, paint);

  // White inner ring
  paint.color = Colors.white;
  canvas.drawCircle(const Offset(center, center), center - borderWidth, paint);

  if (image != null) {
    // Network avatar
    paint.shader = ui.ImageShader(
      image,
      ui.TileMode.clamp,
      ui.TileMode.clamp,
      Matrix4.identity().storage,
    );
    canvas.drawCircle(
      const Offset(center, center),
      center - borderWidth - 3,
      paint,
    );
  } else {
    // Initials fallback
    final initials = _getInitials(title);
    final tp = TextPainter(
      text: TextSpan(
        text: initials,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 50,
          fontWeight: FontWeight.w500,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    tp.paint(canvas, Offset(center - tp.width / 2, center - tp.height / 2));
  }

  final picture = recorder.endRecording();
  final markerImage = await picture.toImage(size.toInt(), size.toInt());
  final byteData = await markerImage.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.bytes(
    byteData!.buffer.asUint8List(),
    width: 60,
    height: 60,
  );
}

Future<BitmapDescriptor> _buildClusterMarkerBitmap({
  ui.Image? image,
  required String title,
  required int count,
}) async {
  const double size = 150;
  const double borderWidth = 3;
  const double center = size / 2;
  const badgeColor = Color(0xFF5FB3B3);

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint();

  paint.color = Colors.grey.shade400;
  canvas.drawCircle(const Offset(center, center), center, paint);

  paint.color = Colors.white;
  canvas.drawCircle(const Offset(center, center), center - borderWidth, paint);

  if (image != null) {
    paint.shader = ui.ImageShader(
      image,
      ui.TileMode.clamp,
      ui.TileMode.clamp,
      Matrix4.identity().storage,
    );
    canvas.drawCircle(
      const Offset(center, center),
      center - borderWidth - 3,
      paint,
    );
  } else {
    final initials = _getInitials(title);
    final tp = TextPainter(
      text: TextSpan(
        text: initials,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 50,
          fontWeight: FontWeight.w500,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    tp.paint(canvas, Offset(center - tp.width / 2, center - tp.height / 2));
  }

  const badgeCenter = Offset(112, 112);
  const badgeRadius = 30.0;

  paint
    ..shader = null
    ..color = badgeColor;
  canvas.drawCircle(badgeCenter, badgeRadius, paint);

  paint.color = Colors.white;
  canvas.drawCircle(badgeCenter, badgeRadius - 2.5, paint);

  final countLabel = count > 9 ? '9+' : '$count';
  final countPainter = TextPainter(
    text: TextSpan(
      text: countLabel,
      style: TextStyle(
        color: badgeColor,
        fontSize: count > 9 ? 24 : 28,
        fontWeight: FontWeight.w700,
      ),
    ),
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  )..layout();

  countPainter.paint(
    canvas,
    Offset(
      badgeCenter.dx - countPainter.width / 2,
      badgeCenter.dy - countPainter.height / 2,
    ),
  );

  final picture = recorder.endRecording();
  final markerImage = await picture.toImage(size.toInt(), size.toInt());
  final byteData = await markerImage.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.bytes(
    byteData!.buffer.asUint8List(),
    width: 60,
    height: 60,
  );
}

String _getInitials(String title) {
  if (title.trim().isEmpty) return '?';
  final parts = title.trim().split(' ');
  if (parts.length == 1) {
    return parts.first.characters.first.toUpperCase();
  }
  return (parts.first.characters.first + parts.last.characters.first)
      .toUpperCase();
}
