import 'dart:math';

enum NodeType { shape, connector }

abstract class Node {
  NodeType get type;
}

class ShapeNode extends Node {
  @override
  NodeType get type => NodeType.shape;
}

class ConnectorNode extends Node {
  @override
  NodeType get type => NodeType.connector;
}

abstract class FieldNode {
  final NodeType type;
  FieldNode(this.type);
}

class ShapeFieldNode extends FieldNode {
  ShapeFieldNode() : super(NodeType.shape);
}

class ConnectorFieldNode extends FieldNode {
  ConnectorFieldNode() : super(NodeType.connector);
}

void main() {
  const listSize = 1000000;
  const iterations = 100;
  final random = Random();

  // 1. Getter based nodes
  final nodes = List<Node>.generate(
    listSize,
    (index) => random.nextBool() ? ShapeNode() : ConnectorNode(),
  );

  // 2. Field based nodes
  final fieldNodes = List<FieldNode>.generate(
    listSize,
    (index) => random.nextBool() ? ShapeFieldNode() : ConnectorFieldNode(),
  );

  print('Benchmarking with list size $listSize and $iterations iterations...');
  print('--- Getter Based ---');

  // Warmup
  _benchmarkTypeCheck(nodes, 10);
  _benchmarkEnumCheck(nodes, 10);

  // Measure Type Check
  final stopwatchType = Stopwatch()..start();
  _benchmarkTypeCheck(nodes, iterations);
  stopwatchType.stop();
  print(
    'Type check (is ConnectorNode): ${stopwatchType.elapsedMilliseconds}ms',
  );

  // Measure Enum Check (Virtual Getter)
  final stopwatchEnum = Stopwatch()..start();
  _benchmarkEnumCheck(nodes, iterations);
  stopwatchEnum.stop();
  print('Enum check (virtual getter): ${stopwatchEnum.elapsedMilliseconds}ms');

  print('\n--- Field Based ---');

  // Warmup
  _benchmarkFieldTypeCheck(fieldNodes, 10);
  _benchmarkFieldEnumCheck(fieldNodes, 10);

  // Measure Type Check
  final stopwatchFieldType = Stopwatch()..start();
  _benchmarkFieldTypeCheck(fieldNodes, iterations);
  stopwatchFieldType.stop();
  print(
    'Type check (is ConnectorFieldNode): ${stopwatchFieldType.elapsedMilliseconds}ms',
  );

  // Measure Enum Check (Final Field)
  final stopwatchFieldEnum = Stopwatch()..start();
  _benchmarkFieldEnumCheck(fieldNodes, iterations);
  stopwatchFieldEnum.stop();
  print(
    'Enum check (final field): ${stopwatchFieldEnum.elapsedMilliseconds}ms',
  );
}

int _benchmarkTypeCheck(List<Node> nodes, int iterations) {
  int count = 0;
  for (int i = 0; i < iterations; i++) {
    count = 0;
    for (final node in nodes) {
      if (node is ConnectorNode) {
        count++;
      }
    }
  }
  return count;
}

int _benchmarkEnumCheck(List<Node> nodes, int iterations) {
  int count = 0;
  for (int i = 0; i < iterations; i++) {
    count = 0;
    for (final node in nodes) {
      if (node.type == NodeType.connector) {
        count++;
      }
    }
  }
  return count;
}

// Field based benchmarks

int _benchmarkFieldTypeCheck(List<FieldNode> nodes, int iterations) {
  int count = 0;
  for (int i = 0; i < iterations; i++) {
    count = 0;
    for (final node in nodes) {
      if (node is ConnectorFieldNode) {
        count++;
      }
    }
  }
  return count;
}

int _benchmarkFieldEnumCheck(List<FieldNode> nodes, int iterations) {
  int count = 0;
  for (int i = 0; i < iterations; i++) {
    count = 0;
    for (final node in nodes) {
      if (node.type == NodeType.connector) {
        count++;
      }
    }
  }
  return count;
}
