class Profile
{
  int id = 0;
  String name = '';
  List<int> bodySizes = [];

  Profile(this.id, this.name, this.bodySizes);

  Profile.fromMap(Map<String, dynamic> map)
  {
    id = map['id'];
    name = map['profileName'];
    List<String> stringList = map['bodySizes'].split(',');
    bodySizes = stringList.map(int.parse).toList();
  }

  Map<String, dynamic> toMap()
  {
    return {
      'id': id,
      'profileName': name,
      'bodySizes': bodySizes.join(',')
    };
  }
}