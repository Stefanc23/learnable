// Strings
const baseURL = 'http://10.0.2.2:8000';
const baseApiURL = baseURL + '/api';
const baseAuthURL = baseApiURL + '/auth';
const loginURL = baseAuthURL + '/login';
const registerURL = baseAuthURL + '/register';
const logoutURL = baseAuthURL + '/logout';
const userURL = baseApiURL + '/user';

// Errors
const serverError = 'Server error.';
const unauthorized = 'Unauthorized.';
const somethingWentWrong = 'Task failed successfully.';
const invalidCredentials =
    'Sorry, we don\'t recognize you. Please make sure you input correct email and password.';
