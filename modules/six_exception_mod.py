# -*- coding: utf-8 -*-
'''
Six Exeption module
=========================
'''

# Import Python Libs
#
from __future__ import absolute_import
import logging

from salt.exceptions import CommandExecutionError

log = logging.getLogger(__name__)



__virtualname__ = 'sixexception'


def __virtual__():
    '''
    Most everything has the ability to my module
    '''
    return __virtualname__

def minion(pillar_key):
    '''

    CLI Example:

    .. code-block:: bash

        salt '*' sixexception.minion

    '''
    minion_id = __salt__['grains.get']('id')
    if minion_id is None:
        log.error('Could not load id grains')
    else:
        pillar_path = '{0}:sysctl'.format(minion_id, pillar_key)

    pillar_minion = __salt__['pillar.get'](pillar_path)
    if pillar_minion is None:
        log.error('Could not load {0} pillar'.format(pillar_minion))
    return 'minion'

def default(provider, pillar_key):
    '''

    CLI Example:

    .. code-block:: bash

        salt '*' sixexception.default

    '''

    pillar_path = 'default:scb:{0}:{1}'.format(provider, pillar_key)

    pillar_default = __salt__['pillar.get'](pillar_path)
    if pillar_minion is None:
        log.error('Could not load default {0} pillar'.format(pillar_minion))
    return pillar_default

def role(pillar_key):
    '''

    CLI Example:

    .. code-block:: bash

        salt '*' sixexception.role

    '''
    minion_id = __salt__['grains.get']('id')
    if minion_id is None:
        log.error('Could not load id grains')
    else:
        pillar_path = '{0}:sysctl'.format(minion_id, pillar_key)

    pillar_minion = __salt__['pillar.get'](pillar_path)
    if pillar_minion is None:
        log.error('Could not load {0} pillar'.format(pillar_minion))
    return 'minion'
