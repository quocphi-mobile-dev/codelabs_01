
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <meta name="viewport" content="width=device-width, minimum-scale=1.0, initial-scale=1.0, user-scalable=yes">
    <meta name="theme-color" content="#4F7DC9">
    <meta charset="UTF-8">
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <title>FireStore</title>
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
<bodyunresolved class="fullbleed">

    <google-codelab title="FireStore"
                    environment="web"
                    feedback-link="">

        <google-codelab-step label="Tạo Project HelloFireStore" duration="2">
            <p>Khởi động IntelliJ IDEA, sau đó lựa chọn Create Project  </p>
            <p><img style="max-width: 602.00px" src="img\Firestore\4fcf85a2a56a238c.png"></p>
            <p>Lựa chọn loại ứng dụng <strong>Google App Engine Standard</strong>. Chọn Application Server là <strong>Google App Engine Standard Local Server</strong>.</p>
            <p>Đặt tên Project là HelloFireStore, sau đó bấm Finish</p>


        </google-codelab-step>

        <google-codelab-step label="Thêm thư viện FireStore vào Project" duration="0">
            <p>Vào <strong>Project Structure</strong> - <strong>Libraries - From Maven </strong>để cài thư viện sau</p>
            <pre><code>&lt;dependency&gt;
  &lt;groupId&gt;com.google.firebase&lt;/groupId&gt;
  &lt;artifactId&gt;firebase-admin&lt;/artifactId&gt;
  &lt;version&gt;6.7.0&lt;/version&gt;
&lt;/dependency&gt;</code></pre>
            <aside class="special"><p>Cài thư viện bằng cách paste đoạn mã trên vào ô search rồi bấm OK</p>
            </aside>
            <p><img style="max-width: 602.00px" src="img\Firestore\2df1bc26524f85af.png"></p>
            <p>Đưa thư viện vào module artifacts bằng cách bấm <strong>Fix...</strong>trong mục <strong>Project Structure</strong> - <strong>Artifacts</strong></p>


        </google-codelab-step>

        <google-codelab-step label="Tạo Service Account key" duration="0">
            <p>Vào Google Cloud Console, tạo Project mới (hoặc chọn Project có sẵn) sau đó vào mục <strong>APIs &amp; Services</strong> - <strong>Credentials</strong></p>
            <p><img style="max-width: 442.00px" src="img\Firestore\4874c383e8816151.png"></p>
            <p>Chọn <strong>Create Credentials - Service Account Key. </strong>Tới bước tiếp theo chọn <strong>New Service Account. </strong>Sau đó nhập <strong>Service account name </strong>là tên bất kỳ, còn <strong>Role</strong> chọn <strong>Project</strong> - <strong>Owner</strong></p>
            <p><img style="max-width: 499.00px" src="img\Firestore\375b59879dd431fc.png"></p>
            <p><strong>Key Type </strong>chọn Json sau đó bấm Create. Hệ thống sẽ tạo ra 1 file json và tự động tải về máy. Đổi tên file đó thành<strong> MyCloudKey.json.</strong> Sau đó copy file json đó và đưa vào thư mục <strong>web/WEB-INF</strong></p>
            <p><img style="max-width: 340.00px" src="img\Firestore\b9ab0774758f5f04.png"></p>


        </google-codelab-step>

        <google-codelab-step label="Tạo ServletContextListener" duration="0">
            <p>Tạo 1 servlet có tên <strong>MyServletContextListener </strong>có nội dung như sau:</p>
            <pre><code>import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.FirestoreClient;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

public class MyServletContextListener implements ServletContextListener  {

