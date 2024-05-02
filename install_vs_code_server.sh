#!/usr/bin/env bash

# Copyright 2024 Harold Torrado
# Copyright 2023 Khalifah K. Shabazz
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the “Software”),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

set -e

# Auto-Get the latest commit sha via command line.
get_latest_release() {
    platform=${1}
    arch=${2}

    # Grab the first commit SHA since as this script assumes it will be the
    # latest.
    commit_id=$(curl -k --silent "https://update.code.visualstudio.com/api/commits/stable/${platform}-${arch}" | sed s'/^\["\([^"]*\).*$/\1/')

    printf "%s" "${commit_id}"
}

PLATFORM=""
ARCH=""
INSTALATION_PATH=""

while [ "$#" -gt 0 ]; do
	echo "$1"
	case "$1" in
	--path*|-p*)
		shift
		echo "value: ${1}"
		INSTALATION_PATH="${1}"
		;;
	--platform*|-P*)
		shift
		PLATFORM="${1}"
		;;
	--arch*|-a*)
		shift
		ARCH="${1}"
		;;
	*)
		printf "****************************\n"
		printf "* Error: Invalid argument. *\n"
		printf "****************************\n"
		exit 1
	esac
	shift
done

if [ -z "${PLATFORM}" ]
then 
	U_NAME_OS=$(uname -o)

    if [ "${U_NAME_OS}" = "GNU/Linux" ]; then
		PLATFORM="linux"
    fi
fi

if [ -z "${ARCH}" ]; then
    U_NAME=$(uname -m)

    if [ "${U_NAME}" = "aarch64" ]; then
        ARCH="arm64"
    elif [ "${U_NAME}" = "x86_64" ]; then
        ARCH="x64"
    elif [ "${U_NAME}" = "armv7l" ]; then
        ARCH="armhf"
    fi
fi

if [ -z "${INSTALATION_PATH}" ]
then 
    INSTALATION_PATH="~"
fi

commit_sha=$(get_latest_release "${PLATFORM}" "${ARCH}")

if [ -n "${commit_sha}" ]; then
    echo "will attempt to download VS Code Server version = '${commit_sha}'"

    prefix="server-${PLATFORM}"
    if [ "${PLATFORM}" = "alpine" ]; then
        prefix="cli-${PLATFORM}"
    fi

    archive="vscode-${prefix}-${ARCH}.tar.gz"
    # Download VS Code Server tarball to tmp directory.
	route="https://update.code.visualstudio.com/commit:${commit_sha}/${prefix}-${ARCH}/stable"
    curl -Lk "${route}" -o "/tmp/${archive}"

    # Make the parent directory where the server should live.
    # NOTE: Ensure VS Code will have read/write access; namely the user running VScode or container user.
    mkdir -vp "${INSTALATION_PATH}/.vscode-server/bin/${commit_sha}"
	if [ "${INSTALATION_PATH}" != "~" ]; then
        ln -s "${INSTALATION_PATH}/.vscode-server" ~/.vscode-server
    fi

    # Extract the tarball to the right location.
    tar --no-same-owner -xz --strip-components=1 -C "${INSTALATION_PATH}"/.vscode-server/bin/"${commit_sha}" -f "/tmp/${archive}"
    # Add symlink
    cd "${INSTALATION_PATH}/.vscode-server/bin" && ln -s "${commit_sha}" default_version
else
    echo "could not pre install vscode server"
fi
