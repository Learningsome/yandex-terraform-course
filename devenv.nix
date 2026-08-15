{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  # https://devenv.sh/basics/
  env.GREET = "Terraform";
  env.YC_TERRAFORM_SA = "terraform-service-account-name";

  # https://devenv.sh/packages/
  packages = with pkgs; [
    jq
    git
    pre-commit
    yandex-cloud
  ];

  # https://devenv.sh/languages/
  languages.terraform.enable = true;

  files."scripts/bootstrap.sh" = {
    text = ''
      set +e

      GREEN="\033[32m"
      RED="\033[31m"
      YELLOW="\033[33m"
      BLUE="\033[34m"
      RESET="\033[0m"

      info() {
        printf "$BLUEℹ$RESET %s\n" "$1"
      }

      ok() {
        printf "$GREEN✓$RESET %s\n" "$1"
      }

      warn() {
        printf "$YELLOW!$RESET %s\n" "$1"
      }

      err() {
        printf "$RED✗$RESET %s\n" "$1"
      }

      echo
      echo "🔧 $GREET development environment"
      echo

      #
      # Silence warnings when using VPN
      #
      export YC_CLI_INITIALIZATION_SILENCE=true

      #
      # Mock AWS keys to work with s3
      #
      export AWS_ACCESS_KEY_ID="mock_access_key"
      export AWS_SECRET_ACCESS_KEY="mock_secret_key"

      #
      # yc installed?
      #
      if ! command -v yc >/dev/null; then
        err "Yandex Cloud CLI is not installed."
        return
      fi

      ok "yc CLI found"

      #
      # authenticated?
      #
      if ! YC_CLOUD_ID=$(yc config get cloud-id 2>/dev/null); then
        err "Yandex Cloud CLI is not configured."

        echo
        echo "Run:"
        echo
        echo "    yc init"
        echo "    source env.sh"
        echo

        return
      fi

      export YC_CLOUD_ID
      export YC_FOLDER_ID=$(yc config get folder-id)

      ok "Authenticated"
      ok "Cloud:  $YC_CLOUD_ID"
      ok "Folder: $YC_FOLDER_ID"

      #
      # service account
      #
      YC_TERRAFORM_SA_ID=$(
        yc iam service-account get \
          --name "$YC_TERRAFORM_SA" \
          --format json |
          jq -r '.id'
      )

      if [ -z "$YC_TERRAFORM_SA_ID" ] || [ "$YC_TERRAFORM_SA_ID" = "null" ]; then
        err "Service account '$YC_TERRAFORM_SA' not found."
        return
      fi

      export YC_TERRAFORM_SA_ID

      ok "Service account: $YC_TERRAFORM_SA"

      #
      # IAM token
      #
      if ! YC_TOKEN=$(yc iam create-token \
        --impersonate-service-account-id "$YC_TERRAFORM_SA_ID" 2>/dev/null); then
        err "Failed to obtain IAM token."
        return
      fi

      export YC_TOKEN

      ok "IAM token acquired"

      echo
      ok "Environment is ready 🚀"
      echo

    '';
    executable = true;
  };

  # https://devenv.sh/basics/
  enterShell = ''
    source scripts/bootstrap.sh
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    terraform --version | grep --color=auto "${pkgs.terraform.version}"
  '';

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    terraform-format.enable = true;
    terraform-validate.enable = false;

    # Общие проверки
    typos.enable = false;
    end-of-file-fixer.enable = true;
    trim-trailing-whitespace.enable = true;
    check-added-large-files.enable = true;
    check-merge-conflicts.enable = true;
    check-case-conflicts.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
