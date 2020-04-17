import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

EventBus eventBus = EventBus();

class BaseEvent {
  void fire() {
    eventBus.fire(this);
  }
}

class PostLikeEvent extends BaseEvent {
  int id;
  bool isLike;

  PostLikeEvent(this.id, this.isLike);
}
