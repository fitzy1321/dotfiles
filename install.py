#!/usr/bin/env python3
"""This script will install and setup Fitzypop's latest dotfiles, dev workflow, and system packages."""
import argparse
import os
import subprocess
import sys
from pathlib import Path
from typing import Optional

MACOS = sys.platform == "darwin"
LINUX = sys.platform.startswith("linux")
SHELL = os.getenv("SHELL", "")
WINDOWS = sys.platform.startswith("win") or (sys.platform == "cli" and os.name == "nt")


XCODE_CMD = "xcode-select --install"
BREW_CMD = 'bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

# Various installation paths
BREW_PATH_DEFAULT = "/opt/homebrew/bin/"
# DOTFILES_PATH = "~/.dotfiles"


class InstallationError(RuntimeError):
    def __init__(self, return_code: int = 0, log: Optional[str] = None):
        super().__init__()
        self.return_code = return_code
        self.log = log


def run_shell(cmd, *args, **kwargs) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, *args, shell=True, **kwargs)


def dot_dir(args) -> Path:
    if args.path:
        return Path(args.path).expanduser().resolve()

    env = os.getenv("DOTFILES")
    if env:
        return Path(env).expanduser()

    if WINDOWS:
        raise InstallationError(1, "Windows is not currently supported.")
    # elif MACOS:
    #     base_dir = Path("~/.dotfiles").expanduser()
    else:
        base_dir = Path(os.getenv("XDG_CONFIG_HOME", "~/.config")).expanduser()

    base_dir = base_dir.resolve()
    return base_dir / "dotfiles"


def in_file(filenane, substring):
    """Return True if substring is contained with the named file"""
    with open(filenane, "r") as fp:
        data = fp.read()
        return substring in data


def mac_installer(args) -> int:
    brew_path = args.brew_path if args.brew_path else BREW_PATH_DEFAULT
    dot_path = dot_dir(args)
    fish_path = f"{brew_path}fish"

    print(f"{brew_path=}", f"{dot_path=}", f"{fish_path=}")

    if args.preview:
        return 0

    print(f'installing dev tools with "{XCODE_CMD}"')
    run_shell(XCODE_CMD)

    print("installing homebrew")
    run_shell(BREW_CMD)

    print("installing necessary packages with brew")
    run_shell("brew install git just")

    # clone dotfiles repo
    if not dot_path.exists():
        run_shell(
            f"{brew_path}git clone https://github.com/fitzypop/dotfiles.git {dot_path}"
        )

    print("Installing remaining brew packages")
    run_shell(f"{brew_path}just brewinstall")

    print("installing virtualenv")
    run_shell(f"{brew_path}pipx install virutalenv")

    print("Adding fish shell to /etc/shells")

    if not in_file("/etc/shells", fish_path):
        # subprocess hack: drop into bash shell with root permissions
        subprocess.call(
            f'sudo bash -c "echo "{fish_path}" >> /etc/shells',
            shell=True,
        )

    run_shell(f"chsh -s {fish_path})")

    print("All done! Close terminal session and re-open")
    return 0


def main() -> int:
    try:
        if WINDOWS:
            raise InstallationError(1, "Windows is not currently supported.")

        parser = argparse.ArgumentParser(
            description="Installs the latest version of Fitzypop's dotfiles"
        )
        parser.add_argument(
            "-p",
            "--preview",
            help="install preview version",
            dest="preview",
            action="store_true",
            default=False,
        )
        parser.add_argument(
            "--path",
            dest="path",
            action="store",
            help="Install dotfiles to a given path",
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
    except InstallationError as e:
        if e.log:
            sys.stderr.write(e.log)
        return e.return_code

    return 2


if __name__ == "__main__":
    raise SystemExit(main())
