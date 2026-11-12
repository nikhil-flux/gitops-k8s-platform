import os
import time

from flask import Flask, jsonify, request
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

VERSION = os.getenv("APP_VERSION", "v1")

REQUESTS = Counter("app_requests_total", "Total HTTP requests", ["path", "status"])
LATENCY = Histogram("app_request_seconds", "Request latency in seconds", ["path"])


@app.before_request
def start_timer():
    request.start_time = time.time()


@app.after_request
def record_metrics(response):
    elapsed = time.time() - getattr(request, "start_time", time.time())
    LATENCY.labels(request.path).observe(elapsed)
    REQUESTS.labels(request.path, response.status_code).inc()
    return response


@app.route("/")
def index():
    return jsonify(message="Hello from my gitops-k8s-platform myself Nikhil Gupta v2", version=VERSION)


@app.route("/health")
def health():
    return jsonify(status="ok")


@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {"Content-Type": CONTENT_TYPE_LATEST}


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
