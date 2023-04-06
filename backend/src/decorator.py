from flask_jwt_extended import get_jwt
from flask_jwt_extended import verify_jwt_in_request
from flask import jsonify
from functools import wraps

def admin_required():
    def wrapper(fn):
        @wraps(fn)
        def decorator(*args, **kwargs):
            verify_jwt_in_request()
            claims = get_jwt()

            if 'administrator' in [m["label_role"] for m in claims["roles"]]  :
                return fn(*args, **kwargs)
            else:
                return jsonify(msg = "NOT_AUTHORIZED"), 403

        return decorator
    return wrapper