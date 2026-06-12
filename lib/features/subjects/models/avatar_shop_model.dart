class AvatarShopModel {
  int? coins;
  int? stars;
  EquippedAvatar? equippedAvatar;
  List<Items>? items;

  AvatarShopModel({this.coins, this.stars, this.equippedAvatar, this.items});

  AvatarShopModel.fromJson(Map<String, dynamic> json) {
    coins = json['coins'];
    stars = json['stars'];
    equippedAvatar = json['equipped_avatar'] != null
        ? new EquippedAvatar.fromJson(json['equipped_avatar'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coins'] = this.coins;
    data['stars'] = this.stars;
    if (this.equippedAvatar != null) {
      data['equipped_avatar'] = this.equippedAvatar!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EquippedAvatar {
  int? headIndex;
  int? hairIndex;
  int? bodyIndex;
  int? legIndex;
  int? hatIndex;

  EquippedAvatar({
    this.headIndex,
    this.hairIndex,
    this.bodyIndex,
    this.legIndex,
    this.hatIndex,
  });

  EquippedAvatar.fromJson(Map<String, dynamic> json) {
    headIndex = json['headIndex'];
    hairIndex = json['hairIndex'];
    bodyIndex = json['bodyIndex'];
    legIndex = json['legIndex'];
    hatIndex = json['hatIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headIndex'] = this.headIndex;
    data['hairIndex'] = this.hairIndex;
    data['bodyIndex'] = this.bodyIndex;
    data['legIndex'] = this.legIndex;
    data['hatIndex'] = this.hatIndex;
    return data;
  }
}

class Items {
  String? id;
  String? itemType;
  int? itemIndex;
  int? price;
  bool? isDefault;
  bool? isOwned;

  Items({
    this.id,
    this.itemType,
    this.itemIndex,
    this.price,
    this.isDefault,
    this.isOwned,
  });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemType = json['item_type'];
    itemIndex = json['item_index'];
    price = json['price'];
    isDefault = json['is_default'];
    isOwned = json['is_owned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_type'] = this.itemType;
    data['item_index'] = this.itemIndex;
    data['price'] = this.price;
    data['is_default'] = this.isDefault;
    data['is_owned'] = this.isOwned;
    return data;
  }
}
