class Jobs {
  String jobID;
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
  Map currentReserve;
  Map currentAccepted;
  Map currentInterest;
  //List<Map<String, dynamic>> currentReserv;
  //List<Map<String, dynamic>> currentAccepted;
  //List<Map<String, dynamic>> currentInterest;

  Jobs(
      {this.jobID,
      this.title,
      this.description,
      this.date,
      this.time,
      this.endTime,
      this.location,
      this.count,
      this.maxCount,
      this.reserveCount,
      this.category,
      this.currentReserve,
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
