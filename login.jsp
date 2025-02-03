<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <html>
    <head>
                    <link rel="stylesheet" href="./static/css/style-prefix.css">
      
      <!-- Other head elements (like title, meta, etc.) -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ionicons@5.5.2/dist/css/ionicons.min.css">
    <style>


    </style>
    </head>
    
<body>


<!-- Show message if there is one in the session -->
<% 
    String message = (String) session.getAttribute("message");
    if (message != null) {
%>
    <div class="alert alert-info">
        <%= message %>
    </div>
<%
        session.removeAttribute("message");
    }
%>

<!--
    - MODAL
 -->
<!-- Button to Open Modal 
<button id="loginButton">SignIn</button>

-->

  <div class="modal" id="login-modal" data-modal>

    <div class="modal-close-overlay" data-modal-overlay></div>

    <div class="modal-content">


      <button class="modal-close-btn" data-modal-close>
        <ion-icon name="close-outline"></ion-icon>
      </button>

      <div class="newsletter-img">
        <img src="./static/images/newsletter.png" alt="subscribe newsletter" width="400" height="400">
      </div>

      <div class="newsletter">
   
    <form method="post" action="loginServlet">

          <div class="newsletter-header">

            <h3 class="newsletter-title">Subscribe Newsletter.</h3>

            <p class="newsletter-desc">
              Subscribe the <b>Anon</b> to get latest products and discount update.
            </p>

          </div>
      <input type="email" class="email-field" name="email" placeholder="Email Address" required>
      <input type="password" class="email-field" name="password" placeholder="Password" required>
      <button type="submit" class="btn-newsletter">SignUp</button>
		<span style="font-size:12px;">don't have an account?<a href="Registration.jsp">SignUp here</a></span>


        </form>

      </div>

    </div>

  </div>


<script src="./static/js/register.js"></script>
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

</body>
</html>
