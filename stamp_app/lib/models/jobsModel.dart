class Jobs {
  String title;
  String date;
  String time;
  String location;
  String count;
  //TODO: Icon attribute
  //TODO: Add support for descript

  Jobs({this.title, this.date, this.time, this.location, this.count});

  List<Jobs> newDummyJob() {
    return [
      Jobs(
        title: 'title',
        date: 'date',
        time: 'time',
        location: 'location',
        count: 'count',
      )
    ];
  }
}
