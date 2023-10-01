{ lib
, stdenv
, fetchurl
, openssl
, libcap
, curl
, which
, eventlog
, pkg-config
, glib
, systemd
, perl
, riemann_c_client
, protobufc
, pcre2
, libnet
, json_c
, libuuid
, libivykis
, mongoc
, rabbitmq-c
, libesmtp
, python3
}:

let
  pydeps = (python3.withPackages (ps: with ps; [
    boto3
    botocore
    cachetools
    certifi
    charset-normalizer
    google-auth
    idna
    kubernetes
    oauthlib
    pyasn1
    pyasn1-modules
    python-dateutil
    pyyaml
    requests
    requests-oauthlib
    rsa
    six
    urllib3
    websocket-client
    ply
  ]));
in
stdenv.mkDerivation rec {
  pname = "syslog-ng";
  version = "4.4.0";

  src = fetchurl {
    url = "https://github.com/${pname}/${pname}/releases/download/${pname}-${version}/${pname}-${version}.tar.gz";
    hash = "sha256-WDsUfz7Bf7wtu/Mar7HjlmI311QTE95bQeqIXcFtky4=";
  };

  nativeBuildInputs = [
    pkg-config
    which
  ];

  patches = [ ./relax-requirements.patch ];

  buildInputs = [
    libcap
    curl
    openssl
    eventlog
    glib
    perl
    systemd
    riemann_c_client
    protobufc
    pcre2
    libnet
    json_c
    libuuid
    libivykis
    mongoc
    rabbitmq-c
    libesmtp
    pydeps
  ];

  propagatedBuildInputs = [ pydeps ];
  /*
    TOFIX
    syslog-ng>   CCLD     modules/secure-logging/slogencrypt/slogencrypt
    syslog-ng>   CCLD     modules/examples/sources/librandom_choice_generator.la
    syslog-ng>   CCLD     modules/examples/libexamples.la
    syslog-ng> /nix/store/71cx9wwywiyqlmb50wdzl2h07xxspj50-python-relax-deps-hook/nix-support/setup-hook: line 78: pushd: dist: No such file or directory
    syslog-ng> /nix/store/7cni7ndy2pm18ysl5znq6znb30sxp156-stdenv-linux/setup: line 144: pop_var_context: head of shell_variables not a function context
    error: builder for '/nix/store/95yivc836kjr3sbmr6rfp0lrca41yblp-syslog-ng-4.3.1.drv' failed with exit code 1;
  */

  /*
    syslog-ng> libtool: finish: PATH="/nix/store/6gvzma127ffp5x7mg4fmf0snbm15cciz-pkg-config-wrapper-0.29.2/bin:/nix/store/wq5d9qxwqf2pmrgs0gl4sgh0c4p109hm-which-2.21/bin:/nix/store/c6aivy3h5kgibrxnciq4l60hraygp07y-patchelf-0.15.0/bin:/nix/store/v1wa8ysdv5lc516fbh25m8ysigwv1k20-gcc-wrapper-12.3.0/bin:/nix/store/4khaz9q96z5nkgvh3150pz2ijhah30pr-gcc-12.3.0/bin:/nix/store/cw6x1hkbjynrlvmb22mh5amwijvxf1i0-glibc-2.37-8-bin/bin:/nix/store/zr0fzzkknaycqj8ij13gk6bhq8lnwxl1-coreutils-9.3/bin:/nix/store/yrjm2yaqy70jacs7mzkvmrg23iyjwm9q-binutils-wrapper-2.40/bin:/nix/store/8zxgqm6d879hskwh5g1l4crysl01kdv0-binutils-2.40/bin:/nix/store/nlyr2zqm7qfrx931wgqpsmcgi8hj0wan-attr-2.5.1-bin/bin:/nix/store/d53vjb00nwy59wycgcdpi2a91g8w6lz3-libcap-2.69/bin:/nix/store/p525sx5yd0fiblmixbhgfkhg4dpwhj5n-curl-8.2.1-dev/bin:/nix/store/mrd7c014k8sji7d5ll0yiaxk529731p8-brotli-1.0.9/bin:/nix/store/8ihllqw53ndm2ylvibyl1h0kbxdabdkw-libkrb5-1.20.1-dev/bin:/nix/store/01qn4g83hjzqmd8yfbb3dz32dzp8zjvg-libkrb5-1.20.1/bin:/nix/store/3iafb6csjbbrynr13jg23l59lxx7p3ks-nghttp2-1.54.0/bin:/nix/store/kfbbcgm5dj38qrzwk6p19hax1f9wxy6v-libidn2-2.3.4-bin/bin:/nix/store/4gpfzxnv0xy9cd5fc8rizb3252gi9zzr-openssl-3.0.10-bin/bin:/nix/store/9yzfj1sj5af85vbgmd33rpwpn0yg0fil-zstd-1.5.5-bin/bin:/nix/store/lg451mdjcnszbbxikdd75v1c4p8gw28y-zstd-1.5.5/bin:/nix/store/l04zxfqxy0sr7rq1rbf1nxcc15via3jn-curl-8.2.1-bin/bin:/nix/store/9i7hx6igi4wqqyyr046jlg2wwnv79rni-glib-2.76.4-dev/bin:/nix/store/v3364hpcrck5yviwi97brxba1s3nadn4-gettext-0.21.1/bin:/nix/store/4z85925nggvjiqj8p8vkib5wrzs5r1pp-glib-2.76.4-bin/bin:/nix/store/04hllvrsxrw8krjgz0lydxfdy2gg2ndw-perl-5.38.0/bin:/nix/store/i0lc8fswlqfh59bf3480n5rgjhqnpdvr-systemd-253.6/bin:/nix/store/pn995irmj7hz01j3yw9xjgkga93dk729-riemann-c-client-2.1.1/bin:/nix/store/1b6v6caq7aa8qzb9wsxjwcmjn5cxx28g-protobuf-c-unstable-2023-07-08/bin:/nix/store/a8rv27aq22kvqr35lgxyp4s82kgh5q6m-pcre2-10.42-dev/bin:/nix/store/knib456w4k7mqhggxzs2k217g9kyp3y2-pcre2-10.42-bin/bin:/nix/store/bl926lq62y13vlndnyhjsz0f9c6ai691-libnet-1.2/bin:/nix/store/2yw0aaj3zn9l3mbqm3n2lhwycx3f4394-util-linux-minimal-2.39.1-bin/bin:/nix/store/7qqzj9miq4sqxnw5xi9zv95mnzcjfn8j-mongoc-1.24.3/bin:/nix/store/vagb0sjv83ybi435i6iiv10hjrdghph9-python3-3.10.12/bin:/nix/store/zr0fzzkknaycqj8ij13gk6bhq8lnwxl1-coreutils-9.3/bin:/nix/store/dybcqb2k9b7qm3f29vm9n3jagxvmmcmr-findutils-4.9.0/bin:/nix/store/wag54ri5wji1gippgrfr7lg3jc8pib97-diffutils-3.10/bin:/nix/store/q8afk7kyb85c0n2h3v0mphnjmdqyj49q-gnused-4.9/bin:/nix/store/d2kvfr3r06rf5zdzsw7ayzj8lkpxh2lx-gnugrep-3.11/bin:/nix/store/3cg1n66ln0l5frnk4lydjajrbf9pavv9-gawk-5.2.2/bin:/nix/store/q5lvjrl7b12vqmsd93h013z9dqkbva0p-gnutar-1.35/bin:/nix/store/mbvy50fhspgwanw0fpns41afchll75br-gzip-1.12/bin:/nix/store/7284vinlwkp93151h6r3jcmdp5463rq9-bzip2-1.0.8-bin/bin:/nix/store/1mas5yrq926sr6n3jvf0zdlrj05rgcbv-gnumake-4.4.1/bin:/nix/store/m36d29gn5gm9bk0g7fcln1v8171hvn95-bash-5.2-p15/bin:/nix/store/wfc1dp9iwi0fw13vv6p06sz987msqgdl-patch-2.7.6/bin:/nix/store/xm6vmd1fq87mh70b793xzs39wnc084sw-xz-5.4.4-bin/bin:/nix/store/qnwqfphvsdgq054dywlvb8n2chxcs38l-file-5.45/bin:/sbin" ldconfig -n /nix/store/zxlyfzqwnfim2ywpackb7k3szmmbkd35-syslog-ng-4.3.1/lib/syslog-ng
    syslog-ng> ----------------------------------------------------------------------
    syslog-ng> Libraries have been installed in:
    syslog-ng>    /nix/store/zxlyfzqwnfim2ywpackb7k3szmmbkd35-syslog-ng-4.3.1/lib/syslog-ng
    syslog-ng> If you ever happen to want to link against installed libraries
    syslog-ng> in a given directory, LIBDIR, you must either use libtool, and
    syslog-ng> specify the full pathname of the library, or use the '-LLIBDIR'
    syslog-ng> flag during linking and do at least one of the following:
    syslog-ng>    - add LIBDIR to the 'LD_LIBRARY_PATH' environment variable
    syslog-ng>      during execution
    syslog-ng>    - add LIBDIR to the 'LD_RUN_PATH' environment variable
    syslog-ng>      during linking
    syslog-ng>    - use the '-Wl,-rpath -Wl,LIBDIR' linker flag
    syslog-ng> See any operating system documentation about shared libraries for
    syslog-ng> more information, such as the ld(1) and ld.so(8) manual pages.
    syslog-ng> ----------------------------------------------------------------------
    syslog-ng> WARNING: Retrying (Retry(total=1, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x29300b0>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/pip/
    syslog-ng> WARNING: Retrying (Retry(total=0, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x29335c0>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/pip/
    syslog-ng> WARNING: The directory '/homeless-shelter/.cache/pip' or its parent directory is not owned or is not writable by the current user. The cache has been disabled. Check the permissions and owner of that directory. If executing pip with sudo, you should use sudo's -H flag.
    syslog-ng> Requirement already satisfied: setuptools in ./venv/lib/python3.10/site-packages (65.5.0)
    syslog-ng> WARNING: Retrying (Retry(total=4, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x29239f0>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/setuptools/
    syslog-ng> WARNING: Retrying (Retry(total=3, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x292a960>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/setuptools/
    syslog-ng> WARNING: Retrying (Retry(total=2, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x2928bc0>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/setuptools/
    syslog-ng> WARNING: Retrying (Retry(total=1, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x29317a0>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/setuptools/
    syslog-ng> WARNING: Retrying (Retry(total=0, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x292e7e0>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/setuptools/
    syslog-ng> WARNING: The directory '/homeless-shelter/.cache/pip' or its parent directory is not owned or is not writable by the current user. The cache has been disabled. Check the permissions and owner of that directory. If executing pip with sudo, you should use sudo's -H flag.
    syslog-ng> WARNING: Retrying (Retry(total=4, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x296fa50>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/cachetools/
    syslog-ng> WARNING: Retrying (Retry(total=3, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x29765c0>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/cachetools/
    syslog-ng> WARNING: Retrying (Retry(total=2, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x2979b00>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/cachetools/
    syslog-ng> WARNING: Retrying (Retry(total=1, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x294ea60>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/cachetools/
    syslog-ng> WARNING: Retrying (Retry(total=0, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x28e0d80>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/cachetools/
    syslog-ng> ERROR: Could not find a version that satisfies the requirement cachetools==4.2.4 (from versions: none)
    syslog-ng> ERROR: No matching distribution found for cachetools==4.2.4
    syslog-ng> make[4]: *** [Makefile:31929: /build/syslog-ng-4.3.1/.python-venv-built] Error 1
    syslog-ng> make[3]: *** [Makefile:30756: install-exec-am] Error 2
    syslog-ng> make[2]: *** [Makefile:29347: install-am] Error 2
    syslog-ng> make[1]: *** [Makefile:27470: install-recursive] Error 1
    syslog-ng> make: *** [Makefile:29340: install] Error 2
    error: builder for '/nix/store/ny42wnilib7ffwf76a2mairglssxrfpc-syslog-ng-4.3.1.drv' failed with exit code 2;
       last 10 log lines:
       > WARNING: Retrying (Retry(total=2, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x2979b00>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/cachetools/
       > WARNING: Retrying (Retry(total=1, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x294ea60>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/cachetools/
       > WARNING: Retrying (Retry(total=0, connect=None, read=None, redirect=None, status=None)) after connection broken by 'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection object at 0x28e0d80>: Failed to establish a new connection: [Errno -3] Temporary failure in name resolution')': /simple/cachetools/
       > ERROR: Could not find a version that satisfies the requirement cachetools==4.2.4 (from versions: none)
       > ERROR: No matching distribution found for cachetools==4.2.4
       > make[4]: *** [Makefile:31929: /build/syslog-ng-4.3.1/.python-venv-built] Error 1
       > make[3]: *** [Makefile:30756: install-exec-am] Error 2
       > make[2]: *** [Makefile:29347: install-am] Error 2
       > make[1]: *** [Makefile:27470: install-recursive] Error 1
       > make: *** [Makefile:29340: install] Error 2
       For full logs, run 'nix log /nix/store/ny42wnilib7ffwf76a2mairglssxrfpc-syslog-ng-4.3.1.drv'.
       */

  pythonRelaxDeps = [ "cachetools" ];

  configureFlags = [
    "--enable-manpages"
    "--enable-dynamic-linking"
    "--enable-systemd"
    "--enable-smtp"
    "--with-ivykis=system"
    "--with-librabbitmq-client=system"
    "--with-mongoc=system"
    "--with-jsonc=system"
    "--with-systemd-journal=system"
    "--with-systemdsystemunitdir=$(out)/etc/systemd/system"
    "--without-compile-date"
  ];

  outputs = [ "out" "man" ];

  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "https://www.syslog-ng.com";
    description = "Next-generation syslogd with advanced networking and filtering capabilities";
    license = with licenses; [ gpl2Plus lgpl21Plus ];
    maintainers = with maintainers; [ eclairevoyant ];
    platforms = platforms.linux;
  };
}
