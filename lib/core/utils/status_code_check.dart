void handleApiError(int statusCode) {
  switch (statusCode) {
    case 200:
    case 201:
      return; // Success cases
    case 400:
      throw Exception('Invalid request');
    case 401:
      throw Exception('Authentication required');
    case 403:
      throw Exception('Access denied');
    case 404:
      throw Exception('Resource not found');
    case 408:
      throw Exception('Request timeout');
    case 500:
      throw Exception('Server error');
    case 502:
      throw Exception('Bad gateway');
    case 503:
      throw Exception('Service unavailable');
    case 504:
      throw Exception('Connection timeout');
    default:
      throw Exception('Error: Status code $statusCode');
  }
}
