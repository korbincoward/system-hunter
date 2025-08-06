import os
import time
import csv

def scan_for_changes(directory, previous_state=None):
    current_state = {}
    for root, _, files in os.walk(directory):
        for file in files:
            file_paths = os.path.join(root, file)
            try:
                current_state[file_paths] = os.path.getmtime(file_paths)
            except FileNotFoundError:
                # Skip files that no longer exist
                continue

    if previous_state is None:
        return current_state, [] # Initial scan, no changes to report yet

    changes = []
    # Check for modified or new files
    for file_path, mtime in current_state.items():
        if file_path not in previous_state or previous_state[file_path] != mtime:
            changes.append(f"Modified or new: {file_path}")

    # Check for deleted files
    for file_path in previous_state:
        if file_path not in current_state:
            changes.append(f"Deleted: {file_path}")

    return current_state, changes

if __name__ == "__main__":
    file_paths = [
        "/etc/systemd/system",
        "/lib/systemd/system",
        "/usr/lib/systemd/system"
    ]
    previous_state = {}
    while True:
        detected_changes = []
        for path in file_paths:
            previous_state[path], changes = scan_for_changes(path, previous_state.get(path))
            detected_changes.extend(changes)
        if detected_changes:
            for change in detected_changes:
                print(change)
        time.sleep(60) # Scan every 60 seconds