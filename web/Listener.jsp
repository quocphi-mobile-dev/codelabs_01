
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <meta name="viewport" content="width=device-width, minimum-scale=1.0, initial-scale=1.0, user-scalable=yes">
    <meta name="theme-color" content="#4F7DC9">
    <meta charset="UTF-8">
    <title>Listener</title>
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

<google-codelab title="Listener"
                environment="web"
                feedback-link="">

    <google-codelab-step label="Tạo Project Listener" duration="2">
        <p>Khởi động IntelliJ IDEA, sau đó lựa chọn Create Project  </p>
        <p><img style="max-width: 602.00px" src="img\Firestore\4fcf85a2a56a238c.png"></p>
        <p>Lựa chọn loại ứng dụng Java Enterprise -&gt; Web Application.</p>
        <p>Đặt tên Project là Listener, sau đó bấm Finish</p>


    </google-codelab-step>

    <google-codelab-step label="AppListener" duration="0">
        <p>Tạo class AppListener triển khai từ ServletContextListener</p>
        <pre><code>import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class AppListener implements ServletContextListener {
   @Override
   public void contextDestroyed(ServletContextEvent sce) {
   }

   @Override
   public void contextInitialized(ServletContextEvent sce) {
       ServletContext servletContext = sce.getServletContext();
       Map&lt;String, String&gt; countries = new HashMap&lt;String, String&gt;();
       countries.put(&#34;ca&#34;, &#34;Canada&#34;);
       countries.put(&#34;us&#34;, &#34;United States&#34;);
       servletContext.setAttribute(&#34;countries&#34;, countries);
   }
}</code></pre>
        <p>Tạo file countries.jsp</p>
        <pre><code>&lt;%@ taglib uri=&#34;http://java.sun.com/jsp/jstl/core&#34; prefix=&#34;c&#34; %&gt;
&lt;html&gt;
&lt;head&gt;
 &lt;title&gt;Country List&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
We operate in these countries:
&lt;ul&gt;
 &lt;c:forEach items=&#34;${countries}&#34; var=&#34;country&#34;&gt;
   &lt;li&gt;${country.value}&lt;/li&gt;
 &lt;/c:forEach&gt;
&lt;/ul&gt;
&lt;/body&gt;
&lt;/html&gt;</code></pre>
        <p>Bổ sung khai báo sau vào file web.xml</p>
        <pre><code>&lt;listener&gt;
   &lt;listener-class&gt;AppListener&lt;/listener-class&gt;
&lt;/listener&gt;</code></pre>
        <p>Chạy thử ứng dụng, kiểm tra dữ liệu file countries.jsp xuất ra:</p>
        <p><img style="max-width: 602.00px" src="img\Firestore\5c6847061f165f71.png"></p>


    </google-codelab-step>

    <google-codelab-step label="SessionListener" duration="0">
        <p>Tạo class SessionListener triển khai từ 2 interface HttpSessionListener, và ServletContextListener:</p>
        <pre><code>import java.util.concurrent.atomic.AtomicInteger;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener
public class SessionListener implements HttpSessionListener, ServletContextListener {
   @Override
   public void contextInitialized(ServletContextEvent sce) {
       ServletContext servletContext = sce.getServletContext();
       servletContext.setAttribute(&#34;userCounter&#34;,new AtomicInteger());
   }

   @Override
   public void contextDestroyed(ServletContextEvent sce) {
   }

   @Override
   public void sessionCreated(HttpSessionEvent se) {
       HttpSession session = se.getSession();
       ServletContext servletContext = session.getServletContext();
       AtomicInteger userCounter = (AtomicInteger) servletContext.getAttribute(&#34;userCounter&#34;);
       int userCount = userCounter.incrementAndGet();
       System.out.println(&#34;userCount incremented to :&#34; + userCount);
   }

   @Override
   public void sessionDestroyed(HttpSessionEvent se) {
       HttpSession session = se.getSession();
       ServletContext servletContext = session.getServletContext();
       AtomicInteger userCounter = (AtomicInteger) servletContext.getAttribute(&#34;userCounter&#34;);
       int userCount = userCounter.decrementAndGet();
       System.out.println(&#34;---------- userCount decremented to :&#34; + userCount);
   }
}</code></pre>
        <p>Đăng ký Listener này vào trong web.xml:</p>
        <pre><code>&lt;listener&gt;
   &lt;listener-class&gt;SessionListener&lt;/listener-class&gt;
&lt;/listener&gt;</code></pre>
        <p>Chạy thử và kiểm tra kết quả xuất hiện tại console:</p>
        <p><img style="max-width: 602.00px" src="img\Firestore\2ae65b2e57495652.png"></p>


    </google-codelab-step>

    <google-codelab-step label="Mã nguồn hoàn chỉnh" duration="0">
        <p>Toàn bộ mã nguồn hoàn chỉnh của bài có trên, có thể lấy về tại</p>
        <pre>https://github.com/JavaEEClass/Lab3.git</pre>


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
