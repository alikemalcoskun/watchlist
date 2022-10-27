import './App.css';
import axios from 'axios';
import "bootstrap/dist/css/bootstrap.min.css";
import { useEffect, useState } from 'react';

function App() {

  const [movies, setMovies] = useState([]);
  const [title, setTitle] = useState('');
  

  useEffect(() => {
    axios.get('http://localhost:8000/api/get-all-movies')
    .then((response) => {
      setMovies(response.data);
    });
  }, []);

  const addMovie = () => {
    axios.post('http://localhost:8000/api/add-movie', {'movie_id': 1, 'title':title, 'description':"aaa"})
  .then(response => console.log(response))
  };
  

  const removeMovie = (title) => {
    axios.delete('http://localhost:8000/api/delete-movie/' + title)
  .then(response => console.log(response.data))
  };




  return (
    <div className="App">
      <h1> Watchlist </h1>
      <div class="form-floating mb-3">
        <input type="text" class="mb-2 form-control" id="floatingInput" onChange={event => setTitle(event.target.value)} placeholder="Movie Name"/>
        <label for="floatingInput">Movie Name</label>

        <div class="d-grid gap-2 col-6 mx-auto">
          <button class="btn btn-outline-primary" type="button" style={{'borderRadius':'50px',"font-weight":"bold"}}
          onClick={addMovie}>Add to watchlist</button>


        </div>


      </div>




      <div>
        {movies.map((movie) => 

        <div class="card" key={movie.movie_id}>
          <div class="card-body">
            <h5 class="card-title">{movie.title}</h5>
            <p class="card-text">{movie.description}</p>
            <button class="btn btn-outline-primary" type="button" style={{'borderRadius':'50px',"font-weight":"bold"}}
          onClick={() => removeMovie(movie.title)}>Remove</button>
          </div>
        </div>

        )}

      </div>


    </div>
  );
}

export default App;
