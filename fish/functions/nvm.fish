function nvm
    # Check if variable is not set
    if ! set -q NVM_DIR
        # check OS, supports macOS or Linux
        if test (uname) = "Darwin"
            set -Ux NVM_DIR $HOME/.nvm
        else
            set -Ux NVM_DIR $HOME/.config/nvm
        end
    end

    # use bass to source a sh file into fish shell
    bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv
end
