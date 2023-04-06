from http import HTTPStatus
from flask import jsonify 

class GenericResponseModel():
    def __init__(self, status = None, data = None, message = None):
        self.status = status
        self.data = data
        self.message = message

    def toString(self):
        return jsonify({
            "status" : self.status,
            "data" : self.data,
            "message" : self.message
        })

class NotFound(GenericResponseModel):
    def __init__(self, data = None, message = None):
        super().__init__(HTTPStatus.NOT_FOUND.value, data, message)

class Ok(GenericResponseModel):
    def __init__(self, data = None, message = None):
        super().__init__(HTTPStatus.OK.value, data, message)

class InternalServerError(GenericResponseModel):
    def __init__(self, data = None, message = None):
        super().__init__(HTTPStatus.INTERNAL_SERVER_ERROR.value, data, message)

class BadRequest(GenericResponseModel):
    def __init__(self, data = None, message = None):
        super().__init__(HTTPStatus.BAD_REQUEST.value, data, message)

class Unauthorized(GenericResponseModel):
    def __init__(self, data = None, message = None):
         super().__init__(HTTPStatus.UNAUTHORIZED.value, data, message)
