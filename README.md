# fhem-docker-debian-apu

**Experience level: Advanced**



## build stage0 VM

- create Image with 4 GB RAM , 4 CPUs, 20 GB HD, UEFI-Boot: 'fhem_stage0.vmwarevm'
- boot from debian-11.0.0-amd64-netinst.iso
- [Advanced options ...] -> [... Automated install] -> Key 'E' & add:
  > ... auto=true url=https://raw.githubusercontent.com/mleist/fhem-docker-debian-apu/main/stage0_img_builder/preseed.txt ...
- Press F10
- wait for installed system

**Attention: for my work I have injected my ssh-key into the Stage0 system**



## login into stage0 VM

- username: root
- password: r00tme



## create stage1 ISO image

    root@debian:~# /bin/sh -c "cd /opt; git clone git@github.com:mleist/fhem-docker-debian-apu.git"
    root@debian:~# cd /opt/fhem-docker-debian-apu/stage1_apu_iso_builder/
    root@debian:/opt/fhem-docker-debian-apu/stage1_apu_iso_builder# ./build apu64 --force-root
    /opt/fhem-docker-debian-apu/stage1_apu_iso_builder/images/debian-11-amd64-CD-1.iso
    root@debian:/opt/fhem-docker-debian-apu/stage1_apu_iso_builder# ls -l images/
    total 329736
    -rw-r--r-- 1 root root 337641472 Aug 26 11:26 debian-11-amd64-CD-1.iso
    -rw-r--r-- 1 root root      4945 Aug 26 11:26 debian-11-amd64-CD-1.list.gz



## build USB stick for APU

insert USB stick

    root@stage0tmp:/opt/fhem-docker-debian-apu/stage1_apu_iso_builder# fdisk -l /dev/sdb
    Disk /dev/sdb: 14.92 GiB, 16025387008 bytes, 31299584 sectors
    Disk model: USB Flash Disk
    ...

copy ISO image to USB stick

**Check three times if the unit address is correct**

    root@stage0tmp:/opt/fhem-docker-debian-apu/stage1_apu_iso_builder# dd if=images/debian-11-amd64-CD-1.iso of=/dev/sdb bs=16M
    20+1 records in
    20+1 records out
    337641472 bytes (338 MB, 322 MiB) copied, 52.4693 s, 6.4 MB/s
    root@stage0tmp:/opt/fhem-docker-debian-apu/stage1_apu_iso_builder# sync

Remove the USB stick and continue with stage2



## install the APU in stage2


    SeaBIOS (version rel-1.12.1.3-0-g300e8b70)

    Press F10 key now for boot menu, N for PXE boot

F10 pressed

    Select boot device:

    1. iPXE
    2. USB MSC Drive General USB Flash Disk 1.00
    3. AHCI/0: SATA SSD ATA-10 Hard-Disk (15272 MiBytes)
    4. Payload [setup]
    5. Payload [memtest]

2 pressed

...

    ┌─────────────────────┤ Installing the base system ├──────────────────────┐
    │                                                                         │
    │                                   19%                                   │
    │                                                                         │
    │ ...running...                                                           │
    │                                                                         │
    └─────────────────────────────────────────────────────────────────────────┘

... wait for installed system

    Sent SIGKILL to all processesystem...
    Requesting system poweroff
    [ 1012.008340] reboot: Power down

stage2 done

## first start APU

...