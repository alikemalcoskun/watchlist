from urllib import response
import requests
import json

omdbkey = '' #OMDb key

def search(movietitle):

    url = 'http://www.omdbapi.com/?apikey={}&t={}'.format(omdbkey, movietitle)
    response = requests.get(url)
    moviedata = response.json()

    dict = {"movie_id": moviedata["imdbID"], "title": moviedata["Title"], "director": moviedata["Director"], "year": moviedata["Year"], 
    "description": moviedata["Plot"], "actors": moviedata["Actors"], "genre": moviedata["Genre"], "poster": moviedata["Poster"]}
    return dict

