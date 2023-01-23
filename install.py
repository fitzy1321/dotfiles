#!/usr/bin/env python3
"""This script will install and setup Fitzypop's latest dotfiles, dev workflow, and system packages."""
import argparse
import os
import subprocess
import sys

MACOS = sys.platform == "darwin"
LINUX = sys.platform.startswith("linux")
SHELL = os.getenv("SHELL", "")
WINDOWS = sys.platform.startswith("win") or (sys.platform == "cli" and os.name == "nt")


XCODE_CMD = "xcode-select --install"
BREW_CMD = 'bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

# Various installation paths
BREW_PATH_DEFAULT = "/opt/homebrew/bin/"
DOTFILES_PATH = "~/.dotfiles"


def in_file(filenane, substring):
    """Return True if substring is contained with the named file"""
    with open(filenane, "r") as fp:
        data = fp.read()
        return substring in data


def mac_installer(args) -> int:
    brew_path = args.brew_path if args.brew_path else BREW_PATH_DEFAULT
    dot_path = args.path if args.path else DOTFILES_PATH
    fish_path = f"{brew_path}fish"

    print(f'installing dev tools with "{XCODE_CMD}"')
    subprocess.run(XCODE_CMD, shell=True)

    print("installing homebrew")
    subprocess.run(BREW_CMD, shell=True)

    print("installing necessary packages with brew")
    subprocess.run("brew install git just", shell=True)

    # clone dotfiles repo
    subprocess.run(
        f"{brew_path}git clone git@github.com:fitzypop/dotfiles.git {dot_path}"
    )

    print("Installing remaining brew packages")
    subprocess.run(f"{brew_path}just brewinstall", shell=True)

    print("installing virtualenv")
    subprocess.run(f"{brew_path}pipx install virutalenv", shell=True)

    print("Adding fish shell to /etc/shells")

    if not in_file("/etc/shells", fish_path):
        # subprocess hack: drop into bash shell with root permissions
        subprocess.call(
            f'sudo bash -c "echo "{fish_path}" >> /etc/shells',
            shell=True,
        )

    subprocess.run(f"chsh -s {fish_path})", shell=True)

    print("All done! Close terminal session and re-open")
    return 0


def main() -> int:
    if WINDOWS:
        sys.stderr.write(
            "Sorry, this script doesn't support windows systems right now."
        )
        return 1

    parser = argparse.ArgumentParser(
        description="Installs the latest version of Fitzypop's dotfiles"
    )
    parser.add_argument(
        "--path", dest="path", action="store", help="Install dotfiles to a given path"
    )
    parser.add_argument(
        "--brew-path",
        dest="brew_path",
        action="store",
        help=f"Path to Homebrew bin directory, defautls to {BREW_CMD}",
    )
    args = parser.parse_args()

    if MACOS:
        return mac_installer(args)

    return 2


if __name__ == "__main__":
    raise SystemExit(main())
