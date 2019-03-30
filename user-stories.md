# Implementation plans

## As a user, I see a list of products with thumbnails

1. have a `ProductsController` on the server,
2. have a `index` action in the `ProductsController` controller,
3. have a `GET /products` route on the server, that resolves to `ProductsController#index` action,
4. issue a `GET /products` to the server,
5. in controller action, make a query using ActiveRecord to select all products from the database:

    * current user is **not admin**:
    
         ```sql
         select * from products where visible = true;
         ```

    * current user is **admin**:
    
         ```sql
         select * from products;
         ```

6. render products back in response in JSON format:

## As a user, I see a single product with details

1. have a `ProductsController` on the server,
2. have a `show` action in the `ProductsController` controller,
3. have a `GET /products/:id` route on the server, that resolves to `ProductsController#show` action,
4. issue a `GET /products/:id` to the server,
5. in controller action, make a query using ActiveRecord to select all single product from the database:

    ```sql
    select * from products where id = :id AND visible = true;
    ```

6. render product back in response in JSON format:

    ```json
    [
      {
        "title": "Some new product",
        "price": "12.76",
        "image": "https://placeimg.com/640/480"
      }
    ]
    ```

## As a logged in user, I add a product to the list my favorite products

1. have a `FavoritesController` on the server,
2. have a `create` action in the `FavoritesController` controller,
3. have a `POST /products/:id/favorite` route on the server, that resolves to `FavoritesController#create` action,
4. have a `before_action :authorize_user` to authorize user,
5. issue a `POST /products/:id/favorite` to the server,
6. in DB create record in `favorites` table:

    * **yes**:
    
    ```sql
    insert into favorites (id, product_id, user_id, ...) values (123, :id, ...)
    ```
    
    * **no**:
    
    response to user with error code `404`

7. render back empty response with `200` response code.

## As a logged in user, I remove a product from the list my favorite products

1. have a `FavoritesController` on the server,
2. have a `destroy` action in the `FavoritesController` controller,
3. have a `DELETE /products/:id/unfavorite` route on the server, that resolves to `FavoritesController#destroy` action,
4. have a `before_action :authorize_user` to authorize user,
5. issue a `DELETE /products/:id/unfavorite` to the server,
6. delete record from `favorites` table:
    
    * **yes** make a query to the DB:
    
    ```sql
    delete from favorites where product_id = :id and user_id = :user_id;
    ```

    * **no**: return empty response body with `404` error code.

7. render back empty response with `202` response code.

## As a logged in user, I see a list of my favorite products

1. have a `FavoritesController` on the server,
2. have a `index` action in the `FavoritesController` controller,
3. have a `GET /favorites` route on the server, that resolves to `FavoritesController#index` action,
4. have a `before_action :authorize_user` to authorize user,
5. issue a `GET /favorites` to the server,
6. get all favorite products from database:

    ```sql
    select * from favorites ... where user_id = :user_id;
    ```

7. render product back in response in JSON format:

    ```json
    [
      {
        "product": {
          "id": 1,
          "title": "",
          "price": "",
          "image": ""
        },
        "inserted_at": "2019-03-25T22:41:03.112963"
      },
      {
        "product": {
          "id": 2,
          "title": "",
          "price": "",
          "image": ""
        },
        "inserted_at": "2019-03-25T22:41:03.112963"
      }
    ]
    ```

## As an admin, I see all products

1. have a `ProductsController` on the server,
2. have a `index` action in the `ProductsController` controller,
3. have a `GET /products` route on the server, that resolves to `ProductsController#index` action,
4. have a `before_action :authorize_user` to authorize user,
5. have a `before_action :authenticate_admin` to confirm is an admin,
6. issue a `GET /products` to the server,
7. in controller action, make a query using ActiveRecord to select all visible products from the database:

    ```sql
    select * from products;
    ```

8. render product back in response in JSON format:

    ```json
    [
      {
        "id": 123,
        "title": "Some new product",
        "price": "12.76",
        "image": "https://placeimg.com/640/480",
        "visible": true
      },
      {
        "id": 123,
        "title": "Some new product",
        "price": "41.76",
        "image": "https://placeimg.com/640/480",
        "visible": false
      }
    ]
    ```

## As an admin, I add a product

1. have a `ProductsController` on the server,
2. have a `create` action in the `ProductsController` controller,
3. have a `POST /products` route on the server, that resolves to `ProductsController#create` action,
4. have a `before_action :authorize_user` to authorize user,
5. have a `before_action :authenticate_admin` to confirm is an admin,
6. issue a `POST /products` to the server with the following request body:

    ```json
    {
      "product": {
        "title": "Some new product",
        "price": "12.76",
        "image": "https://placeimg.com/640/480"
      }
    }
    ```

6. Before next step we must to check:
    * Price < 0
    * Product have title
    * Product have image
    * Unique title
    * Extansion image must be "jpeg"
    * Correct image URL
     
    **yes** make a query using ActiveRecord to save product to the database:

    ```sql
    insert into products ...
    ```
    
    **no**: return empty response body with `404` error code.

7. render product back in response in JSON, with response code `201`:

    ```json
    {
      "product": {
        "id": 123,
        "title": "Some new product",
        "price": "12.76",
        "image": "https://placeimg.com/640/480",
        "created_at": "2019-03-24T18:25:43.511Z",
      }
    }
    ```

## As an admin, I remove a product

1. have a `ProductsController` on the server,
2. have a `destoy` action in the `ProductsController` controller,
3. have a `DELETE /products/:id` route on the server, that resolves to `ProductsController#destoy` action,
4. have a `before_action :authorize_user` to authorize user,
5. have a `before_action :authenticate_admin` to confirm is an admin,
6. issue a `DELETE /products/:id` to the server:
7. in controller action:

    **yes**: make a query using ActiveRecord to delete product from the database:
    ```sql
    delete * from product where id = :id
    delete * from favorite where product_id = :id
    ```

    **no**: return empty response body with `404` error code.

8. render back empty response with `202` response code.

## As an admin, I update a product

1. have a `ProductsController` on the server,
2. have a `update` action in the `ProductsController` controller,
3. have a `PATCH /products/:id` route on the server, that resolves to `ProductsController#update` action,
4. issue a `PATCH /products/:id` to the server:
5. in controller action:
    
   ```
   load current user
   
   if user exists?
      if current user is admin?
         load product
         
         if product loaded?
            apply new product params
            validate product

            if product valid?
               update product in database         
               return response with 204 code with following response:
               {
                 "product": {
                   "id": 123,
                   "title": "Some new product",
                   "price": "12.76",
                   "image": "https://placeimg.com/640/480",
                   "created_at": "2019-03-24T18:25:43.511Z"
                 }
               }

            else
               return response with 422 code and validation errors in response body:
               {
                 ...
               }
         else
            return 404 response with empty response body
      else
         return 404 response with empty response body
   else
      return 404 response with empty response body
   ```
