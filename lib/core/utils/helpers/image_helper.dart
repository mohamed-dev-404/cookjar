import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

/// Returns the appropriate [ImageProvider] for a given image URL string.
///
/// Supports:
/// - Base64 data URIs (e.g., `data:image/jpeg;base64,...`)
/// - Network URLs (e.g., `https://...`)
///
/// Returns `null` if the URL is null or empty.
ImageProvider? imageProviderFromUrl(String? url) {
  if (url == null || url.trim().isEmpty) return null;

  if (url.startsWith('data:')) {
    try {
      // Extract the Base64 part after the comma
      final base64String = url.split(',').last;
      final Uint8List bytes = base64Decode(base64String);
      return MemoryImage(bytes);
    } catch (_) {
      return null;
    }
  }

  return NetworkImage(url);
}
