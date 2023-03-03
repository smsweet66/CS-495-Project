class Profile
{
  int id = 0;
  String name = '';
  List<int> bodySizes = [];

  Profile(this.id, this.name, this.bodySizes);

  Profile.fromMap(Map<String, dynamic> map)
  {
    id = map['id'];
    name = map['name'];
    List<String> stringList = map['bodySizes'];
    stringList.map((e){
      var intValue = int.tryParse(e);
      bodySizes.add(intValue!);
    });
  }

  Map<String, dynamic> toMap()
  {
    return {
      'id': id,
      'name': name,
      'bodySizes': bodySizes.join(',')
    };
  }
}