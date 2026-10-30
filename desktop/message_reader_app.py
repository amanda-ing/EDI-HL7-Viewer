"""EDI and HL7 Message Reader - desktop app.

Opens EDI-and-HL7-Message-Reader.html in its own native window (WebKit on macOS,
Microsoft Edge WebView2 on Windows). Nothing is sent over the network: the page
is loaded from inside the app and has no external resources.
"""

import os
import sys

import webview

APP_NAME = "EDI and HL7 Message Reader"
HTML_NAME = "EDI-and-HL7-Message-Reader.html"


def resource_path(name):
    # PyInstaller unpacks bundled files to sys._MEIPASS; when run as a plain
    # script the HTML sits one folder up from this file.
    base = getattr(sys, "_MEIPASS", None)
    if base:
        return os.path.join(base, name)
    return os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", name)


def data_dir():
    # Where the window keeps its settings (text size, light/dark theme).
    if sys.platform == "darwin":
        root = os.path.expanduser("~/Library/Application Support")
    elif sys.platform == "win32":
        root = os.environ.get("APPDATA") or os.path.expanduser("~")
    else:
        root = os.environ.get("XDG_DATA_HOME") or os.path.expanduser("~/.local/share")
    path = os.path.join(root, APP_NAME)
    os.makedirs(path, exist_ok=True)
    return path


class Api:
    """Functions the page can call through window.pywebview.api."""

    def __init__(self):
        self.window = None

    def save_csv(self, text, suggested_name):
        result = self.window.create_file_dialog(
            webview.FileDialog.SAVE,
            save_filename=suggested_name,
            file_types=("CSV spreadsheet (*.csv)", "All files (*.*)"),
        )
        if not result:
            return False
        path = result if isinstance(result, str) else result[0]
        if not path.lower().endswith(".csv"):
            path += ".csv"
        with open(path, "w", encoding="utf-8", newline="") as f:
            f.write(text)
        return True


def main():
    html = resource_path(HTML_NAME)
    if not os.path.exists(html):
        raise SystemExit(f"Could not find {HTML_NAME} next to the app.")

    api = Api()
    api.window = webview.create_window(
        APP_NAME,
        url=html,
        js_api=api,
        width=1280,
        height=900,
        min_size=(760, 560),
        text_select=True,
    )
    webview.start(private_mode=False, storage_path=data_dir())


if __name__ == "__main__":
    main()
