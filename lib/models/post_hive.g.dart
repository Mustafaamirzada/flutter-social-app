// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostHiveModelAdapter extends TypeAdapter<PostHiveModel> {
  @override
  final int typeId = 2;

  @override
  PostHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostHiveModel(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      userId: fields[3] as int,
      mediaUrl: fields[4] as String,
      likeCount: fields[5] as int,
      commentCount: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PostHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.mediaUrl)
      ..writeByte(5)
      ..write(obj.likeCount)
      ..writeByte(6)
      ..write(obj.commentCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
