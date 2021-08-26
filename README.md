# fhem-docker-debian-apu

**Experience level: Advanced**



## build stage0 VM

- create Image with 4 GB RAM , 4 CPUs, 20 GB HD, UEFI-Boot: 'fhem_stage0.vmwarevm'
- boot from debian-11.0.0-amd64-netinst.iso
- [Advanced options ...] -> [... Automated install] -> Key 'E' & add:
  > ... auto=true url=https://raw.githubusercontent.com/mleist/fhem-docker-debian-apu/main/stage0_img_builder/preseed.txt ...
- Press F10
- wait for installed system



## login into stage0 VM

- username: root
- password: r00tme