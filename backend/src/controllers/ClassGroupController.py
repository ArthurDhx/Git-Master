from src.database.dals.class_group_dal import ClassGroupDAL
from src.responses.response_models import Ok


def get_all_class_group(class_group_dal=ClassGroupDAL()):
    data, _ = class_group_dal.get_all()
    return Ok(data=data).toString()
