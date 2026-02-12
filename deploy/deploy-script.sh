#!/bin/bash

vagrant up --provider=libvirt
vagrant provision vm2 --provision-with worker_join
vagrant provision vm3 --provision-with worker_join