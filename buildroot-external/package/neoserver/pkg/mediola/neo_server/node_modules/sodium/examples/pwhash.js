var sodium = require('sodium').api;

process.stdout.write('Password: ');
process.stdin.resume();
process.stdin.setEncoding('utf8');

process.stdin.on('data', function (input) {
  var password = Buffer.from('a password', 'utf8');
  var inPass = Buffer.from(input.trim(), 'utf8');

  var hash = sodium.crypto_pwhash_str(
    password,
    sodium.crypto_pwhash_OPSLIMIT_INTERACTIVE,
    sodium.crypto_pwhash_MEMLIMIT_INTERACTIVE);

  var isValid = sodium.crypto_pwhash_str_verify(hash, inPass);
  console.log(isValid ? 'Correct.' : 'Incorrect.');

  process.exit();
});
