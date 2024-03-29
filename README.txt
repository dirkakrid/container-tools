container-tools - Manage systemd-nspawn containers
==================================================


1. Description
--------------

  "[A Linux container] is an operating-system-level virtualization environment
  for running multiple isolated Linux systems (containers) on a single Linux
  control host."

    -- Wikipedia (https://en.wikipedia.org/wiki/LXC)

container-tools provides the system integration for managing containers using
systemd-nspawn.


2. Download
-----------

  * https://github.com/open-infrastructure/container-tools


3. Installation
---------------

3.1 Source
----------

  1. sudo apt instal asciidoc git docbook-xml docbook-xsl libxml2-utils make xsltproc
  2. git clone https://github.com/open-infrastructure/container-tools
  3. cd container-tools && sudo make install

3.2 Debian 9 (stretch) and newer
--------------------------------

  * sudo apt install container-tools


4. Development
--------------

Bug reports, feature requests, and patches are welcome via Github:

  * https://github.com/open-infrastructure/container-tools

Please base them against the 'next' Git branch using common sense:

  * https://www.kernel.org/doc/Documentation/SubmittingPatches


5. Usage
--------

  * Create a new container:
    sudo container create -n NAME

  * Start a container:
    sudo container start -n NAME

  * Restart a container:
    sudo container restart -n NAME

  * Stop a container:
    sudo container stop -n NAME

  * Remove a container:
    sudo container remove -n NAME

  * Attach console to a container:
    sudo container console -n NAME

  * Limit ressources of a container:
    sudo container limit -n NAME --cpu-quota 10%

  * List container on the system:
    sudo container list

  * Show container-tools version:
    container version


6. Links
--------

  * 2016-02-24: Systemd vs. Docker
    https://lwn.net/Articles/676831/

  * 2015-06-10: Systemd and containers
    https://lwn.net/Articles/647634/

  * 2014-07-07: Control groups
    https://lwn.net/Articles/604609/

  * 2013-11-13: Systemd-Nspawn is Chroot on Steroids [LinuxCon Europe]
    https://www.youtube.com/watch?v=s7LlUs5D9p4

  * 2013-11-03: Creating containers with systemd-nspawn
    https://lwn.net/Articles/572957/

  * 2013-02-06: Systemd lightweight containers
    https://lwn.net/Articles/536033/

  * 2013-01-04: Namespaces in operation
    https://lwn.net/Articles/531114/


7. Authors
----------

  * Daniel Baumann <daniel.baumann@open-infrastructure.net>
