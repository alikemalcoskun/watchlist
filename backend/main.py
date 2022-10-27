from http.client import HTTPException
from itertools import count
from tokenize import group
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from scipy import rand
from model import Movie
from database import (
    fetch_one_movie,
    fetch_all_movies,
    create_movie,
    remove_movie,
    random_movie,
)
import moviedata


app = FastAPI()


origins = ['*']

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/api/get-movie/{movie_id}", response_model=Movie)
async def get_one_movie(movie_id):
    movie = await fetch_one_movie(movie_id)
    if not movie: raise HTTPException(404)
    return movie


@app.get("/api/get-all-movies")
async def get_all_movies():
    movies = await fetch_all_movies()
    if not movies: raise HTTPException(404)
    return {"data": movies}


@app.post("/api/add-movie/")
async def add_movie(movie: Movie):
    movieinfo = moviedata.search(movie.title)
    movieinfo["group"] = movie.group
    result = await create_movie(movieinfo)
    if not result: raise HTTPException(400)
    return result


@app.delete("/api/delete-movie/{title}")
async def delete_movie(title):
    result = await remove_movie(title)
    if not result: raise HTTPException(400)
    return result

@app.get("/api/random-movie")
async def random():
    movie = await random_movie()
    if not movie: raise HTTPException(404)
    return {"data": [movie]}

    