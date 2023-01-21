import sys
import subprocess
import os

MACOS = sys.platform == "darwin"
LINUX = sys.platform.startswith("linux")
SHELL = os.getenv("SHELL", "")
WINDOWS = sys.platform.startswith("win") or (sys.platform == "cli" and os.name == "nt")


def main() -> int:
    if WINDOWS:
        sys.stderr.write(
            "Sorry, this script doesn't support windows systems right now."
        )
        return 1

    if MACOS:
        xcode_cmd = "xcode-select --install"
        brew_cmd = '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

        print(f'installing dev tools with "{xcode_cmd}"')
        subprocess.run(xcode_cmd, shell=True)

        subprocess.run(brew_cmd, shell=True)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
