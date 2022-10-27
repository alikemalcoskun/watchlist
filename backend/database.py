from model import *
import motor.motor_asyncio

client = motor.motor_asyncio.AsyncIOMotorClient('') #MongoDB connection URI
database = client.watchlist
collection = database.movie

async def fetch_all_movies():
    movies = []
    cursor = collection.find()
    async for doc in cursor:
        movies.append(Movie(**doc))

    return movies


async def fetch_one_movie(movie_id):
    doc = await collection.find_one({"movie_id":movie_id},{"_id":0})
    return doc

async def create_movie(movie):

    await collection.insert_one(movie)
    result = await fetch_one_movie(movie["movie_id"])
    return result


async def remove_movie(title):
    await collection.delete_one({"title": title})
    return True


async def random_movie():
    aggcursor = collection.aggregate(
   [ { "$sample": { "size": 1 } } ]
)

    doc = []

    async for document in aggcursor:
        doc.append(document)    

    doc = doc[0]
    result = {key: doc[key] for key in doc.keys() if key != "_id"}
    return result