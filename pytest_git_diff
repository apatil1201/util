import subprocess
import pytest
import os

def get_modified_files():
    """Get the list of modified files using Git diff."""
    result = subprocess.run(["git", "diff", "--name-only", "HEAD~1"], capture_output=True, text=True)
    modified_files = result.stdout.strip().split("\n")
    return [file for file in modified_files if file.endswith(".py")]

def map_tests_to_files(modified_files):
    """Determine which tests are impacted by the modified files."""
    test_files = set()
    for file in modified_files:
        test_file = file.replace("src/", "tests/").replace(".py", "_test.py")
        if os.path.exists(test_file):
            test_files.add(test_file)
    return list(test_files)

def run_tests(test_files):
    """Run the impacted tests using pytest."""
    if test_files:
        pytest.main(test_files)
    else:
        print("No impacted tests found. Skipping execution.")

if __name__ == "__main__":
    modified_files = get_modified_files()
    test_files = map_tests_to_files(modified_files)
    run_tests(test_files)
