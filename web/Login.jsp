
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, initial-scale=1.0, user-scalable=yes">
    <meta name="theme-color" content="#4F7DC9">
    <meta charset="UTF-8">
    <title>Login</title>
    <script src="../../bower_components/webcomponentsjs/webcomponents-lite.js"></script>
    <link rel="import" href="../../elements/codelab.html">
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Source+Code+Pro:400|Roboto:400,300,400italic,500,700|Roboto+Mono">
    <style is="custom-style">
        body {
            font-family: "Roboto",sans-serif;
            background: var(--google-codelab-background, #F8F9FA);
        }
    </style>

</head>
<body unresolved class="fullbleed">

<google-codelab title="Login"
                environment="web"
                feedback-link="">

    <google-codelab-step label="Tạo Project Login" duration="2">
        <p>Khởi động IntelliJ IDEA, sau đó lựa chọn Create Project  </p>
        <p><img style="max-width: 602.00px" src="img\Firestore\4fcf85a2a56a238c.png"></p>
        <p>Lựa chọn loại ứng dụng Java Enterprise -&gt; Web Application.</p>
        <p>Đặt tên Project là Login, sau đó bấm Finish</p>


    </google-codelab-step>

    <google-codelab-step label="Tạo trang Home" duration="0">
        <p>Tạo file _menu.jsp có nội dung sau:</p>
        <pre><code>&lt;a href=&#34;${pageContext.request.contextPath}/employee&#34;&gt;Employee Task&lt;/a&gt;||
&lt;a href=&#34;${pageContext.request.contextPath}/managerTask&#34;&gt;Manager Task&lt;/a&gt;||
&lt;a href=&#34;${pageContext.request.contextPath}/login&#34;&gt;Login&lt;/a&gt;||
&lt;a href=&#34;${pageContext.request.contextPath}/logout&#34;&gt;Logout&lt;/a&gt;
&lt;span style=&#34;color:red&#34;&gt;[ ${loginedUser.userName} ]&lt;/span&gt;</code></pre>
        <p>Tạo file home.jsp có nội dung:</p>
        <pre><code>&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
 &lt;meta charset=&#34;UTF-8&#34;&gt;
 &lt;title&gt;Home Page&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;jsp:include page=&#34;_menu.jsp&#34;&gt;&lt;/jsp:include&gt;
&lt;h3&gt;Home Page&lt;/h3&gt;
&lt;/body&gt;
&lt;/html&gt;</code></pre>
        <p>Tạo package Servlet:</p>
        <p><img style="max-width: 602.00px" src="img\Firestore\999380bd30ecffa6.png"></p>
        <p>Tạo servlet HomeServlet có nội dung như sau:</p>
        <pre><code>package servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({&#34;/&#34;})
public class HomeServlet extends HttpServlet {

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(&#34;/home.jsp&#34;);
       dispatcher.forward(request, response);
   }
}</code></pre>
        <p>Đưa khai báo sau vào web.xml:</p>
        <pre><code>&lt;welcome-file-list&gt;
   &lt;welcome-file&gt;/&lt;/welcome-file&gt;
&lt;/welcome-file-list&gt;</code></pre>
        <p>Chạy thử ứng dụng:</p>


    </google-codelab-step>

    <google-codelab-step label="Tạo trang Login" duration="0">
        <p>Tạo LoginServlet (trong package servlet):</p>
        <pre><code>package servlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(&#34;/login&#34;)
public class LoginServlet extends HttpServlet {

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(&#34;/login.jsp&#34;);
       dispatcher.forward(request, response);
   }
}</code></pre>
        <p>Tạo file login.jsp có nội dung sau:</p>
        <pre><code>&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
   &lt;meta charset=&#34;UTF-8&#34;&gt;
   &lt;title&gt;Login&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;jsp:include page=&#34;_menu.jsp&#34;&gt;&lt;/jsp:include&gt;

&lt;h3&gt;Login Page&lt;/h3&gt;

&lt;p style=&#34;color: red;&#34;&gt;${errorString}&lt;/p&gt;

&lt;form method=&#34;POST&#34; action=&#34;${pageContext.request.contextPath}/login&#34;&gt;
   &lt;input type=&#34;hidden&#34; name=&#34;redirectId&#34; value=&#34;${param.redirectId}&#34;/&gt;
   &lt;table border=&#34;0&#34;&gt;
       &lt;tr&gt;
           &lt;td&gt;User Name&lt;/td&gt;
           &lt;td&gt;&lt;input type=&#34;text&#34; name=&#34;userName&#34; value=&#34;${user.userName}&#34;/&gt;&lt;/td&gt;
       &lt;/tr&gt;
       &lt;tr&gt;
           &lt;td&gt;Password&lt;/td&gt;
           &lt;td&gt;&lt;input type=&#34;password&#34; name=&#34;password&#34; value=&#34;${user.password}&#34;/&gt;&lt;/td&gt;
       &lt;/tr&gt;

       &lt;tr&gt;
           &lt;td colspan=&#34;2&#34;&gt;
               &lt;input type=&#34;submit&#34; value=&#34;Submit&#34;/&gt;
               &lt;a href=&#34;${pageContext.request.contextPath}/&#34;&gt;Cancel&lt;/a&gt;
           &lt;/td&gt;
       &lt;/tr&gt;
   &lt;/table&gt;
&lt;/form&gt;</code></pre>
        <p>Chạy thử ứng dụng</p>
        <p><img style="max-width: 602.00px" src="img\Firestore\66cf992c122dc1a6.png"></p>


    </google-codelab-step>

    <google-codelab-step label="Xử lý submit form Login" duration="0">
        <p>Tạo package model, và thêm class User vào trong package này với nội dung:</p>
        <pre><code>package model;

import java.util.ArrayList;
import java.util.List;

public class User {

   public static final String ROLE_MANAGER = &#34;MANAGER&#34;;
   public static final String ROLE_EMPLOYEE = &#34;EMPLOYEE&#34;;

   private String userName;
   private String password;
   private List&lt;String&gt; roles;

   public User(String userName, String password, String... roles) {
       this.userName = userName;
       this.password = password;

       this.roles = new ArrayList();
       if (roles != null) {
           for (String r : roles) {
               this.roles.add(r);
           }
       }
   }

   public String getUserName() {
       return userName;
   }

   public void setUserName(String userName) {
       this.userName = userName;
   }

   public String getPassword() {
       return password;
   }

   public void setPassword(String password) {
       this.password = password;
   }

   public List&lt;String&gt; getRoles() {
       return roles;
   }

   public void setRoles(List&lt;String&gt; roles) {
       this.roles = roles;
   }
}</code></pre>
        <p>Bổ sung vào LoginServlet đoạn mã sau:</p>
        <pre><code>private static final Map&lt;String, User&gt; mapUsers = new HashMap&lt;String, User&gt;();

   static {
       initUsers();
   }

   private static void initUsers() {
       User emp = new User(&#34;employee1&#34;, &#34;123&#34;, User.ROLE_EMPLOYEE);
       User mng = new User(&#34;manager1&#34;, &#34;123&#34;, User.ROLE_EMPLOYEE, User.ROLE_MANAGER);
       mapUsers.put(emp.getUserName(), emp);
       mapUsers.put(mng.getUserName(), mng);
   }

   // Tìm kiếm người dùng theo userName và password.
   public static User findUser(String userName, String password) {
       User u = mapUsers.get(userName);
       if (u != null &amp;&amp; u.getPassword().equals(password)) {
           return u;
       }
       return null;
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       String userName = request.getParameter(&#34;userName&#34;);
       String password = request.getParameter(&#34;password&#34;);
       User userAccount = findUser(userName, password);

       //  SecurityFilter securityFilter = new SecurityFilter();
       if (userAccount == null) {
           String errorString = &#34;Invalid userName or Password&#34;;
           request.setAttribute(&#34;errorString&#34;, errorString);
           RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(&#34;/login.jsp&#34;);
           dispatcher.forward(request, response);
           return;
       }else{
           //Dang nhap thanh cong
           request.getSession().setAttribute(&#34;loginedUser&#34;, userAccount);
       }
   }</code></pre>
        <p>Chạy thử ứng dụng, nhập thử một id và password bất kỳ, hệ thống sẽ báo lỗi như sau:</p>
        <p><img style="max-width: 602.00px" src="img\Firestore\b5fb264b1d2bdcce.png"></p>
        <p>Thử đăng nhập đúng với tài khoản employee1 / 123</p>


    </google-codelab-step>

    <google-codelab-step label="Chức năng Logout" duration="0">
        <p>Tạo Servlet LogoutServlet:</p>
        <pre><code>package servlet;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(&#34;/logout&#34;)
public class LogoutServlet extends HttpServlet {

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

       request.getSession().invalidate();
       response.sendRedirect(request.getContextPath() + &#34;/login&#34;);
   }
}</code></pre>
        <p>Thực hiện đăng nhập sau đó bấm logout, ứng dụng sẽ đăng xuất và quay trở về trang đăng nhập:</p>
        <p><img style="max-width: 602.00px" src="img\Firestore\6b0c73263f77bece.png"></p>


    </google-codelab-step>

    <google-codelab-step label="Tạo các trang riêng cho Employee" duration="0">
        <p>Tạo Servlet EmployeeServlet:</p>
        <pre><code>package servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(&#34;/employee&#34;)
public class EmployeeServlet extends HttpServlet {

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(&#34;/employee.jsp&#34;);
       dispatcher.forward(request, response);
   }
}</code></pre>
        <p>Tạo file employee.jsp:</p>
        <pre><code>&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
   &lt;meta charset=&#34;UTF-8&#34;&gt;
   &lt;title&gt;Employee Task&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;jsp:include page=&#34;_menu.jsp&#34;&gt;&lt;/jsp:include&gt;

&lt;h3&gt;Employee Task&lt;/h3&gt;

Hello, This is a protected page!

&lt;/body&gt;
&lt;/html&gt;</code></pre>
        <p>Không đăng nhập và vào trang <a href="http://localhost:8080/employee" target="_blank">http://localhost:8080/employee</a> để kiểm tra kết quả:</p>
        <p><img style="max-width: 602.00px" src="img\Firestore\4526fa01bdacf5ec.png"></p>
        <p>Bước tiếp theo sẽ tạo filter để ngăn việc vào trang trên khi không đăng nhập.</p>


    </google-codelab-step>

    <google-codelab-step label="Điều hướng khi đăng nhập thành công" duration="0">
        <p>Tạo package utils và bổ sung các class dưới đây:</p>
        <p>Class AppUtils</p>
        <pre><code>package utils;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;


public class AppUtils {

   private static int REDIRECT_ID = 0;

   private static final Map&lt;Integer, String&gt; id_uri_map = new HashMap&lt;Integer, String&gt;();
   private static final Map&lt;String, Integer&gt; uri_id_map = new HashMap&lt;String, Integer&gt;();

   public static int storeRedirectAfterLoginUrl(HttpSession session, String requestUri) {
       Integer id = uri_id_map.get(requestUri);
       if (id == null) {
           id = REDIRECT_ID++;
           uri_id_map.put(requestUri, id);
           id_uri_map.put(id, requestUri);
           return id;
       }

       return id;
   }

   public static String getRedirectAfterLoginUrl(HttpSession session, int redirectId) {
       String url = id_uri_map.get(redirectId);
       if (url != null) {
           return url;
       }
       return null;
   }
}</code></pre>
        <p>Class SecurityConfig</p>
        <pre><code>package utils;

import java.util.ArrayList;
import java.util.*;

public class SecurityConfig {

   public static final String ROLE_MANAGER = &#34;MANAGER&#34;;
   public static final String ROLE_EMPLOYEE = &#34;EMPLOYEE&#34;;

   // String: Role
   // List&lt;String&gt;: urlPatterns.
   private static final Map&lt;String, List&lt;String&gt;&gt; mapConfig = new HashMap&lt;String, List&lt;String&gt;&gt;();

   static {
       init();
   }

   private static void init() {

       // Cấu hình cho vai trò &#34;EMPLOYEE&#34;.
       List&lt;String&gt; urlPatterns1 = new ArrayList&lt;String&gt;();

       urlPatterns1.add(&#34;/userInfo&#34;);
       urlPatterns1.add(&#34;/employee&#34;);

       mapConfig.put(ROLE_EMPLOYEE, urlPatterns1);

       // Cấu hình cho vai trò &#34;MANAGER&#34;.
       List&lt;String&gt; urlPatterns2 = new ArrayList&lt;String&gt;();

       urlPatterns2.add(&#34;/userInfo&#34;);
       urlPatterns2.add(&#34;/managerTask&#34;);

       mapConfig.put(ROLE_MANAGER, urlPatterns2);
   }

   public static Set&lt;String&gt; getAllAppRoles() {
       return mapConfig.keySet();
   }

   public static List&lt;String&gt; getUrlPatternsForRole(String role) {
       return mapConfig.get(role);
   }

}</code></pre>
        <p>Class SecurityUtils</p>
        <pre><code>package utils;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;


public class SecurityUtils {

   // Kiểm tra &#39;request&#39; này có bắt buộc phải đăng nhập hay không.
   public static boolean isSecurityPage(HttpServletRequest request) {
       String urlPattern = UrlPatternUtils.getUrlPattern(request);

       Set&lt;String&gt; roles = SecurityConfig.getAllAppRoles();

       for (String role : roles) {
           List&lt;String&gt; urlPatterns = SecurityConfig.getUrlPatternsForRole(role);
           if (urlPatterns != null &amp;&amp; urlPatterns.contains(urlPattern)) {
               return true;
           }
       }
       return false;
   }

   // Kiểm tra &#39;request&#39; này có vai trò phù hợp hay không?
   public static boolean hasPermission(HttpServletRequest request) {
       String urlPattern = UrlPatternUtils.getUrlPattern(request);

       Set&lt;String&gt; allRoles = SecurityConfig.getAllAppRoles();

       for (String role : allRoles) {
           if (!request.isUserInRole(role)) {
               continue;
           }
           List&lt;String&gt; urlPatterns = SecurityConfig.getUrlPatternsForRole(role);
           if (urlPatterns != null &amp;&amp; urlPatterns.contains(urlPattern)) {
               return true;
           }
       }
       return false;
   }
}</code></pre>
        <p>Class UrlPatternUtils</p>
        <pre><code>package utils;

import java.util.Collection;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletRegistration;
import javax.servlet.http.HttpServletRequest;

public class UrlPatternUtils {

   private static boolean hasUrlPattern(ServletContext servletContext, String urlPattern) {

       Map&lt;String, ? extends ServletRegistration&gt; map = servletContext.getServletRegistrations();

       for (String servletName : map.keySet()) {
           ServletRegistration sr = map.get(servletName);

           Collection&lt;String&gt; mappings = sr.getMappings();
           if (mappings.contains(urlPattern)) {
               return true;
           }

       }
       return false;
   }


   public static String getUrlPattern(HttpServletRequest request) {
       ServletContext servletContext = request.getServletContext();
       String servletPath = request.getServletPath();
       String pathInfo = request.getPathInfo();

       String urlPattern = null;
       if (pathInfo != null) {
           urlPattern = servletPath + &#34;/*&#34;;
           return urlPattern;
       }
       urlPattern = servletPath;

       boolean has = hasUrlPattern(servletContext, urlPattern);
       if (has) {
           return urlPattern;
       }
       int i = servletPath.lastIndexOf(&#39;.&#39;);
       if (i != -1) {
           String ext = servletPath.substring(i + 1);
           urlPattern = &#34;*.&#34; + ext;
           has = hasUrlPattern(servletContext, urlPattern);

           if (has) {
               return urlPattern;
           }
       }
       return &#34;/&#34;;
   }
}</code></pre>
        <p>Class UserRoleRequestWrapper:</p>
        <pre><code>package utils;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;


public class UserRoleRequestWrapper extends HttpServletRequestWrapper {

   private String user;
   private List&lt;String&gt; roles = null;
   private HttpServletRequest realRequest;

   public UserRoleRequestWrapper(String user, List&lt;String&gt; roles, HttpServletRequest request) {
       super(request);
       this.user = user;
       this.roles = roles;
       this.realRequest = request;
   }

   @Override
   public boolean isUserInRole(String role) {
       if (roles == null) {
           return this.realRequest.isUserInRole(role);
       }
       return roles.contains(role);
   }

   @Override
   public Principal getUserPrincipal() {
       if (this.user == null) {
           return realRequest.getUserPrincipal();
       }

       // Make an anonymous implementation to just return our user
       return new Principal() {
           @Override
           public String getName() {
               return user;
           }
       };
   }
}</code></pre>
        <p>Tạo class SecurityFilter (trong package filter), có nội dung như sau:</p>
        <pre><code>package filter;

import model.User;
import utils.AppUtils;
import utils.SecurityUtils;
import utils.UserRoleRequestWrapper;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebFilter(&#34;/*&#34;)
public class SecurityFilter implements Filter {

   public SecurityFilter() {
   }

   @Override
   public void destroy() {
   }

   @Override
   public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
       HttpServletRequest request = (HttpServletRequest) req;
       HttpServletResponse response = (HttpServletResponse) resp;

       String servletPath = request.getServletPath();

       // Thông tin người dùng đã được lưu trong Session
       // (Sau khi đăng nhập thành công).
       User loginedUser = AppUtils.getLoginedUser(request.getSession());

       if (servletPath.equals(&#34;/login&#34;)) {
           chain.doFilter(request, response);
           return;
       }
       HttpServletRequest wrapRequest = request;

       if (loginedUser != null) {
           // User Name
           String userName = loginedUser.getUserName();

           // Các vai trò (Role).
           List&lt;String&gt; roles = loginedUser.getRoles();

           // Gói request cũ bởi một Request mới với các thông tin userName và Roles.
           wrapRequest = new UserRoleRequestWrapper(userName, roles, request);
       }

       // Các trang bắt buộc phải đăng nhập.
       if (SecurityUtils.isSecurityPage(request)) {

           // Nếu người dùng chưa đăng nhập,
           // Redirect (chuyển hướng) tới trang đăng nhập.
           if (loginedUser == null) {
               String requestUri = request.getRequestURI();
               // Lưu trữ trang hiện tại để redirect đến sau khi đăng nhập thành công.
               int redirectId = AppUtils.storeRedirectAfterLoginUrl(request.getSession(), requestUri);
               response.sendRedirect(wrapRequest.getContextPath() + &#34;/login?redirectId=&#34; + redirectId);
               return;
           }

           // Kiểm tra người dùng có vai trò hợp lệ hay không?
           boolean hasPermission = SecurityUtils.hasPermission(wrapRequest);
           if (!hasPermission) {

               RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher(&#34;/accessDenied.jsp&#34;);

               dispatcher.forward(request, response);
               return;
           }
       }

       chain.doFilter(wrapRequest, response);
   }

   @Override
   public void init(FilterConfig fConfig) throws ServletException {

   }

}</code></pre>
        <p>Tiến hành không đăng nhập và vào thử trang <a href="http://localhost:8080/employee" target="_blank">http://localhost:8080/employee</a> để kiểm tra kết quả. Sẽ thấy trang bị redirect về trang login.</p>
        <p><img style="max-width: 602.00px" src="img\Firestore\80e5a2625f783f4e.png"></p>
        <p>Kiểm tra lại với tài khoản đúng: <strong>employee1</strong>, password: <strong>123:</strong></p>
        <p><img style="max-width: 602.00px" src="img\Firestore\3a1c1084d0c8d577.png"></p>
        <p>Sau khi đăng nhập trang sẽ tự động chuyển sang trang Employee</p>
        <p><img style="max-width: 602.00px" src="img\Firestore\1b45aa6f75310cdf.png"></p>


    </google-codelab-step>

    <google-codelab-step label="Tạo trang riêng cho Manager" duration="0">
        <p>Tạo Servlet ManagerServlet:</p>
        <pre><code>package servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(&#34;/managerTask&#34;)
public class ManagerServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;

   public ManagerServlet() {
       super();
   }

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {

       RequestDispatcher dispatcher //
               = this.getServletContext()//
               .getRequestDispatcher(&#34;/managertask.jsp&#34;);

       dispatcher.forward(request, response);
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {

       doGet(request, response);
   }

}</code></pre>
        <p>Tạo file managertask.jsp:</p>
        <pre><code>&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
   &lt;meta charset=&#34;UTF-8&#34;&gt;
   &lt;title&gt;Manager Task&lt;/title&gt;
&lt;/head&gt;

&lt;body&gt;

&lt;jsp:include page=&#34;_menu.jsp&#34;&gt;&lt;/jsp:include&gt;

&lt;h3&gt;Manager Task&lt;/h3&gt;

Hello, This is a protected page!

&lt;/body&gt;
&lt;/html&gt;</code></pre>
        <p>Bổ sung thêm trang accessDenied.jsp:</p>
        <pre><code>&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
   &lt;meta charset=&#34;UTF-8&#34;&gt;
   &lt;title&gt;Access Denied&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;jsp:include page=&#34;_menu.jsp&#34;&gt;&lt;/jsp:include&gt;

&lt;br/&gt;&lt;br/&gt;

&lt;h3 style=&#34;color:red;&#34;&gt;Access Denied!&lt;/h3&gt;

&lt;/body&gt;
&lt;/html&gt;</code></pre>
        <p>Thực hiện đăng nhập với tài khoản <strong>employee1 / 123</strong> sau đó vào trang của Manager</p>
        <p><img style="max-width: 602.00px" src="img\Firestore\1ad1fa985f5d9dec.png"></p>
        <p>Đăng nhập lại với tài khoản manager và vào lại trang này</p>
        <p><img style="max-width: 602.00px" src="img\Firestore\ae92e17cf7975bdc.png"></p>


    </google-codelab-step>

    <google-codelab-step label="Mã nguồn hoàn chỉnh" duration="0">
        <p>Ứng dụng hoàn chỉnh sẽ có các file như sau:</p>
        <p><img style="max-width: 320.88px" src="img\Firestore\7defb098bd6f45ba.png"></p>
        <p>Toàn bộ mã nguồn hoàn chỉnh của bài có trên, có thể lấy về tại</p>
        <pre>https://github.com/JavaEEClass/Login.git</pre>


    </google-codelab-step>

</google-codelab>

<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
    ga('create', 'UA-49880327-14', 'auto');

    (function() {
        var gaCodelab = '';
        if (gaCodelab) {
            ga('create', gaCodelab, 'auto', {name: 'codelab'});
        }

        var gaView;
        var parts = location.search.substring(1).split('&');
        for (var i = 0; i < parts.length; i++) {
            var param = parts[i].split('=');
            if (param[0] === 'viewga') {
                gaView = param[1];
                break;
            }
        }
        if (gaView && gaView !== gaCodelab) {
            ga('create', gaView, 'auto', {name: 'view'});
        }
    })();
</script>

</body>
</html>
