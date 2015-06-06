To run locally:

  ```
bundle install
rake db:seed
thin start
```

---

To update cab data

  ```
curl -XPUT localhost:3000/api/v1/cabs/:id -d "available=false"
```

To get ETA for a customer position

  ```
curl "http://localhost:3000/api/v1/eta?lat=55.782098&lng=37.598886"
```
