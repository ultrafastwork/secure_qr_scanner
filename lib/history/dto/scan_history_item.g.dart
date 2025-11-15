// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_history_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScanHistoryItemAdapter extends TypeAdapter<ScanHistoryItem> {
  @override
  final typeId = 0;

  @override
  ScanHistoryItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScanHistoryItem(
      id: fields[0] as String,
      content: fields[1] as String,
      type: fields[2] as String,
      timestamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ScanHistoryItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScanHistoryItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
