abstract class IPublisher {
  void post<T>(T event);
}

typedef ISubscriber<T> = void Function(T event);

abstract class IEventBus extends IPublisher {
  void register<T>(ISubscriber<T> subscriber);

  void unregister<T>(ISubscriber<T> subscriber);
}

Type typeOf<T>() => T;

class MyEventBus1 implements IEventBus {
  Map<Type, List<Function>> map = new Map();

  @override
  void register<T>(ISubscriber<T> subscriber) {
    Type type = typeOf<T>();
    if (!map.containsKey(type)) {
      map[type] = new List();
    }
    map[type].add(subscriber);
  }

  @override
  void unregister<T>(ISubscriber<T> subscriber) {
    Type type = typeOf<T>();
    if (map.containsKey(type)) {
      map[type].remove(subscriber);
    }
  }

  @override
  void post<T>(T event) {
    Type type = typeOf<T>();
    if (map.containsKey(type)) {
      var subscribers = map[type];
      subscribers?.forEach((subscriber) => subscriber?.call(event));
    }
  }
}

class MyEventBus2 implements IEventBus {
  List<Function> subscribers = new List();

  @override
  register<T>(ISubscriber<T> subscriber) {
    if (!subscribers.contains(subscriber)) {
      subscribers.add(subscriber);
    }
  }

  @override
  unregister<T>(ISubscriber<T> subscriber) {
    if (subscribers.contains(subscriber)) {
      subscribers.remove(subscriber);
    }
  }

  @override
  post<T>(T event) {
    var ints = subscribers.whereType<ISubscriber<T>>();
    ints?.forEach((subscriber) => subscriber?.call(event));
  }
}

class EventX {}

class EventY {}

//main() {
//  testEventBus(new MyEventBus1());
//  print("--------------------");
//  testEventBus(new MyEventBus2());
//}
//
//void testEventBus(IEventBus eventBus) {
//  ISubscriber<EventX> subscriber1 = (event) => print(event.toString());
//  ISubscriber<EventX> subscriber2 = (event) => print(event.toString());
//  eventBus.register(subscriber1);
//  eventBus.register(subscriber2);
//  eventBus.unregister(subscriber1);
//
//  ISubscriber<EventY> subscriber3 = (event) => print(event.toString());
//  ISubscriber<EventY> subscriber4 = (event) => print(event.toString());
//  eventBus.register(subscriber3);
//  eventBus.register(subscriber4);
//
//  eventBus.post(new EventX());
//  eventBus.post(new EventY());
//}
