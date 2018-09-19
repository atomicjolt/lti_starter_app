#!/bin/bash
ls client/apps |
  xargs -I % sh -c 'cd client/apps/% && yarn test -u' &&
  sh -c 'cd client/common/ && yarn test -u'
