const String _home = "10.0.2.2:8000";

final Uri profileUrl = Uri.http(_home, "profiles");
final Uri loginUrl = Uri.http(_home, "login");
final Uri registerUrl = Uri.http(_home, "register");
final Uri logoutUrl = Uri.http(_home, "logout");

Uri deleteProfileUrl(int id)
{ return Uri.http(_home, "profiles/$id/delete"); }