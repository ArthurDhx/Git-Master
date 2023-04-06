from src.database.db import db
from flask import jsonify

class GenericDAL():

    def __init__(self, entity, schema):
        self.entity = entity
        self.db_session = db.session
        self.schema = schema()
        self.schemas = schema(many = True)

    def get_all(self):
        raw_entities = self.entity.query.all()
        return self.schemas.dump(raw_entities), raw_entities
        
    def delete(self, entity):
        self.db_session.delete(entity)
        self.db_session.commit()

    def add(self, entity):
        self.db_session.add(entity)
        self.db_session.commit()

    def save(self, entity): 
        raw_entity = self.db_session.merge(entity)
        self.db_session.commit ()
        return raw_entity

    def get_by_id(self, _id):
        entity = self.entity.query.get(_id)
        return self.schema.dump(entity), entity

    def delete_by_id(self, _id):
        _, entity = self.get_by_id(_id)
        self.delete(entity)