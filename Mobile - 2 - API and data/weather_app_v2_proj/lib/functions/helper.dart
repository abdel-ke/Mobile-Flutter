splitTime(String inputTime, int pos) {
  List<String> parts = inputTime.split('T'); // Split the string at 'T'
  if (parts.length == 2) {
    String datePart = parts[0]; // Date part (e.g., '2023-09-20')
    String timePart = parts[1]; // Time part (e.g., '00:00')
    String formattedTime;
    // Extract the time in the desired format (e.g., '00.00')
    formattedTime = pos == 1
        ? timePart.substring(0, 5).replaceAll(':', '.')
        : datePart.substring(0, 10).replaceAll(':', '.');
    return formattedTime;
  }
}
