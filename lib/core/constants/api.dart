import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiBasePath = dotenv.get(
  "API_BASE_PATH",
  fallback: "http://localhost:8000",
);

const loginPath = "/auth/login";
const getMePath = '/users/me';
