class AutoGenerate {
  AutoGenerate({
    required this.empID,
    required this.empName,
    required this.empAge,
    required this.empDept,
    this.empUrl, // New attribute for image URL
  });

  late final int empID;
  late final String empName;
  late final int empAge;
  late final String empDept;
  String? empUrl; // New attribute for image URL

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    empID = json['empID'];
    empName = json['empName'];
    empAge = json['empAge'];
    empDept = json['empDept'];
    empUrl = json['empUrl']; // Update to include empUrl
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['empID'] = empID;
    _data['empName'] = empName;
    _data['empAge'] = empAge;
    _data['empDept'] = empDept;
    _data['empUrl'] = empUrl; // Include empUrl in the JSON
    return _data;
  }

  // Method to set the empUrl attribute
  void setEmpUrl(String url) {
    empUrl = url;
  }
}
