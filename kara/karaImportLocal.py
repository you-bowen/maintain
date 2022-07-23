import sys
import webbrowser

url = sys.argv[1]

prefix = "karabiner://karabiner/assets/complex_modifications/import?url="
webbrowser.open(f"{prefix}{url}")