   @Override
   public void contextInitialized(ServletContextEvent servletContextEvent) {
       GoogleCredentials credentials = null;
       try {
           InputStream serviceAccount = new FileInputStream(&#34;WEB-INF/MyCloudKey.json&#34;);;
           credentials = GoogleCredentials.fromStream(serviceAccount);
           FirebaseOptions options = new FirebaseOptions.Builder()
                   .setCredentials(credentials)
                   .build();
           FirebaseApp.initializeApp(options);
           Firestore db = FirestoreClient.getFirestore();
           ServletContext sc = servletContextEvent.getServletContext();
           sc.setAttribute(&#34;db&#34;, db);
       } catch (IOException e) {
           e.printStackTrace();
       }
   }
   @Override
   public void contextDestroyed(ServletContextEvent servletContextEvent) {
       System.out.println(&#34;Shutting down!&#34;);
   }
}</code></pre>
            <p>Khai báo <strong>MyServletContextListener </strong>trong web.xml như sau:</p>
            <pre><code>&lt;listener&gt;
   &lt;listener-class&gt;
       MyServletContextListener
   &lt;/listener-class&gt;
&lt;/listener&gt;</code></pre>


        </google-codelab-step>

        <google-codelab-step label="Tạo Servlet để ghi dữ liệu" duration="0">
            <p>Tạo server có tên <strong>WriteFireStoreServlet</strong>, với nội dung như sau:</p>
            <pre><code>import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;

public class WriteFireStoreServlet extends HttpServlet {

   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

       Firestore db = (Firestore) getServletContext().getAttribute(&#34;db&#34;);
       DocumentReference docRef = db.collection(&#34;users&#34;).document(&#34;lampx&#34;);
       Map&lt;String, Object&gt; data = new HashMap&lt;&gt;();
       data.put(&#34;first&#34;, &#34;Lam&#34;);
       data.put(&#34;last&#34;, &#34;Pham Xuan&#34;);
       data.put(&#34;born&#34;, 1983);
       try {
           ApiFuture&lt;WriteResult&gt; result = docRef.set(data);
           resp.getWriter().print(&#34;Đã ghi dữ liệu xong, hoàn thành lúc: &#34; + result.get().getUpdateTime());
       } catch (ExecutionException e) {
           e.printStackTrace();
       } catch (InterruptedException e) {
           e.printStackTrace();
       }
   }
}</code></pre>
            <p>Khai báo Servlet trên trong web.xml</p>
            <pre><code>&lt;servlet&gt;
   &lt;servlet-name&gt;write&lt;/servlet-name&gt;
   &lt;servlet-class&gt;WriteFireStoreServlet&lt;/servlet-class&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
   &lt;servlet-name&gt;write&lt;/servlet-name&gt;
   &lt;url-pattern&gt;/write&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;</code></pre>


        </google-codelab-step>

        <google-codelab-step label="Tạo cơ sở dữ liệu" duration="0">
            <p>Tới trang <a href="https://console.firebase.google.com" target="_blank">https://console.firebase.google.com</a>. Chọn project đã tạo và Add Firebase</p>
            <p><img style="max-width: 589.00px" src="img\Firestore\4ccdd883d021ae03.png"></p>
            <p>Chuyển tới mục <strong>Database</strong> và chọn <strong>Create database </strong>(nếu chưa từng tạo trước đó):</p>
            <p><img style="max-width: 602.00px" src="img\Firestore\6a01f22e5704e623.png"></p>
            <p>Chọn<strong> Start in locked mode</strong>, rồi bấm Enable</p>
            <p><img style="max-width: 602.00px" src="img\Firestore\c531b1355baad33c.png"></p>


        </google-codelab-step>

        <google-codelab-step label="Chạy thử chương trình" duration="0">
            <p><img style="max-width: 602.00px" src="img\Firestore\c471a9e1545193e5.png"></p>
            <p>Quay trở lại trang FireStore trên Firebase để xem bản ghi được đẩy vào:</p>
            <p><img style="max-width: 602.00px" src="img\Firestore\18db06e4cf180e66.png"></p>


        </google-codelab-step>

        <google-codelab-step label="Đọc dữ liệu" duration="0">
            <p>Tạo Servlet ReadFireStoreServlet, có nội dung như sau để đọc dữ liệu</p>
            <pre><code>import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

public class ReadFireStoreServlet extends HttpServlet {

   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

       Firestore db = (Firestore) getServletContext().getAttribute(&#34;db&#34;);


       ApiFuture&lt;QuerySnapshot&gt; query = db.collection(&#34;users&#34;).get();
       QuerySnapshot querySnapshot = null;
       try {
           querySnapshot = query.get();

           List&lt;QueryDocumentSnapshot&gt; documents = querySnapshot.getDocuments();
           for (QueryDocumentSnapshot document : documents) {
               System.out.println(&#34;User: &#34; + document.getId());
               System.out.println(&#34;First: &#34; + document.getString(&#34;first&#34;));
               if (document.contains(&#34;middle&#34;)) {
                   System.out.println(&#34;Middle: &#34; + document.getString(&#34;middle&#34;));
               }
               System.out.println(&#34;Last: &#34; + document.getString(&#34;last&#34;));
               System.out.println(&#34;Born: &#34; + document.getLong(&#34;born&#34;));
           }

       } catch (InterruptedException e) {
           e.printStackTrace();
       } catch (ExecutionException e) {
           e.printStackTrace();
       }
   }
}</code></pre>
            <p>Kết quả hiện thị ra console</p>
            <p><img style="max-width: 222.00px" src="img\Firestore\e428f9abfd718d47.png"></p>


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

    </bodyunresolved>
</html>
