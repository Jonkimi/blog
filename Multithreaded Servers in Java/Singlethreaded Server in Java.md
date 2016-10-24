# 单线程服务器Java实现

[原文地址](http://tutorials.jenkov.com/java-multithreaded-servers/singlethreaded-server.html)

本节将展示一个单线程服务器Java实现。单线程服务器Java实现对服务器来说并不是最优的设计，但是其代码能很好的说明一个服务器的生命周期，后续关于多线程服务器的代码也是会以此代码作为模板扩展的。

这是一个简单的单线程服务器的实现代码：

<div class="codehilite"><pre><span class="kn">package</span> <span class="nn">servers</span><span class="o">;</span>

<span class="kn">import</span> <span class="nn">java.net.ServerSocket</span><span class="o">;</span>
<span class="kn">import</span> <span class="nn">java.net.Socket</span><span class="o">;</span>
<span class="kn">import</span> <span class="nn">java.io.IOException</span><span class="o">;</span>
<span class="kn">import</span> <span class="nn">java.io.InputStream</span><span class="o">;</span>
<span class="kn">import</span> <span class="nn">java.io.OutputStream</span><span class="o">;</span>

<span class="kd">public</span> <span class="kd">class</span> <span class="nc">SingleThreadedServer</span> <span class="kd">implements</span> <span class="n">Runnable</span><span class="o">{</span>

    <span class="kd">protected</span> <span class="kt">int</span>          <span class="n">serverPort</span>   <span class="o">=</span> <span class="mi">8080</span><span class="o">;</span>
    <span class="kd">protected</span> <span class="n">ServerSocket</span> <span class="n">serverSocket</span> <span class="o">=</span> <span class="kc">null</span><span class="o">;</span>
    <span class="kd">protected</span> <span class="kt">boolean</span>      <span class="n">isStopped</span>    <span class="o">=</span> <span class="kc">false</span><span class="o">;</span>
    <span class="kd">protected</span> <span class="n">Thread</span>       <span class="n">runningThread</span><span class="o">=</span> <span class="kc">null</span><span class="o">;</span>

    <span class="kd">public</span> <span class="nf">SingleThreadedServer</span><span class="o">(</span><span class="kt">int</span> <span class="n">port</span><span class="o">){</span>
        <span class="k">this</span><span class="o">.</span><span class="na">serverPort</span> <span class="o">=</span> <span class="n">port</span><span class="o">;</span>
    <span class="o">}</span>

    <span class="kd">public</span> <span class="kt">void</span> <span class="nf">run</span><span class="o">(){</span>
        <span class="kd">synchronized</span><span class="o">(</span><span class="k">this</span><span class="o">){</span>
            <span class="k">this</span><span class="o">.</span><span class="na">runningThread</span> <span class="o">=</span> <span class="n">Thread</span><span class="o">.</span><span class="na">currentThread</span><span class="o">();</span>
        <span class="o">}</span>
        <span class="n">openServerSocket</span><span class="o">();</span>
<STRONG><i>
        <span class="k">while</span><span class="o">(!</span> <span class="n">isStopped</span><span class="o">()){</span>
            <span class="n">Socket</span> <span class="n">clientSocket</span> <span class="o">=</span> <span class="kc">null</span><span class="o">;</span>
            <span class="k">try</span> <span class="o">{</span>
                <span class="n">clientSocket</span> <span class="o">=</span> <span class="k">this</span><span class="o">.</span><span class="na">serverSocket</span><span class="o">.</span><span class="na">accept</span><span class="o">();</span>
            <span class="o">}</span> <span class="k">catch</span> <span class="o">(</span><span class="n">IOException</span> <span class="n">e</span><span class="o">)</span> <span class="o">{</span>
                <span class="k">if</span><span class="o">(</span><span class="n">isStopped</span><span class="o">())</span> <span class="o">{</span>
                    <span class="n">System</span><span class="o">.</span><span class="na">out</span><span class="o">.</span><span class="na">println</span><span class="o">(</span><span class="s">&quot;Server Stopped.&quot;</span><span class="o">)</span> <span class="o">;</span>
                    <span class="k">return</span><span class="o">;</span>
                <span class="o">}</span>
                <span class="k">throw</span> <span class="k">new</span> <span class="n">RuntimeException</span><span class="o">(</span>
                    <span class="s">&quot;Error accepting client connection&quot;</span><span class="o">,</span> <span class="n">e</span><span class="o">);</span>
            <span class="o">}</span>
            <span class="k">try</span> <span class="o">{</span>
                <span class="n">processClientRequest</span><span class="o">(</span><span class="n">clientSocket</span><span class="o">);</span>
            <span class="o">}</span> <span class="k">catch</span> <span class="o">(</span><span class="n">IOException</span> <span class="n">e</span><span class="o">)</span> <span class="o">{</span>
                <span class="c1">//log exception and go on to next request.</span>
            <span class="o">}</span>
        <span class="o">}</span>
    </i></STRONG>
        <span class="n">System</span><span class="o">.</span><span class="na">out</span><span class="o">.</span><span class="na">println</span><span class="o">(</span><span class="s">&quot;Server Stopped.&quot;</span><span class="o">);</span>
    <span class="o">}</span>

    <span class="kd">private</span> <span class="kt">void</span> <span class="nf">processClientRequest</span><span class="o">(</span><span class="n">Socket</span> <span class="n">clientSocket</span><span class="o">)</span>
    <span class="kd">throws</span> <span class="n">IOException</span> <span class="o">{</span>
        <span class="n">InputStream</span>  <span class="n">input</span>  <span class="o">=</span> <span class="n">clientSocket</span><span class="o">.</span><span class="na">getInputStream</span><span class="o">();</span>
        <span class="n">OutputStream</span> <span class="n">output</span> <span class="o">=</span> <span class="n">clientSocket</span><span class="o">.</span><span class="na">getOutputStream</span><span class="o">();</span>
        <span class="kt">long</span> <span class="n">time</span> <span class="o">=</span> <span class="n">System</span><span class="o">.</span><span class="na">currentTimeMillis</span><span class="o">();</span>

        <span class="n">output</span><span class="o">.</span><span class="na">write</span><span class="o">((</span><span class="s">&quot;HTTP/1.1 200 OK\n\n&lt;html&gt;&lt;body&gt;&quot;</span> <span class="o">+</span>
                <span class="s">&quot;Singlethreaded Server: &quot;</span> <span class="o">+</span>
                <span class="n">time</span> <span class="o">+</span>
                <span class="s">&quot;&lt;/body&gt;&lt;/html&gt;&quot;</span><span class="o">).</span><span class="na">getBytes</span><span class="o">());</span>
        <span class="n">output</span><span class="o">.</span><span class="na">close</span><span class="o">();</span>
        <span class="n">input</span><span class="o">.</span><span class="na">close</span><span class="o">();</span>
        <span class="n">System</span><span class="o">.</span><span class="na">out</span><span class="o">.</span><span class="na">println</span><span class="o">(</span><span class="s">&quot;Request processed: &quot;</span> <span class="o">+</span> <span class="n">time</span><span class="o">);</span>
    <span class="o">}</span>

    <span class="kd">private</span> <span class="kd">synchronized</span> <span class="kt">boolean</span> <span class="nf">isStopped</span><span class="o">()</span> <span class="o">{</span>
        <span class="k">return</span> <span class="k">this</span><span class="o">.</span><span class="na">isStopped</span><span class="o">;</span>
    <span class="o">}</span>

    <span class="kd">public</span> <span class="kd">synchronized</span> <span class="kt">void</span> <span class="nf">stop</span><span class="o">(){</span>
        <span class="k">this</span><span class="o">.</span><span class="na">isStopped</span> <span class="o">=</span> <span class="kc">true</span><span class="o">;</span>
        <span class="k">try</span> <span class="o">{</span>
            <span class="k">this</span><span class="o">.</span><span class="na">serverSocket</span><span class="o">.</span><span class="na">close</span><span class="o">();</span>
        <span class="o">}</span> <span class="k">catch</span> <span class="o">(</span><span class="n">IOException</span> <span class="n">e</span><span class="o">)</span> <span class="o">{</span>
            <span class="k">throw</span> <span class="k">new</span> <span class="n">RuntimeException</span><span class="o">(</span><span class="s">&quot;Error closing server&quot;</span><span class="o">,</span> <span class="n">e</span><span class="o">);</span>
        <span class="o">}</span>
    <span class="o">}</span>

    <span class="kd">private</span> <span class="kt">void</span> <span class="nf">openServerSocket</span><span class="o">()</span> <span class="o">{</span>
        <span class="k">try</span> <span class="o">{</span>
            <span class="k">this</span><span class="o">.</span><span class="na">serverSocket</span> <span class="o">=</span> <span class="k">new</span> <span class="n">ServerSocket</span><span class="o">(</span><span class="k">this</span><span class="o">.</span><span class="na">serverPort</span><span class="o">);</span>
        <span class="o">}</span> <span class="k">catch</span> <span class="o">(</span><span class="n">IOException</span> <span class="n">e</span><span class="o">)</span> <span class="o">{</span>
            <span class="k">throw</span> <span class="k">new</span> <span class="n">RuntimeException</span><span class="o">(</span><span class="s">&quot;Cannot open port 8080&quot;</span><span class="o">,</span> <span class="n">e</span><span class="o">);</span>
        <span class="o">}</span>
    <span class="o">}</span>
<span class="o">}</span>
</pre></div>

启动服务代码：

```java
SingleThreadedServer server = new SingleThreadedServer(9000);
new Thread(server).start();

try {
    Thread.sleep(10 * 1000);
} catch (InterruptedException e) {
    e.printStackTrace();  
}
System.out.println("Stopping Server");
server.stop();
```

当服务器运行时，你可以用一般的浏览器访问，访问地址是<http://localhost:9000/>

## 服务循环

单线程服务器最有意思的部分是在上面代码中用粗体斜体标出的循环体部分。循环体代码如下：

```java
while(! isStopped()){
     Socket clientSocket = null;
     try {
         clientSocket = this.serverSocket.accept();
     } catch (IOException e) {
        if(isStopped()) {
            System.out.println("Server Stopped.") ;
            return;
        }
        throw new RuntimeException("Error accepting client connection", e);
     }
     try {
         processClientRequest(clientSocket);
     } catch (IOException e) {
         //log exception and go on to next request.
     }
 }
```

间断描述该代码的工作：  
    1. 等待客户端请求  
    2. 处理客户端请求  
    3. 从步骤1开始重复进行  
    
此循环在Java实现的服务器中大多大同小异。单线程服务器与多线程服务器不同在于，单线程服务器只能在一个线程中接受客户端连接并处理客户请求，而多线程服务器则会将客户端连接转交给一个工作线程处理。

在同一个线程中接受客户端连接并处理请求并不是一个好主意。客户端只能在服务端在`serverSocket.accept()`方法调用中时连接到服务器，连接监听线程在`serverSocket.accept()`方法调用外花的时间越长，客户端无法连接到服务器的可能性也越大。这就是多线程服务器要将接受到的连接交给专门用来处理请求的工作线程，这种方式可以让监听线程在`serverSocket.accept()`方法调用外花尽可能少的时间




