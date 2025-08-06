    import os
    import time
    import csv

    def scan_for_changes(directory, previous_state=None):
        current_state = {}
        for root, _, files in os.walk(directory):
            for file in files:
                filepath = os.path.join(root, file)
                current_state[filepath] = os.path.getmtime(filepath)

        if previous_state is None:
            return current_state, [] # Initial scan, no changes to report yet

        changes = []
        # Check for modified or new files
        for filepath, mtime in current_state.items():
            if filepath not in previous_state or previous_state[filepath] != mtime:
                changes.append(f"Modified or new: {filepath}")

        # Check for deleted files
        for filepath in previous_state:
            if filepath not in current_state:
                changes.append(f"Deleted: {filepath}")

        return current_state, changes

    if __name__ == "__main__":
        systemd_etc = "/etc/systemd/system"
        systemd_lib = "/lib/systemd/system"
        systemd_us = "/usr/lib/systemd/system"
        previous_state = None
        while True:
            previous_state, detected_changes = scan_for_changes(systemd_dir, previous_state)
            if detected_changes:
                for change in detected_changes:
                    print(change)
            time.sleep(60) # Scan every 60 seconds