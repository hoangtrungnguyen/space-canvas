/// A wrapper for any property that needs to be synced across the network.
///
/// This class implements the "Last Write Wins" (LWW) conflict resolution strategy.
class SyncableProperty<T> {
  T value;
  int timestamp; // logical clock or server timestamp
  String lastAuthorId; // user who made the change

  SyncableProperty(this.value, {this.timestamp = 0, this.lastAuthorId = ''});

  /// Updates the value only if the incoming change is newer (strictly greater timestamp).
  void update(T newValue, int newTimestamp, String authorId) {
    if (newTimestamp > timestamp) {
      value = newValue;
      timestamp = newTimestamp;
      lastAuthorId = authorId;
    }
  }

  Map<String, dynamic> toJson() => {
    'val': value,
    'ts': timestamp,
    'auth': lastAuthorId,
  };

  factory SyncableProperty.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return SyncableProperty(
      fromJsonT(json['val']),
      timestamp: json['ts'] as int? ?? 0,
      lastAuthorId: json['auth'] as String? ?? '',
    );
  }
}
