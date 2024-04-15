import json
import sys

drop_until_brace = lambda s: s[:s.rfind('}')+1] if '}' in s else s

def check_for_issues(json_file):    
    try:
        with open(json_file, 'r') as file:
            found_issue = False
            for line in enumerate(file, 1):
                try:
                    clean_line = drop_until_brace(line[1])
                    data = json.loads(clean_line)
                    if data.get('type') == 'issue':
                        print('\n')
                        print("Issue found: ", data.get('description'))
                        print("Severity: ", data.get('severity'))
                        print("Location: ", data.get('location'))
                        print("Position: ", data.get('position'))
                        print("\n")
                        found_issue = True
                except:
                    continue
            if not found_issue:
                print("No issues found.")
                return 0
            return 1          

    except FileNotFoundError:
        print(f"Error: File {json_file} not found.")
        return 1

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python check_issues.py <path_to_json_file>")
        sys.exit(1)
    
    result = check_for_issues(sys.argv[1])
    sys.exit(result)