from fastapi import FastAPI, HTTPException
from fastapi.responses import Response
from prometheus_client import CONTENT_TYPE_LATEST, generate_latest, Counter
from pydantic import BaseModel

app = FastAPI()

health_counter = Counter(
    "health_requests_total",
    "Number of requests to the health endpoint",
)

@app.get("/health")
def get_health():
    health_counter.inc()
    return {"status": "ok"}

@app.get("/pipeline")
def get_pipeline_status():
    return {
  "name": "daily_sales",
  "status": "healthy"
}

@app.get("/instance")
def get_instance_status():
    return {"instance": "local"}

@app.get("/metrics")
def get_metrics_status():
    return Response(
    content=generate_latest(),
    headers={"Content-Type": CONTENT_TYPE_LATEST},
)