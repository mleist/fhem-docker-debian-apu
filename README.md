# fhem-docker-debian-apu

## build stage0 VM

- create Image with 4 GB RAM , 4 CPUs, 20 GB HD: 'fhem_stage0.vmwarevm'
- boot from debian-11.0.0-amd64-netinst.iso
- advanced boot -> auto install -> add:
  > ... auto=true url=https://raw.githubusercontent.com/mleist/fhem-docker-debian-apu/main/stage0_img_builder/preseed.txt ...
- wait for installed system ;-)

## login into stage0 VM

- 