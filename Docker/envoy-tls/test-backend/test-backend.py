#!/usr/bin/env python3

import os
from flask import Flask
import json

hostname = os.environ['HOSTNAME']

app = Flask(__name__)


@app.route("/", defaults={'path': ""})
@app.route("/<path:path>")
def main_route(path):
    data = {
        'message': f"Running from: {hostname}"
    }
    return json.dumps(data)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
