String getFunctionName([bool withinHelper = false]) {
  StackTrace stackTrace = StackTrace.current;

  String stackTraceString = stackTrace.toString();

  List<String> lines = stackTraceString.split('\n');

  if (lines.length > 1) {
    String functionName = lines[!withinHelper ? 1 : 2].split('.')[1].split(' ')[0];

    return functionName;
  }

  return 'Unknown Function';
}
