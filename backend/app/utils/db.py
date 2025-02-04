import logging
from typing import Any

import databases
from sqlalchemy import MetaData, create_engine
from sqlalchemy.ext.declarative import as_declarative
from sqlalchemy.orm import sessionmaker

from app.utils.config import settings

logger = logging.getLogger(__name__)

engine = create_engine(
    settings.SQLALCHEMY_DATABASE_URI,
    pool_pre_ping=True,
    echo=False,
    connect_args={"application_name": settings.APP_SYSNAME},
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

metadata = MetaData()

database = databases.Database(url=settings.SQLALCHEMY_DATABASE_URI)


@as_declarative()
class Base:
    id: Any


# Dependency to get DB session.
def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()
