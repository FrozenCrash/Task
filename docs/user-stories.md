# Implementation plans

## As a user, I see a list of products with thumbnails

1. have a `ProductsController` on the server,
2. have a `index` action in the `ProductsController` controller,
3. have a `GET /products` route on the server, that resolves to `ProductsController#index` action,
4. in controller action:

    ```
    select all visible products

    load products
    
    if products list size > 0
      return response with 204 code with following response:
      {
        "products": [
          {
            "id": 123,
            "title": "Some new product",
            "price": "12.76",
            "image": "https://placeimg.com/640/480",
            "created_at": "2019-03-24T18:25:43.511Z"
          },
          {
            ...
          }
        ]
      }
    else
      return 200 response with response body containing empty list []
    ```

## As a user, I see a single product with details

1. have a `ProductsController` on the server,
2. have a `show` action in the `ProductsController` controller,
3. have a `GET /products/:id` route on the server, that resolves to `ProductsController#show` action,
4. in controller action:
  
    ```
    load visible product
    
    if product exist?
      return response with 200 code with following response:
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
      return 404 response with empty response body
    ```

## As a logged in user, I add a product to the list my favorite products

1. have a `FavoritesController` on the server,
2. have a `create` action in the `FavoritesController` controller,
3. have a `POST /products/:id/favorite` route on the server, that resolves to `FavoritesController#create` action,
4. in controller action:

    ```
    load current user
    
    if user exists?
      load visible product
      
      if product exists?
        check in DB, record with product_id and user_id

        if product unfavorite?
          add product to user favorite list
          return 200 code response with empty response body
        else
          return 404 response with empty response body 
      else
        return 404 response with empty response body 
    else
      return 404 response with empty response body 
    ```

## As a logged in user, I remove a product from the list my favorite products

1. have a `FavoritesController` on the server,
2. have a `destroy` action in the `FavoritesController` controller,
3. have a `DELETE /products/:id/unfavorite` route on the server, that resolves to `FavoritesController#destroy` action,
4. in controller action:
    
    ```
    load current user
     
    if user exists?
      load visible product
      
      if product exist?
        check in DB, record with product_id and user_id

        if product favorite?
          unfavorite product from user favorite list
          return 200 code response with empty response body
        else
          return 404 response with empty response body
      else
        return 404 response with empty response body
    else
      return 404 response with empty response body
    ```

## As a logged in user, I see a list of my favorite products

1. have a `FavoritesController` on the server,
2. have a `index` action in the `FavoritesController` controller,
3. have a `GET /favorites` route on the server, that resolves to `FavoritesController#index` action,
4. in controller action:
  
    ```
    load current user
         
    if user exists?
      load all visible favorite products from user
      
      if products list size > 0
        return response with 200 code with following response:
        {
          "products": [
            {
              "id": 123,
              "title": "Some new product",
              "price": "12.76",
              "image": "https://placeimg.com/640/480",
              "created_at": "2019-03-24T18:25:43.511Z"
            },
            {
              ...
            }
          ]
        }
      else
        return 200 response with response body containing empty list []
    else
      return 404 response with empty response body
    ```

## As an admin, I see all products

1. have a `ProductsController` on the server,
2. have a `index` action in the `ProductsController` controller,
3. have a `GET /products` route on the server, that resolves to `ProductsController#index` action,
4. In controller action:

    ```
    load current user
       
    if user exists?
      if current user is admin?
        load all products

        if products list size > 0
          return response with 204 code with following response:
          {
            "products": [
              {
                "id": 123,
                "title": "Some new product",
                "price": "12.76",
                "image": "https://placeimg.com/640/480",
                "created_at": "2019-03-24T18:25:43.511Z"
              },
              {
                ...
              }
            ]
          }
        else
          return 200 response with response body containing empty list []
      else
        load products with parameter hide = false
    else
      load products with parameter hide = false
    ```

## As an admin, I add a product

1. have a `ProductsController` on the server,
2. have a `create` action in the `ProductsController` controller,
3. have a `POST /products` route on the server, that resolves to `ProductsController#create` action,
4. in controller action:

    ```
    load current user
   
    if user exists?
      if current user is admin?
        if all validates is true
          * product have title?
          * price product valid (price > 0) ?
          * title product uniq?
          * product have image?
          * extansion image exist? 
          * correct image URL?
          create new product
        else
          return response with 422 code and validation errors in response body:
            {
              ...
            }
      else
        return 404 (401 - Unauthorized) response with empty response body
    else
      return 404 (403 - Forbidden) response with empty response body 
    ```

## As an admin, I remove a product

1. have a `ProductsController` on the server,
2. have a `destoy` action in the `ProductsController` controller,
3. have a `DELETE /products/:id` route on the server, that resolves to `ProductsController#destoy` action,
4. issue a `DELETE /products/:id` to the server:
5. in controller action:
    
    ```
    load current user
   
    if user exists?
      if current user is admin?
        load product 

        if product loaded?
          delete product
          return 200 code response with empty response body
        else
          return 404 response with empty response body
      else
        return 404 response with empty response body
    else
      return 404 response with empty response body
    ```

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

