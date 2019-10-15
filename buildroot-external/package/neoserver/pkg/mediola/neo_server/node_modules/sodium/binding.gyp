{
  'variables': {
    'target_arch%': '<!(node -e \"var os = require(\'os\'); console.log(os.arch());\")>'
  },
  'targets': [{
    'target_name': 'sodium',
    'sources': [
      'src/crypto_aead.cc',
      'src/crypto_sign.cc',
      'src/crypto_sign_ed25519.cc',
      'src/crypto_box.cc',
      'src/crypto_box_curve25519xsalsa20poly1305.cc',
      'src/sodium_runtime.cc',
      'src/crypto_auth.cc',
      'src/crypto_auth_algos.cc',
      'src/crypto_core.cc',
      'src/crypto_scalarmult_curve25519.cc',
      'src/crypto_scalarmult.cc',
      'src/crypto_sign.cc',
      'src/crypto_secretbox_xsalsa20poly1305.cc',
      'src/crypto_secretbox.cc',
      'src/sodium.cc',
      'src/crypto_stream.cc',
      'src/crypto_streams.cc',
      'src/helpers.cc',
      'src/randombytes.cc',
      'src/crypto_pwhash.cc',
      'src/crypto_hash.cc',
      'src/crypto_hash_sha256.cc',
      'src/crypto_hash_sha512.cc',
      'src/crypto_shorthash.cc',
      'src/crypto_shorthash_siphash24.cc',
      'src/crypto_generichash.cc',
      'src/crypto_generichash_blake2b.cc',
      'src/crypto_onetimeauth.cc',
      'src/crypto_onetimeauth_poly1305.cc'
    ],
    'include_dirs': [
      'src/include',
      'deps/build/include',
      "<!(node -e \"require('nan')\")"
    ],
    'cflags': ['-fPIC'],
    'configurations': {
      'Debug': {
        'msvs_settings': {
          'VCCLCompilerTool': {
            'DisableSpecificWarnings': ['4244', '4267']
          },
        },
      },
      'Release': {
        'msvs_settings': {
          'VCCLCompilerTool': {
            'DisableSpecificWarnings': ['4244','4267']
          },
        },
      },
    },
    'conditions': [
      ['OS=="mac"', {
        'libraries': [
          '../deps/build/lib/libsodium.a'
        ],
        'variables': {
          'osx_min_version': "<!(sw_vers -productVersion | awk -F \'.\' \'{print $1 \".\" $2}\')"
        },
        "xcode_settings": {
          'MACOSX_DEPLOYMENT_TARGET': '<(osx_min_version)',
          'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
          'OTHER_CFLAGS': ['-arch x86_64 -O2 -g -flto -mmacosx-version-min=<(osx_min_version) -fPIC'],
          'OTHER_LDFLAGS': ['-arch x86_64 -mmacosx-version-min=<(osx_min_version) -flto']
        }
      }],
      ['OS=="win"', {
        'libraries': [
          '../deps/build/lib/libsodium.lib'
        ]
      }],
      ['OS=="linux"', {
        'libraries': [
          '../deps/build/lib/libsodium.a'
        ]
      }]
    ]
  }]
}