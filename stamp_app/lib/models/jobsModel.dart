class Jobs {
  String title;
  String description;
  String date;
  String time;
  String endTime;
  String location;
  int count;
  // TODO: Change this to int
  int maxCount;
  int reserveCount;
  String category;
  Map currentReserv;
  Map currentAccepted;
  Map currentInterest;

  Jobs(
      {this.title,
      this.description,
      this.date,
      this.time,
      this.endTime,
      this.location,
      this.count,
      this.maxCount,
      this.reserveCount,
      this.category,
      this.currentReserv,
      this.currentAccepted,
      this.currentInterest});

  List<Jobs> newDummyJob() {
    return [
      Jobs(
        title: 'title',
        description: 'description',
        date: 'date',
        time: 'time',
        endTime: 'endTime',
        location: 'location',
        count: count,
        maxCount: maxCount,
        reserveCount: reserveCount,
      )
    ];
  }
}
