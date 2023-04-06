from time import sleep
import datetime

from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from flask_bcrypt import Bcrypt
from src.scheduler import scheduler, initScheduler

from src.database.db import db, ma
from src.routes.auth_routes import auth_routes
from src.routes.admin_routes import admin_routes
from src.routes.ano_routes import ano_routes
from src.routes.student_routes import student_routes
from src.routes.pupil_groups_routes import pupil_groups_routes
from src.routes.repository_route import repository_routes
from src.routes.class_group_routes import class_group_routes

app = Flask(__name__)

CORS(app)

# Database
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:g@localhost:5432/postgres'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

# Scheduler
scheduler.init_app(app)
scheduler.start()
initScheduler(app)

# JWT
app.config["JWT_TOKEN_LOCATION"] = ["headers", "query_string"]
app.config["JWT_SECRET_KEY"] = "super-secret"
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = datetime.timedelta(hours=24)
jwt = JWTManager(app)

# Crypt
bcrypt = Bcrypt(app)

# Routes
app.register_blueprint(auth_routes, url_prefix='/user')
app.register_blueprint(admin_routes, url_prefix='/admin')
app.register_blueprint(student_routes, url_prefix='/student')
app.register_blueprint(ano_routes, url_prefix='')
app.register_blueprint(pupil_groups_routes, url_prefix='/pupilgroup')
app.register_blueprint(repository_routes, url_prefix='/repository')
app.register_blueprint(class_group_routes, url_prefix='/classgroup')