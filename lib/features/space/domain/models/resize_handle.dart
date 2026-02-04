enum ResizeHandle {
  topLeft,
  topCenter,
  topRight,
  centerRight,
  bottomRight,
  bottomCenter,
  bottomLeft,
  centerLeft;

  bool get isCorner =>
      this == topLeft ||
      this == topRight ||
      this == bottomRight ||
      this == bottomLeft;
}
