from re import S
from tokenize import group
from pydantic import BaseModel


class Movie(BaseModel):
    movie_id: str
    title: str
    director: str
    year: str
    description: str
    actors: str
    genre: str
    poster: str
    group: str
    
