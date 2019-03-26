# "Store-front"

This document lists requirements for a sample application written in Ruby on Rails. You are to build a store front for products. Implementation should follow user stories.

## User stories

1. As a user, I see a list of all visible products with thumbnails,
2. As a user, I see a single product with details,
3. As a logged in user, I add a product to the list my favorite products,
4. As a logged in user, I remove a product from the list my favorite products,
5. As a logged in user, I see a list of my favorite products,
6. As an admin, I see all products,
7. As an admin, I add a product,
8. As an admin, I remove a product,
8. As an admin, I update a product.

## Product

Product constitutes of the following information:

1. Title,
2. Price,
3. Image.

---

## Task #1

Without doing any coding, do the following:

1. ~Define & draw basic UI mockups: which screens will be available in the app~ we will stick to building an API for now,
2. Define & draw basic DB schema: which tables & columns do you believe are required,
3. Describe user stories above in technical terms, be as detailed as you believe is necessary.

    For example:
    
    **As a user, I see a list of products with thumbnail**

    ```
    1. user opens http://localhost:4000/products URL,
    2. products are loaded from the DB,
    3. a loaded list of products is passed to HTML template,
    4. the HTML is rendered and,
    5. the response is returned to user.
    ```

## Important notes

* consider using [draw.io](https://draw.io) for the drawing,
* keep asking questions,
* use reason to make decisions on your own.
