import pytest
import requests
import threading
import time
import sys
import os

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from app import app, items

BASE_URL = "http://127.0.0.1:5001"

@pytest.fixture(autouse=True)
def start_server():
    items.clear()
    items.extend([
        {"id": 1, "name": "Stylo",  "price": 1.50},
        {"id": 2, "name": "Cahier", "price": 3.00},
        {"id": 3, "name": "Règle",  "price": 2.00},
    ])
    server_thread = threading.Thread(
        target=lambda: app.run(host="127.0.0.1", port=5001, use_reloader=False, threaded=True),
        daemon=True
    )
    server_thread.start()
    time.sleep(0.5)
    yield

def test_home_route():
    response = requests.get(f"{BASE_URL}/")
    assert response.status_code == 200
    assert "Hello" in response.json()["message"]

def test_get_items():
    response = requests.get(f"{BASE_URL}/items")
    assert response.status_code == 200
    assert len(response.json()["items"]) == 3

def test_add_item():
    response = requests.post(f"{BASE_URL}/items", json={"name": "Gomme", "price": 0.50})
    assert response.status_code == 201
    assert response.json()["item"]["name"] == "Gomme"
    liste = requests.get(f"{BASE_URL}/items").json()["items"]
    assert len(liste) == 4

def test_add_item_sans_name():
    response = requests.post(f"{BASE_URL}/items", json={"price": 1.00})
    assert response.status_code == 400