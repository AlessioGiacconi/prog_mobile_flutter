class Event {
  String? creatore;
  String? titolo;
  String? data;
  String? ora;
  String? luogo;
  String? ruoli_richiesti;
  double? n_persone;
  String? descrizione;

  Event();

  Map<String, dynamic> toJson() =>
      {
        'creatore': creatore,
        'titolo': titolo,
        'data': data,
        'ora': ora,
        'luogo': luogo,
        'ruoli_richiesti': ruoli_richiesti,
        'n_persone': n_persone,
        'descrizione': descrizione
      };

  Event.fromSnapshot(snapshot)
      : creatore = snapshot.data()['creatore'],
        titolo = snapshot.data()['titolo'],
        data = snapshot.data()['data'],
        ora = snapshot.data()['ora'],
        luogo = snapshot.data()['luogo'],
        ruoli_richiesti = snapshot.data()['ruoli_richiesti'],
        n_persone = snapshot.data()['n_persone'],
        descrizione = snapshot.data()['descrizione'];

}