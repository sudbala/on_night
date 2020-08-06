
/// A class object to store and write users from and to the database
/// Sud is amazing but Maria is s p e c t a c u l a r
class User {
  // Instance Variables
  String legalName, displayName, affiliation, dormRoom, email, phoneNumber, netID;
  int classYear;

  // Constructor
  User(this.netID);

  @override
  String toString() {
    return legalName + ", " + displayName + ", " + affiliation + ", " + dormRoom + "\n" + email + ", " + phoneNumber;
  }
}