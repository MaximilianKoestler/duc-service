#! /bin/sh

# Log file path (can be overridden externally)
LOGFILE="${DUC_LOGFILE:-/var/log/duc.log}"

if [ ! -f /tmp/scan_in_progress ]; then
    touch /tmp/scan_in_progress

    {
        echo "Start of scan: $(date)"
        /usr/local/bin/duc index --progress /scan 2>&1
        exit_code=$?
        echo "End of scan: $(date) (exit code: $exit_code)"
    } | tee -a "$LOGFILE"

    rm -f /tmp/scan_in_progress
    exit $exit_code
fi
