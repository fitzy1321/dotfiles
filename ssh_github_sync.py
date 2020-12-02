import os
import argparse
import sys
import getpass
import subprocess

get_slash_for_path = lambda : "\\" if sys.platform == "win32" else "/"

def get_gh_creds():
    """Prompts the user for their github credentials.

    Returns Tuple[str, str, str] : (email, gh_username, gh_pass)
    """
    email = input("Email: ")
    gh_user = input("GitHub Username: ")
    gh_pass = getpass.getpass()
    return (email, gh_user, gh_pass)

def run_keygen():
    result = subprocess.run(["ssh-keygen"])

def main(args=None):
    """Run ssh-keygen and then send key to github account.

    May have to use a WebDriver with Firefox or Chrome."""
    yes_inputs = ["y", "ye", "yes"]
    # get path slash for your platform (win32, unix based)
    slash = get_slash_for_path()

    ssh_path = f"{os.path.expanduser('~')}{slash}.ssh{slash}id_rsa"

    if os.path.exists(ssh_path) or os.path.exists(f"{ssh_path}.pub"):
        user_overwrite = input("ssh key already exists, create a new one anyway? (y/n) : ")
        if user_overwrite.lower() not in yes_inputs:
            print("Canceling operations... ")
            exit()

    run_keygen()
    gh_creds = get_gh_creds()

if __name__ == '__main__':
    cli = argparse.ArgumentParser(prog="Automated SSH Key Gen and Github Sync", description='Create an ssh key and sync it to your github account');
    cli.add_argument("--email", default=None, type=str)
    args = cli.parse_args()
    print(args.email)
    # main(args)
    # main()
