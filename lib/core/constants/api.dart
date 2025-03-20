import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiBasePath = dotenv.get(
  "API_BASE_PATH",
  fallback: "http://192.168.137.1:8000",
);

const loginPath = "/auth/login";
const getMePath = '/users/me';
