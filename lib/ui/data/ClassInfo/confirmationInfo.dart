class ConfirmationInfo {
  final int State;
  ConfirmationInfo(this.State);

  ConfirmationInfo.fromJson(Map json) : State = json['State'];
}
