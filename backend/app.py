from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, DevOps world! This is 3 Things DevOps."

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
