class Item {
   final int id;
   String name;
   final String date;
   String content;
   bool done=false;
   Item(this.id, this.name, this.date, this.content,this.done);
}

class ItemsRepository {

  static final ItemsRepository _singleton = new ItemsRepository._internal();

  factory ItemsRepository() {
    return _singleton;
  }

  ItemsRepository._internal();


  List<Item> _items;

  void init() {

    _items = new List<Item>();
   }

  List<Item> getItems() {
    return _items;
  }
  void delete(Item item) {
    if (_items.contains(item)) {
      _items.remove(item);
    }
  }

  void addItem(Item item) {
    if (!_items.contains(item)) {
      _items.add(item);
    }
  }
}

class ItemsRepositoryTot {

  static final ItemsRepositoryTot _singleton = new ItemsRepositoryTot._internal();

  factory ItemsRepositoryTot() {
    return _singleton;
  }

  ItemsRepositoryTot._internal();


  List<Item> _itemsTot;

  void init() {

    _itemsTot = new List<Item>();
    /*_itemsTot.add(new Item(0, 'Andrew', '14 Dec',
        "Just a reminder about the report I was telling you about over the phone. Don't forget!"));
    _itemsTot.add(new Item(1, 'James', '13 Dec',
        "Up for long lunch today?"));
    _itemsTot.add(new Item(2, 'Andrew', '31 Nov',
        "I've got a great idea for formatting the report for the meeting tomorrow. I'm around between 1 and 2 pm."));
    _itemsTot.add(new Item(3, 'Andrew', '30 Nov',
        "Found the perfect gift for your wife!"));
    _itemsTot.add(new Item(4, 'Jane', '29 Nov',
        "Can we cancel tonight and reschedule? I've got a headache."));
    _itemsTot.add(new Item(5, 'Andrew', '27 Nov',
        "Fancy a cup of tea now? Would quite like to pick your brains about this report thingy."));
    _itemsTot.add(new Item(6, 'Andrew', '26 Nov',
        "Do you think Steve really need to go to our weekly meeting? Perhaps we should just email him the notes."));
    _itemsTot.add(new Item(7, 'Andrew', '25 Nov',
        "I forgot my lunch on top of the fridge and I'm stuck outside office in a meeting. Can you put it in please? Thanks thanks thanks!"));
  */}

  List<Item> getItems() {
    return _itemsTot;
  }
  void delete(Item item) {
    if (_itemsTot.contains(item)) {
      _itemsTot.remove(item);
    }
  }

  void addItem(Item item) {
    if (!_itemsTot.contains(item)) {
      _itemsTot.add(item);
    }
  }
}