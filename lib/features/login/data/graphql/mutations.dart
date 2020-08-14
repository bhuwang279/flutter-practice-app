String createTokenMutation(email, password){
  return """ mutation {
  tokenCreate(email: "$email", password: "$password") {
    token
    user {
      email
    }
    errors {
      field
      message
    }
  }
}""";
}
