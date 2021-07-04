class Jobs {
  String title;
  String description;
  String date;
  String time;
  String endTime;
  String location;
  int count;
  // TODO: Change this to int
  String maxCount;
  int reserveCount;
  String category;

  //TODO: Icon attribute

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
      this.category});

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
