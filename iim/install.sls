# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "iim/map.jinja" import iim with context %}

{{iim.user}}:
  user.present:
    - home: /home/{{iim.user}}

manage iim:
  file.recurse:
    - name: /home/{{iim.user}}/iim-client
    - source: salt://iim/files/iim
