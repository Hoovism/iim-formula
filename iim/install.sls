# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "iim/map.jinja" import iim with context %}

{{iim.user}}:
  user.present:
    - home: {{iim.uhome}}
    - groups:
      - {{iim.ugroup}}

iim install:
  file.recurse:
    - name: {{iim.uhome}}/{{iim.client_subdir}}
    - source: salt://iim/files/iim-client
    - user: {{iim.user}}
    - group: {{iim.ugroup}}

{{iim.cpan_local}}:
  file.directory:
    - user: {{iim.user}}
    - group: {{iim.ugroup}}
    - mode: 700
    - makedirs: True

{{iim.uhome}}/{{iim.client_subdir}}/{{iim.client_conf}}:
  file.managed:
    - source:
      - salt://iim/files/iim.conf
    - template: jinja
    - context:
       iim: {{ iim }}
    - user: {{iim.user}}
    - group: {{iim.ugroup}}

{{iim.uhome}}/{{iim.client_subdir}}/iim:
  file.managed:
    - mode: 755

(cd {{iim.uhome}}/{{iim.client_subdir}}; ./iim -f -q -daemon production):
  cron.present:
    - identifier: IIM_START
    - user: {{iim.user}}
    - minute: random
    - hour: '*'
