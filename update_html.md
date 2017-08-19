The `views/layout.erb` file is used as the default layout on every page.  But it has some things you should change.

1. Update the references of your stylesheets.  The value of the `href` properties on this page should start with a `/`:

Change this:
```
<link rel="stylesheet" href="assets/dist/candy.css" type="text/css" media="all">
```

To this:
```
<link rel="stylesheet" href="/assets/dist/candy.css" type="text/css" media="all">
```

1. Do the same with your `src` properties on the script tags:

Change this:
```
<script src="assets/dist/candy.js" type="text/javascript" charset="utf-8"></script>
```

To this:
```
<script src="/assets/dist/candy.js" type="text/javascript" charset="utf-8"></script>
```

1. Change the Title to the name of your Website

Change this:
```
<!DOCTYPE html>
<html>
<head>
<title>SheQL Project</title>
```
To this:

```
<!DOCTYPE html>
<html>
<head>
<title>My Project's Name</title>
````

1. Change the links in the menu to real links in your app.

These should be the real routes that logged in users or new users to your site can see.

Change this:
```
<body>
  <nav class="main-nav sticky-nav">
      <div class="menu">
          <img src="assets/my-logo.png" alt="My Logo">
          <ul>
              <li><a href="#">Link 1</a></li>
              <li><a href="#">Link 2</a></li>
              <li><a href="#">Link 3</a></li>
              <li><a href="#">Link 4</a></li>
          </ul>
          <button class="open-menu">Menu</button>
          <button class="close-menu">Close</button>
      </div>
  </nav>

```

To something like this:

```
<body>
  <nav class="main-nav sticky-nav">
      <div class="menu">
          <img src="assets/my-logo.png" alt="My Logo">
          <ul>
              <li><a href="/">Home</a></li>
              <li><a href="/deliveries">Deliveries</a></li>
              <li><a href="/orders">Orders</a></li>
              <li><a href="/">Logout</a></li>
          </ul>
          <button class="open-menu">Menu</button>
          <button class="close-menu">Close</button>
      </div>
  </nav>

```


1. If you have authentication, you can even change the menu based on whether the user is logged in...  (as long as you have defined an @user on every logged in page).


```
<body>
  <nav class="main-nav sticky-nav">
      <div class="menu">
          <img src="assets/my-logo.png" alt="My Logo">
          <ul>
          <% if @user %>
              <li><a href="/">Home</a></li>
              <li><a href="/deliveries">Deliveries</a></li>
              <li><a href="/orders">Orders</a></li>
              <li><a href="/">Logout</a></li>
          <% else %>
              <li><a href="/">Who We are</a></li>
              <li><a href="/login">Login</a></li>
          <% end %>
          </ul>
          <button class="open-menu">Menu</button>
          <button class="close-menu">Close</button>
      </div>
  </nav>

```


1. Run  `rake serve` to check to make sure your changes are implemented and look good on every page.
