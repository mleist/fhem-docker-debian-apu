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

> root@debian:~# /bin/sh -c "cd /opt; git clone git@github.com:mleist/fhem-docker-debian-apu.git"
>
> root@debian:~# cd /opt/fhem-docker-debian-apu/stage1_apu_iso_builder/
>
> root@stage0tmp:/opt/fhem-docker-debian-apu/stage1_apu_iso_builder#
> 