from flask import Flask, request, jsonify, send_from_directory
import sqlite3
import os

app = Flask(__name__, static_folder="../frontend", static_url_path="")

def get_db_connection():
    conn = sqlite3.connect("alerts.db")
    conn.row_factory = sqlite3.Row
    return conn

def init_db():
    conn = get_db_connection()
    c = conn.cursor()
    c.execute("""
        CREATE TABLE IF NOT EXISTS alerts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            location TEXT,
            message TEXT,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        );
    """)
    conn.commit()
    conn.close()

@app.route("/")
def serve_frontend():
    return send_from_directory(app.static_folder, "index.html")

@app.route("/<path:path>")
def serve_file(path):
    return send_from_directory(app.static_folder, path)

@app.route("/api/alerts", methods=["POST"])
def create_alert():
    data = request.get_json()
    name = data.get("name")
    location = data.get("location")
    message = data.get("message")
    if not (name and location and message):
        return jsonify({"error": "Missing fields"}), 400
    conn = get_db_connection()
    c = conn.cursor()
    c.execute(
        "INSERT INTO alerts (name, location, message) VALUES (?, ?, ?)",
        (name, location, message)
    )
    conn.commit()
    alert_id = c.lastrowid
    conn.close()
    return jsonify({"status": "success", "id": alert_id}), 201

@app.route("/api/alerts", methods=["GET"])
def get_alerts():
    conn = get_db_connection()
    c = conn.cursor()
    c.execute("SELECT * FROM alerts ORDER BY timestamp DESC")
    rows = c.fetchall()
    conn.close()
    alerts = []
    for row in rows:
        alerts.append({
            "id": row["id"],
            "name": row["name"],
            "location": row["location"],
            "message": row["message"],
            "timestamp": row["timestamp"]
        })
    return jsonify(alerts), 200

if __name__ == "__main__":
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    init_db()
    app.run(debug=True, host="0.0.0.0", port=5000)
