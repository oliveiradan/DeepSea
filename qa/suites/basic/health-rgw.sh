#!/bin/bash
#
# DeepSea integration test "suites/basic/health-rgw.sh"
#
# This script runs DeepSea stages 0-4 to deploy a Ceph cluster with RGW.  After
# stage 4 completes, it sends a GET request to the RGW node using curl, and
# tests that: (a) the response contains the string "anonymous" and (b) the
# response is legal XML.
#
# The script makes no assumptions beyond those listed in qa/README.
#
# On success, the script returns 0. On failure, for whatever reason, the script
# returns non-zero.
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
policy_cfg_no_client
policy_cfg_rgw
cat_policy_cfg
run_stage_2
ceph_conf
run_stage_3
run_stage_4
ceph_health_test
rgw_curl_test
