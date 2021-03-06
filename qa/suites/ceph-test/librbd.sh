#!/bin/bash
#
# DeepSea integration test "suites/ceph-test/librbd.sh"
#
# This script deploys a basic cluster and tests that ceph_test_librbd can be
# run on the client node. That means it's probably only useful if you execute
# that command yourself (manually or via CI tooling) after this script runs.
#
# The script makes the following assumption beyond those listed in qa/README:
# - the ceph-test RPM is installed on the client node
#
# On success (script thinks ceph_test_librbd can be run), the script returns 0.
# On failure, for whatever reason, the script returns non-zero.
#
# The script produces verbose output on stdout, which can be captured for later
# forensic analysis.
#

set -ex
BASEDIR=$(pwd)
source $BASEDIR/common/common.sh

install_deps
run_stage_0
run_stage_1
policy_cfg_base
policy_cfg_client
cat_policy_cfg
run_stage_2
ceph_conf
ceph_conf_mon_allow_pool_delete
ceph_conf_upstream_rbd_default_features
run_stage_3
ceph_health_test
ceph_test_librbd_can_be_run
