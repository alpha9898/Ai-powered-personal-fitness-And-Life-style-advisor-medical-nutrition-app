abstract class Failuers {
  String Massage;

  Failuers(this.Massage);
}

class ServerFailuers extends Failuers {
  ServerFailuers(super.Massage);
}
