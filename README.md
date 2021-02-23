# LDH Houses

LDH Houses is an application for the [Linked Data
Hub](https://github.com/AtomGraph/LinkedDataHub "Linked Data Hub").  Its purpose
is to allow one to enter and view information about quotations.

## Installing

### Dependencies

#### LDH

A local copy of the LDH codebase is necessary for installing "LDH Houses".  Get
it by cloning [the repository](https://github.com/AtomGraph/LinkedDataHub
"Linked Data Hub").

You will also need access to a running LDH instance.  You can set one up by
following the instructions
[here](https://github.com/AtomGraph/LinkedDataHub#setup "LDH setup").

#### System

You'll also need the following installed
* [Apache Jena](https://jena.apache.org/ "Apache Jena")
* Python
* OpenSSL

Alternatively, if you use Nix, you can simply start a shell with

    $ nix-shell

and you'll have the above system dependencies satisfied.

### Install

To install "LDH Houses", first clone this repository and `cd` into the project
directory.  Then, run the following command:

    $ export SCRIPT_ROOT=<path-to-ldh-scripts-dir> \
	  ./install.sh \
	  <url-of-running-ldh> \
	  <path-to-tls-private-key> \
	  <password-for-tls-private-key>

If you're running a local LDH and you set `LDH_ROOT` to the path to the LDH
codebase, then the command will look something like:

    $ export SCRIPT_ROOT=$LDH_ROOT/scripts \
	  ./install.sh \
	  https://localhost:4443 \
	  $LDH_ROOT/certs/owner.p12.pem \
	  <password-for-tls-private-key>

Assuming it installed without error reload the LDH UI and you should now see
"Houses" listed in the top left.  Clicking that link should bring you to a page
where you'll be able to view some sample houses.

Happy quoting!
