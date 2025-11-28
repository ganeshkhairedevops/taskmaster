from flask import Flask, jsonify
import redis
import os

app = Flask(__name__)
redis_client = redis.Redis(host=os.getenv('REDIS_HOST', 'localhost'), port=6379, decode_responses=True)

@app.route('/')
def home():
    try:
        visits = redis_client.incr('visits')
        return jsonify({
            'message': 'Hello from Flask!',
            'visits': visits,
            'status': 'healthy'
        })
    except:
        return jsonify({
            'message': 'Hello from Flask!',
            'visits': 'Redis unavailable',
            'status': 'degraded'
        })

@app.route('/health')
def health():
    return jsonify({'status': 'ok'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
