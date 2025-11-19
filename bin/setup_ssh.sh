#!/usr/bin/env bash
set -euo pipefail

KEY_EMAIL="${1:-}"
KEY_NAME="${2:-id_ed25519}"

if [ -z "${KEY_EMAIL}" ]; then
  read -rp "Email for SSH key: " KEY_EMAIL
fi

SSH_DIR="${HOME}/.ssh"
KEY_PATH="${SSH_DIR}/${KEY_NAME}"

mkdir -p "${SSH_DIR}"
chmod 700 "${SSH_DIR}"

if [ -f "${KEY_PATH}" ]; then
  echo "Key already exists at ${KEY_PATH}"
else
  echo "Generating SSH key at ${KEY_PATH}..."
  ssh-keygen -t ed25519 -C "${KEY_EMAIL}" -f "${KEY_PATH}"
fi

eval "$(ssh-agent -s)" >/dev/null
ssh-add "${KEY_PATH}"

echo
echo "Public key:"
echo "---------------------------------------"
cat "${KEY_PATH}.pub"
echo "---------------------------------------"
echo "Add this key to GitHub: https://github.com/settings/keys"
