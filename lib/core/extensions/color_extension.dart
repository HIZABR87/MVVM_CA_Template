import 'package:flutter/material.dart';

extension ColorExtension on Color? {
  get isNotNull => this != null;
  get isNull => this == null;
}
